import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


class FullForecast extends StatefulWidget {
  final int date;

  const FullForecast({Key key, this.date}) : super(key: key);
  @override
  HomeState createState() => new HomeState(this.date);
}

class HomeState extends State<FullForecast> {
  // Parameters initialized
  final int date;
  String lat;
  String lng;
  var location = Location();
  SharedPreferences prefs;
  var data;
  Map<String, dynamic> responseData;
  double minTemp;
  double maxTemp;
  double windSpeed;
  int day;
  int cloudPercentage;
  int humidity;

  HomeState(this.date);
  @override
  void initState() {
    // TODO: implement initState
    fetchSavedCord();
  }

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
    print(date);
  }

  // this fetches the weather details API
  _fetchWeather() async {
    final response = await http.get(
      'https://api.openweathermap.org/data/2.5/onecall/timemachine?lat=$lat&lon=$lng&dt=$date&appid=40bb52e19ff5ceb29886d814e341cb8c',
    );

    if (response.statusCode == 200) {
      responseData = json.decode(response.body);
      setState(() {
        data = responseData['current'];
        print(data);
        minTemp = data['temp'];
        print(minTemp);
        maxTemp = data['temp'];
        windSpeed = data['wind_speed'];
        day = data['dt'];
        cloudPercentage = data['clouds'];
        humidity = data['humidity'];
      });
    } else {
      var sa = response.body;
      responseData = json.decode(response.body);
      var er = responseData['message'];
      print('error$er');
      print(sa);
      Fluttertoast.showToast(msg: '$er');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(2),
        child: ListView(children: <Widget>[
SizedBox(height: 20,),
          Text(
            'A day weather forecast',
            style: TextStyle(
              color: Colors.black,
              fontSize: 15,
              fontWeight: FontWeight.bold
            ),
          ),
          SizedBox(height: 20,),
              Card(
                elevation: 3,
                child:
                Container(
                    padding: EdgeInsets.all(5),
                    margin: EdgeInsets.all(10),

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
                          fontWeight: FontWeight.w500,
                          fontSize: 15.0,
                          color: Colors.redAccent,
                        ),
                      ),
                      SizedBox(width: 20,),
                      Text(
                        minTemp != null?  '$minTemp':'',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 18.0,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Maximum Temperature',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 15.0,
                          color: Colors.redAccent,
                        ),
                      ),
                      SizedBox(width: 20,),
                      Text(
                        maxTemp != null? '$maxTemp':'',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 18.0,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                        windSpeed  != null? '$windSpeed':'',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 18.0,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Date',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 15.0,
                          color: Colors.redAccent,
                        ),
                      ),
                      SizedBox(width: 20,),
                      day != null
                          ? Text(
                              '${DateTime.fromMillisecondsSinceEpoch(day * 1000).day}/${DateTime.fromMillisecondsSinceEpoch(day * 1000).month}/${DateTime.fromMillisecondsSinceEpoch(day * 1000).year}',
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 18.0,
                                color: Colors.black,
                              ),
                            )
                          : Text(''),
                    ],
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                        cloudPercentage != null? '$cloudPercentage%': '',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 18.0,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                        humidity != null?  '$humidity': '',
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
        ]),

      ),
    );
  }
}
