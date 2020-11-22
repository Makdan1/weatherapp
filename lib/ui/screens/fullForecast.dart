import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:weatherapp/models/weatherData.dart';
import 'package:provider_architecture/_viewmodel_provider.dart';
import 'package:weatherapp/viewmodels/weatherDetailsViewModel.dart';

class FullForecast extends StatefulWidget {
  final Daily daily;

  FullForecast({Key key, this.daily}) : super(key: key);
  @override
  HomeState createState() => new HomeState();
}

class HomeState extends State<FullForecast> {
  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<WeatherDetailsViewModel>.withConsumer(
      viewModelBuilder: () => WeatherDetailsViewModel(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: Colors.blueAccent,

        body: Builder(
          builder: (context) {
            Daily data = widget.daily;

            DateTime dateTime =
                DateTime.fromMillisecondsSinceEpoch(data.dt * 1000);

            return
               Column(
                children: [
                  SizedBox(height: 40,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                        ),
                      )
                    ],
                  ),
                  Text("${Jiffy(dateTime).yMMMMEEEEd}",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                  SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Column(
                            children: [
                              Text("${data.temp.min} °C",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold)),
                              Text("Min Temp.",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12.0)),
                            ],
                          ),
                          Icon(Icons.thermostat_sharp,
                              color: Colors.white, size: 60.0),
                          Column(
                            children: [
                              Text("${data.temp.max} °C",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold)),
                              Text("Max Temp.",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12.0)),
                            ],
                          ),
                        ],
                      ),
                      Container(
                        height: 200,
                        width: 200,
                        child: Image(image: AssetImage('images/sun.png')),
                      )
                    ],
                  ),
                  SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        child: Card(
                          elevation: 2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('Cloud %',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                              Icon(Icons.cloud,
                                  color: Colors.redAccent, size: 30.0),
                              Text("${data.clouds} %",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 100,
                        width: 100,
                        child: Card(
                          elevation: 2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('Wind Speed',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                              Icon(Icons.run_circle_outlined,
                                  color: Colors.redAccent, size: 30.0),
                              Text("${data.windSpeed} km/h",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: 100,
                        width: 100,
                        child: Card(
                          elevation: 2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('Humidity Level',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12)),
                              Icon(Icons.thermostat_outlined,
                                  color: Colors.redAccent, size: 30.0),
                              Text("${data.humidity}",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
            SizedBox(height: 40,),



            Center(
                    child:
              RaisedButton(
                onPressed: model.signOut,
                child:          Text("Sign out",
                    style: TextStyle(fontWeight: FontWeight.bold)),
              )

                )
                ],

            );
          },
        ),
      ),
    );
  }
}
