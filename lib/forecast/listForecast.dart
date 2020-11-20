
import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:http/http.dart' as http;
import 'package:weatherapp/forecast/fullForecast.dart';
import 'package:weatherapp/pojo/weatherPojo.dart';

class Forecast extends StatefulWidget {
  @override
  HomeState createState() => new HomeState();
}

class HomeState extends State<Forecast> {

  @override
  void initState() {
    // TODO: implement initState

    fetchSavedCord();

  }
  String lat;
  String lng;
  var location = Location();
  SharedPreferences prefs;
  var data;
  var topHeight;
  Map<String, dynamic> responseData;
  
  fetchSavedCord() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      lat = prefs.getString('lat');
      lng = prefs.getString('lng');
      print(lat);
      print(lng);

      weatherState = _fetchWeather();
    });
  }


  Future<List<weather>> weatherState;
  Future<List<weather>> _fetchWeather() async {
    final response = await http.get(
      'https://api.openweathermap.org/data/2.5/onecall?lat=$lat&lon=$lng&exclude=alerts&appid=40bb52e19ff5ceb29886d814e341cb8c',
    );

    if (response.statusCode == 200) {
      responseData = json.decode(response.body);
      data = responseData['daily'];
      print(data);
      final items = data.cast<Map<String, dynamic>>();
      List<weather> listOfUsers = items.map<weather>((json) {
        return weather.fromJson(json);
      }).toList();
      return listOfUsers;
    }

    else {
      var sa = response.body;
      responseData = json.decode(response.body);
      var er = responseData['message'];
      print('error$er');
      print(sa);
      throw Exception('Failed to load internet');
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body:
      Container(
        padding: EdgeInsets.all(20),
        child:
        ListView(
            children: <Widget>[
              Text('Tap the fetch location button to get your coordinates', style: TextStyle(color: Colors.black, fontSize: 15,),),

              SizedBox(height: 20,),
              Flex(direction: Axis.horizontal, children: [
                Expanded(
                  child: FutureBuilder<List<weather>>(
                      future: weatherState,
                      builder: (context, snapshot) {
                        if (!snapshot.hasData)
                          return
                            Container(
                                padding: EdgeInsets.all(20.0),
                                child:Center(
                                  child: Shimmer.fromColors(
                                      direction: ShimmerDirection.ltr,
                                      period: Duration(seconds:2),
                                      child: Column(
                                        children: [0, 1, 2, 3,4,5,6]
                                            .map((_) => Padding(
                                          padding: const EdgeInsets.only(bottom: 8.0),
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                height: 150,
                                                color: Colors.white,
                                              ),
                                              Padding(
                                                padding:
                                                const EdgeInsets.symmetric(horizontal: 8.0),
                                              ),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      width: double.infinity,
                                                      height: 8.0,
                                                      color: Colors.white,
                                                    ),
                                                    Padding(
                                                      padding:
                                                      const EdgeInsets.symmetric(vertical: 2.0),
                                                    ),
                                                    Container(
                                                      width: double.infinity,
                                                      height: 8.0,
                                                      color: Colors.white,
                                                    ),
                                                    Padding(
                                                      padding:
                                                      const EdgeInsets.symmetric(vertical: 2.0),
                                                    ),
                                                    Container(
                                                      width: 40.0,
                                                      height: 8.0,
                                                      color: Colors.white,
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ))
                                            .toList(),
                                      ),
                                      baseColor: Colors.grey,
                                      highlightColor: Colors.white),
                                )
                            );

                        return
                          Container(
                            height: deviceHeight/1.25,
                            child:
                            ListView(
                              //scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              children: snapshot.data
                                  .map(
                                    (feed) => InkWell(
                                  onTap: () {
                                    gotoFull(context,
                                       date: feed.day);
                                  },
                                  child:
                                  Container(
                                    padding: EdgeInsets.all(20),
                                    child:
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [

                                                  Text(
                                                    'Minimum Temperature',
                                                    style: TextStyle(
                                                      fontWeight:
                                                      FontWeight.w500,
                                                      fontSize: 15.0,
                                                      color: Colors.black,
                                                    ),
                                                ),

                                                  Text(
                                                    '${feed.minTemp}',
                                                    style: TextStyle(
                                                      fontWeight:
                                                      FontWeight.w800,
                                                      fontSize: 18.0,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                              ],),

                                            Divider(),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [

                                                  Text(
                                                    'Maximum Temperature',
                                                    style: TextStyle(
                                                      fontWeight:
                                                      FontWeight.w500,
                                                      fontSize: 15.0,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                  Text(
                                                    '${feed.maxTemp}',
                                                    style: TextStyle(
                                                      fontWeight:
                                                      FontWeight.w800,
                                                      fontSize: 18.0,
                                                      color: Colors.black,
                                                    ),
                                                  ),

                                              ],),

                                            Divider(),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [

                                                  Text(
                                                    'Wind Speed',
                                                    style: TextStyle(
                                                      fontWeight:
                                                      FontWeight.w500,
                                                      fontSize: 15.0,
                                                      color: Colors.black,
                                                    ),
                                                  ),

                                                  Text(
                                                    '${feed.windSpeed}',
                                                    style: TextStyle(
                                                      fontWeight:
                                                      FontWeight.w800,
                                                      fontSize: 18.0,
                                                      color: Colors.black,
                                                    ),


                                                ),
                                              ],),

                                            Divider(),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [

                                                  Text(
                                                    'Date',
                                                    style: TextStyle(
                                                      fontWeight:
                                                      FontWeight.w500,
                                                      fontSize: 15.0,
                                                      color: Colors.black,
                                                    ),
                                                  ),

                                                  Text(
                                                    '${DateTime.fromMillisecondsSinceEpoch(feed.day *1000).day}/${DateTime.fromMillisecondsSinceEpoch(feed.day *1000).month}/${DateTime.fromMillisecondsSinceEpoch(feed.day *1000).year}',
                                                    style: TextStyle(
                                                      fontWeight:
                                                      FontWeight.w800,
                                                      fontSize: 18.0,
                                                      color: Colors.black,
                                                    ),


                                                ),
                                              ],),

                                            Divider(),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [

                                                  Text(
                                                    'Cloud percentage',
                                                    style: TextStyle(
                                                      fontWeight:
                                                      FontWeight.w500,
                                                      fontSize: 15.0,
                                                      color: Colors.black,
                                                    ),

                                                ),

                                                  Text(
                                                    '${feed.cloudPercentage}',
                                                    style: TextStyle(
                                                      fontWeight:
                                                      FontWeight.w800,
                                                      fontSize: 18.0,
                                                      color: Colors.black,
                                                    ),
                                                ),
                                              ],),

                                            Divider(),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [

                                                  Text(
                                                    'Humidity',
                                                    style: TextStyle(
                                                      fontWeight:
                                                      FontWeight.w500,
                                                      fontSize: 15.0,
                                                      color: Colors.black,
                                                    ),
                                                  ),


                                                  Text(
                                                    '${feed.humidity}',
                                                    style: TextStyle(
                                                      fontWeight:
                                                      FontWeight.w800,
                                                      fontSize: 18.0,
                                                      color: Colors.black,
                                                    ),

                                                ),
                                              ],),

                                          ],
                                        )


                                  ),
                                ),
                              )
                                  .toList(),
                            ),
                          );
                      }),
                ),
              ]),

            ],
        ),
      ),

    );
  }
  gotoFull(BuildContext context,
      {int date}) {
    Navigator.push(
        context,
        PageRouteBuilder(
            transitionDuration: Duration(milliseconds: 500),
            pageBuilder: (_, __, ___) => FullForecast(
                date: date,)));
  }
}



