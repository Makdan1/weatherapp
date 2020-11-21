import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:http/http.dart' as http;
import 'package:weatherapp/forecast/fullForecast.dart';
import 'package:weatherapp/models/weatherPojo.dart';


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

  // Parameters initialized
  String lat;
  String lng;
  var location = Location();
  SharedPreferences prefs;
  var data;
  var topHeight;
  Map<String, dynamic> responseData;

  //function to fetch the coordinates from Shared preference
  fetchSavedCord() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      lat = prefs.getString('lat');
      lng = prefs.getString('lng');
      print(lat);
      print(lng);
  _fetchWeather();
    });
  }

  // this fetches the Weather details API

  Future<List<Weather>> _fetchWeather() async {
    final response = await http.get(
      'https://api.openWeathermap.org/data/2.5/onecall?lat=$lat&lon=$lng&exclude=alerts&appid=40bb52e19ff5ceb29886d814e341cb8c',
    );

    if (response.statusCode == 200) {
      responseData = json.decode(response.body);
      data = responseData['daily'];
      print(data);
      final items = data.cast<Map<String, dynamic>>();
      List<Weather> listOfUsers = items.map<Weather>((json) {
        return Weather.fromJson(json);
      }).toList();
      return listOfUsers;
    } else {
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
      backgroundColor: Colors.blueAccent,
      body: Container(
        padding: EdgeInsets.all(20),
        child: ListView(
          children: <Widget>[

            Text(
              '7 days weather forecast',
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.bold
              ),
            ),

            SizedBox(
              height: 20,
            ),
            Flex(direction: Axis.horizontal, children: [
              Expanded(
                child: FutureBuilder<List<Weather>>(
                    future: _fetchWeather(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData)
                        return Container(
                            padding: EdgeInsets.all(20.0),
                            child: Center(
                              child: Shimmer.fromColors(
                                  direction: ShimmerDirection.ltr,
                                  period: Duration(seconds: 2),
                                  child: Column(
                                    children: [0, 1, 2, 3, 4, 5, 6]
                                        .map((_) => Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 8.0),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    height: 150,
                                                    color: Colors.white,
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 8.0),
                                                  ),
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          width:
                                                              double.infinity,
                                                          height: 8.0,
                                                          color: Colors.white,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  vertical:
                                                                      2.0),
                                                        ),
                                                        Container(
                                                          width:
                                                              double.infinity,
                                                          height: 8.0,
                                                          color: Colors.white,
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  vertical:
                                                                      2.0),
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
                            ));

                      return Container(
                        height: deviceHeight/1.2,
                        child: ListView(
                          //scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          children: snapshot.data
                              .map(
                                (feed) => InkWell(
                                  onTap: () {
                                    gotoFull(context, date: feed.day,minTemp:  feed.minTemp,
                                      maxTemp:  feed.maxTemp,
                                      windSpeed: feed.windSpeed,
                                      cloudPercentage: feed.cloudPercentage,
                                      humidity: feed.humidity,);
                                  },
                                  child:
                        Card(
                          elevation: 3,
                          child:  Container(
                                      padding: EdgeInsets.all(5),
                                      margin: EdgeInsets.all(10),

                                      child:
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [

                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Column(
                                                children: [
                                                  Text(
                                                    'Min Temp.',
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 15.0,
                                                      color: Colors.redAccent,
                                                    ),
                                                  ),
                                                  SizedBox(height: 10,),
                                                  Text(
                                                    '${feed.minTemp}',
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.w800,
                                                      fontSize: 18.0,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ],
                                              ),

                                              SizedBox(width: 20,),
                                              Container(
                                                height:100,
                                                width: 100,
                                                padding: EdgeInsets.all(5),
                                                margin: EdgeInsets.all(10),

                                                child:
                                                Image(image:  AssetImage("images/weatherList.png"),),
                                              ),
                                              Column(
                                                children: [
                                                  Text(
                                                    'Min Temp.',
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 15.0,
                                                      color: Colors.redAccent,
                                                    ),
                                                  ),
                                                  SizedBox(height: 10,),
                                              Text(
                                                '${feed.maxTemp}',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w800,
                                                  fontSize: 18.0,
                                                  color: Colors.black,
                                                ),
                                              ),
]
                                              )
                                            ],
                                          ),
                                          Divider(color: Colors.purple,),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Icon(
                                                  Icons.run_circle_outlined
                                              ),
                                              SizedBox(width: 20,),
                                              Text(
                                                'Wind Speed',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 15.0,
                                                  color: Colors.redAccent,
                                                ),
                                              ),
                                              SizedBox(width: 20,),
                                              Text(
                                                '${feed.windSpeed}',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 18.0,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Divider(color: Colors.purple,),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Icon(
                                                  Icons.calendar_today_outlined
                                              ),
                                              SizedBox(width: 20,),
                                              Text(
                                                'Date',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 15.0,
                                                  color: Colors.redAccent,
                                                ),
                                              ),
                                              SizedBox(width: 20,),
                                              Text(
                                                '${DateTime.fromMillisecondsSinceEpoch(feed.day * 1000).day}/${DateTime.fromMillisecondsSinceEpoch(feed.day * 1000).month}/${DateTime.fromMillisecondsSinceEpoch(feed.day * 1000).year}',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 18.0,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Divider(color: Colors.purple,),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Icon(
                                                  Icons.cloud_circle_rounded
                                              ),
                                              SizedBox(width: 20,),
                                              Text(
                                                'Cloud percentage',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 15.0,
                                                  color: Colors.redAccent,
                                                ),
                                              ),
                                              SizedBox(width: 20,),
                                              Text(
                                                '${feed.cloudPercentage}%',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w800,
                                                  fontSize: 18.0,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Divider(color: Colors.purple,),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Icon(
                                                  Icons.ten_mp
                                              ),
                                              SizedBox(width: 20,),
                                              Text(
                                                'Humidity',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 15.0,
                                                  color: Colors.redAccent,
                                                ),
                                              ),
                                              SizedBox(width: 20,),
                                              Text(
                                                '${feed.humidity}',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w800,
                                                  fontSize: 18.0,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      )),
                                ),
                              )
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
// this takes the date of the selected item to the next page
  gotoFull(BuildContext context, {int date,   double  minTemp,
  double  maxTemp,
  var windSpeed,
  int day,
  int cloudPercentage,
  int humidity,}) {
    Navigator.push(
        context,
        PageRouteBuilder(
            transitionDuration: Duration(milliseconds: 500),
            pageBuilder: (_, __, ___) => FullForecast(
                  date: date,minTemp:  minTemp,
              maxTemp:  maxTemp,
              windSpeed: windSpeed,
              cloudPercentage: cloudPercentage,
              humidity: humidity,
                )));
  }
}
