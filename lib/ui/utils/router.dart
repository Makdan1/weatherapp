
import 'package:flutter/material.dart';
import 'package:weatherapp/models/weatherData.dart';
import 'package:weatherapp/ui/screens/Register.dart';
import 'package:weatherapp/ui/screens/forgotPassword.dart';
import 'package:weatherapp/constants/routeNames.dart';
import 'package:weatherapp/ui/screens/fullForecast.dart';
import 'package:weatherapp/ui/screens/listForecast.dart';
import 'package:weatherapp/ui/screens/login.dart';
//
// "/Login":(BuildContext context)=>new Login(),
// "/ResetPasswordPage":(BuildContext context)=>new ResetPasswordPage(),
// "/RegisterPage":(BuildContext context)=>new RegisterPage(),
// "/Home":(BuildContext context)=>new Home(),
// "/Forecast":(BuildContext context)=>new Forecast(),
Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case LoginRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: Login(),
      );
    case RegisterRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: RegisterPage(),
      );

    case ForecastListRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: Forecast(),
      );

    case ResetPasswordRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: ResetPasswordPage(),
      );

    case ForecastSingleRoute:
      var daily = settings.arguments as Daily;

      return _getPageRoute(
        routeName: settings.name,
          viewToShow: FullForecast(daily: daily),
      );

    default:
      return MaterialPageRoute(
          builder: (_) => Scaffold(
                body: Center(
                    child: Text('No route defined for ${settings.name}')),
              ));
  }
}

PageRoute _getPageRoute({String routeName, Widget viewToShow}) {
  return MaterialPageRoute(
      settings: RouteSettings(
        name: routeName,
      ),
      builder: (_) => viewToShow);
}
