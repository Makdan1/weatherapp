import 'dart:math';

import 'package:flutter/material.dart';
import 'package:weatherapp/Auth/Regsiter.dart';
import 'package:weatherapp/Auth/forgotPassword.dart';
import 'package:weatherapp/Auth/login.dart';
import 'package:weatherapp/forecast/listForecast.dart';
import 'package:weatherapp/home.dart';
import 'package:weatherapp/splashscreen.dart';

void main() {

  return runApp(
          MyApp());
}
class MyApp extends StatefulWidget {
  @override
  _MyApp createState() => _MyApp();
}

class _MyApp extends State<MyApp> {


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather app',
        debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    home:SplashScreen(),
    routes: <String,WidgetBuilder>{
       "/Login":(BuildContext context)=>new Login(),
       "/ResetPasswordPage":(BuildContext context)=>new ResetPasswordPage(),
      "/RegisterPage":(BuildContext context)=>new RegisterPage(),
      "/Home":(BuildContext context)=>new Home(),
      "/Forecast":(BuildContext context)=>new Forecast(),


    }
    );
  }
}
