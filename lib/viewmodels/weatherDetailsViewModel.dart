import 'package:shared_preferences/shared_preferences.dart';
import 'package:weatherapp/constants/routeNames.dart';
import 'package:weatherapp/locator.dart';
import 'package:weatherapp/services/authenticationService.dart';
import 'package:weatherapp/services/navigationService.dart';
import 'package:weatherapp/viewmodels/baseModel.dart';


class WeatherDetailsViewModel extends BaseModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final NavigationService _navigationService = locator<NavigationService>();

  Future navigateToHome() async {
    await _navigationService.navigateTo(ForecastListRoute);
  }

  Future signOut() async {
    setBusy(true);

    await _authenticationService.signOut();

    setBusy(false);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('WA_isLoggenIn', false);

    _navigationService.navigateTo(LoginRoute);
  }
}
