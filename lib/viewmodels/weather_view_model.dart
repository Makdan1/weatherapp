
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weatherapp/constants/routeNames.dart';
import 'package:weatherapp/locator.dart';
import 'package:weatherapp/models/weatherData.dart';
import 'package:weatherapp/services/apiService.dart';
import 'package:weatherapp/services/authenticationService.dart';
import 'package:weatherapp/services/navigationService.dart';

import 'baseModel.dart';

class WeatherViewModel extends BaseModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final ApiService _apiService = locator<ApiService>();

  WeatherData weatherData;

  String location;
  double lat, lng;

  Future getWeatherData() async {
    setBusy(true);

    await getLocation();
    _apiService.getEventDetails(location, lat, lng).then((res) {
      weatherData = res;
      notifyListeners();
      setBusy(false);
    });
  }

  Future getLocation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
   // location = prefs.getString('WA_LOCATION');
    lat = prefs.getDouble('WA_LAT');
    lng = prefs.getDouble('WA_LNG');

    print({location, lat, lng});
  }

  String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'morning';
    }
    if (hour < 17) {
      return 'afternoon';
    }
    return 'evening';
  }

  Future signOut() async {
    setBusy(true);

    await _authenticationService.signOut();

    setBusy(false);
    
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('WA_isLoggenIn', false);

    _navigationService.navigateTo(LoginRoute);
  }

  Future navigateToHome() async {
    await _navigationService.navigateTo(ForecastListRoute);
  }

  Future navigateToWeatherDetails(int index) async {
    print(index);
    print(weatherData.daily[index].temp.max);
    await _navigationService.navigateTo(ForecastSingleRoute,
        arguments: weatherData.daily[index]);
  }
}
