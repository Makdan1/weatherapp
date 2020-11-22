import 'dart:async';
import 'dart:math';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weatherapp/constants/routeNames.dart';
import 'package:weatherapp/locator.dart';
import 'package:weatherapp/services/navigationService.dart';
import 'package:weatherapp/viewmodels/baseModel.dart';

class StartUpViewModel extends BaseModel {
  // final AuthenticationService _authenticationService =locator<AuthenticationService>();
  final NavigationService _navigationService = locator<NavigationService>();

  bool hasLoggedInUser = false;

  Future handleStartUpLogic() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // var userAuthId = prefs.getString('WA_userAuthId');
    try {
      hasLoggedInUser = prefs.getBool('WA_isLoggenIn');
      print("try: " + hasLoggedInUser.toString());
      double lat;
      double lng;
      getUserLocation( lat, lng);
    } catch (e) {
      hasLoggedInUser = false;
      print("caught: " + hasLoggedInUser.toString());
    }

    if (hasLoggedInUser != null && hasLoggedInUser) {
      double lat;
      double lng;
     getUserLocation( lat, lng);
      _navigationService.navigateReplacementTo(ForecastListRoute);
    } else {
      _navigationService.navigateReplacementTo(LoginRoute);
    }
  }
}
Future storeLocation(double lat, double lng) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setDouble('WA_LAT', lat);
  prefs.setDouble('WA_LNG', lng);

  print({lat, lng});
}

//function to fetch the coordinates form Location
Future<LatLng> getUserLocation( double lat, double lng) async {
  var location = Location();
  LocationData currentLocation;
  try {
    currentLocation = await location.getLocation();
    lat = currentLocation.latitude;
    lng = currentLocation.longitude;
    storeLocation(lat, lng);
    print(lat);
    print(lng);
  } on Exception {
    currentLocation = null;
    print(e.toString());
    return null;
  }
}
