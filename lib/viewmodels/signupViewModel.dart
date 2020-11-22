
import 'package:flutter/foundation.dart';
import 'package:weatherapp/constants/routeNames.dart';
import 'package:weatherapp/locator.dart';
import 'package:weatherapp/services/authenticationService.dart';
import 'package:weatherapp/services/dialogService.dart';
import 'package:weatherapp/services/navigationService.dart';

import 'baseModel.dart';

class SignUpViewModel extends BaseModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();

  String _selectedRole = 'Select a User Role';
  String get selectedRole => _selectedRole;

  void setSelectedRole(dynamic role) {
    _selectedRole = role;
    notifyListeners();
  }

  Future signUp({
    @required String email,
    @required String password,
    @required String firstName,
    @required String lastName,
  }) async {
    setBusy(true);

    var result = await _authenticationService.signUpWithEmail(
        email: email,
        password: password,
        firstName: firstName,
        lastName: firstName);

    setBusy(false);

    if (result is bool) {
      if (result) {
        _navigationService.navigateReplacementTo(ForecastListRoute);
      } else {
        await _dialogService.showDialog(
          title: 'Sign Up Failure',
          description: 'General sign up failure. Please try again later',
        );
      }
    } else {
      await _dialogService.showDialog(
        title: 'Sign Up Failure',
        description: result.toString(),
      );
    }
  }

  void navigateToSignIn() {
    _navigationService.navigateTo(LoginRoute);
  }
}
