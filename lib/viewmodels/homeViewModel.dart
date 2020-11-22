import 'package:shared_preferences/shared_preferences.dart';
import 'package:weatherapp/constants/routeNames.dart';
import 'package:weatherapp/locator.dart';
import 'package:weatherapp/models/weatherData.dart';
import 'package:weatherapp/services/navigationService.dart';
import 'package:weatherapp/viewmodels/baseModel.dart';

class HomeViewModel extends BaseModel {
  final NavigationService _navigationService = locator<NavigationService>();
  // SharedPreferences prefs;

  WeatherData weatherData;

  Future storeLocation(String location, double lat, double lng) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('WA_LOCATION', location);
    prefs.setDouble('WA_LAT', lat);
    prefs.setDouble('WA_LNG', lng);

    print({location, lat, lng});
  }

  Future navigateToWeatherScreen() async {
    await _navigationService.navigateTo(ForecastListRoute);
  }
}
