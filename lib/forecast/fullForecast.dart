import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


class FullForecast extends StatefulWidget {
  final int date;
  final double  minTemp;
  final double  maxTemp;
  final double  windSpeed;
  final int cloudPercentage;
  final int humidity;

  const FullForecast({Key key, this.date, this.minTemp, this.maxTemp, this.windSpeed, this.cloudPercentage, this.humidity,}) : super(key: key);
  @override
  HomeState createState() => new HomeState(this.date,this.minTemp, this.maxTemp, this.windSpeed, this.cloudPercentage, this.humidity,);
}

class HomeState extends State<FullForecast> {
  // Parameters initialized
  final int date;
  final double  minTemp;
  final double  maxTemp;
  final double  windSpeed;
  final int cloudPercentage;
  final int humidity;
  String lat;
  String lng;
  var location = Location();
  SharedPreferences prefs;
  var data;
  Map<String, dynamic> responseData;

  int day;


  HomeState(this.date,this.minTemp, this.maxTemp, this.windSpeed, this.cloudPercentage, this.humidity);



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Container(
        padding: EdgeInsets.all(2),
        child: ListView(children: <Widget>[
SizedBox(height: 20,),
          Text(
            'A day weather forecast',
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.bold
            ),
          ),
          SizedBox(height: 20,),
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
                              '$minTemp',
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
                                '$maxTemp',
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
                          '$windSpeed',
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
                          '${DateTime.fromMillisecondsSinceEpoch(date * 1000).day}/${DateTime.fromMillisecondsSinceEpoch(date * 1000).month}/${DateTime.fromMillisecondsSinceEpoch(date * 1000).year}',
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
                          '$cloudPercentage%',
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
                          '$humidity',
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
