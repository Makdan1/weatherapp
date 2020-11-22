import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:provider_architecture/_viewmodel_provider.dart';
import 'package:weatherapp/models/weatherData.dart';
import 'package:weatherapp/ui/utils/colors.dart';
import 'package:weatherapp/viewmodels/weather_view_model.dart';


class Forecast extends StatefulWidget {
  @override
  HomeState createState() => new HomeState();
}

class HomeState extends State<Forecast> {


  var _random = new Random();
  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<WeatherViewModel>.withConsumer(
    viewModelBuilder: () => WeatherViewModel(),
    onModelReady: (model) => model.getWeatherData(),
    builder: (context, model, child) =>  Scaffold(
      body:model.busy
          ? Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(AppColors.white),
        ),
      )
          : ListView.builder(
        shrinkWrap: true,
        itemCount: model.weatherData.daily.length,
        itemBuilder: (context, index) {
          Daily data = model.weatherData.daily[index];

          DateTime dateTime =
          DateTime.fromMillisecondsSinceEpoch(data.dt * 1000);


          return InkWell(
            onTap: () => model.navigateToWeatherDetails(index),
            child: Container(
              decoration: BoxDecoration(
                  boxShadow: [
                    new BoxShadow(
                      color: Colors.grey[500],
                      blurRadius: 1.0,
                      spreadRadius: 1.0,
                    )
                  ],
color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(16.0)),
              padding: const EdgeInsets.all(16.0),
              margin: const EdgeInsets.symmetric(
                  horizontal: 16.0, vertical: 8),
              child:

              Column(
                children: [
                  Text("${Jiffy(dateTime).yMMMMEEEEd}",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold)),
                  SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text("${data.temp.min} °C",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24.0,
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
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold)),
                          Text("Max Temp.",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 12.0)),
                        ],
                      ),
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

                ],
              ),
              //   ],
              // )
            ),
          );
        },
      ),
    ),
    );
  }
}
