
import 'dart:async';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  @override
  HomeState createState() => new HomeState();
}

class HomeState extends State<Home> {
  TextEditingController latitudeController = TextEditingController();
  TextEditingController longitudeController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState

    fetchSavedCord();
  }
  String lat;
  String lng;
  var location = Location();
  SharedPreferences prefs;

  fetchSavedCord() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
setState(() {
  lat = prefs.getString('lat');
  lng = prefs.getString('lng');
  print(lat);
  print(lng);
  latitudeController.text = lat;
  longitudeController.text =  lng;
});
  }


  Future<LatLng> getUserLocation() async {
    prefs = await SharedPreferences.getInstance();
    LocationData currentLocation;
    try {
      currentLocation = await location.getLocation();
      setState(() {
        lat = currentLocation.latitude.toString();
        latitudeController.text =  currentLocation.latitude.toString();
        longitudeController.text =  currentLocation.longitude.toString();
        lng = currentLocation.longitude.toString();
      });
      await prefs.setString('lat',lat.toString());
      await prefs.setString('lng',lng.toString());
      print(lat);
      print(lng);
      // final center = LatLng(lat, lng);
      //return center;
    } on Exception {
      currentLocation = null;
      print(e.toString());
      return null;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          Container(
           padding: EdgeInsets.all(20),
            child:
      ListView(
              children: <Widget>[
                Text('Tap the fetch location button to get your coordinates', style: TextStyle(color: Colors.black, fontSize: 15,),),

                SizedBox(height: 20,),
                Text('Latitude', style: TextStyle(color: Colors.black, fontSize: 15,),),

                Container(
                  padding: EdgeInsets.all(20),
                  child: TextFormField(
                    controller: latitudeController,
                    decoration: InputDecoration(

                        hintStyle: TextStyle(
                          color: Colors.black,
                        ),
                        labelStyle: TextStyle(color: Colors.grey, fontSize: 12),
                        prefixIcon: Icon(Icons.person_outline)),
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(color: Colors.black),
                    cursorColor: Colors.black,
                  ),
                ),
                Text('Longitude', style: TextStyle(color: Colors.black, fontSize: 15,),),
                Container(
                  padding: EdgeInsets.all(20),
                  child: TextFormField(
                    controller: longitudeController,
                    decoration: InputDecoration(
                        hintStyle: TextStyle(
                          color: Colors.black,
                        ),
                        labelStyle: TextStyle(color: Colors.grey, fontSize: 12),
                        prefixIcon: Icon(Icons.person_outline)),
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(color: Colors.black),
                    cursorColor: Colors.black,
                  ),
                ),

                Container(
                  margin: EdgeInsets.only(top: 10.0, bottom: 20.0),
                  height: 60.0,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7.0),
                    border: Border.all(color: Colors.white),
                  ),
                  child: Material(
                    borderRadius: BorderRadius.circular(7.0),
                    color: Colors.blueAccent,
                    elevation: 10.0,
                    shadowColor: Colors.white70,
                    child: MaterialButton(
                      onPressed:(){
                        getUserLocation();
                      },
                      child: Text(
                        'Fetch Location',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 15.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),

                Container(
                  margin: EdgeInsets.only(top: 10.0, bottom: 20.0),
                  height: 60.0,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7.0),
                    border: Border.all(color: Colors.white),
                  ),
                  child: Material(
                    borderRadius: BorderRadius.circular(7.0),
                    color: Colors.purple,
                    elevation: 10.0,
                    shadowColor: Colors.white70,
                    child: MaterialButton(
                      onPressed:(){
                        Navigator.pushNamed(context, "/Forecast");
                      },
                      child: Text(
                        'Check Forecast',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 15.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ]
          ),
          ),
    );
  }
}



