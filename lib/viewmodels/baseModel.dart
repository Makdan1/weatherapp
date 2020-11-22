import 'package:flutter/widgets.dart';
import 'package:weatherapp/locator.dart';
import 'package:weatherapp/models/user.dart';
import 'package:weatherapp/services/authenticationService.dart';

class BaseModel extends ChangeNotifier {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();

  User get currentUser => _authenticationService.currentUser;

  bool _busy = false;
  bool get busy => _busy;

  void setBusy(bool value) {
    _busy = value;
    notifyListeners();
  }
}
