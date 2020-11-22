
import 'package:flutter/material.dart';
import 'package:weatherapp/dialog/dialogManager.dart';
import 'package:weatherapp/locator.dart';
import 'package:weatherapp/services/dialogService.dart';
import 'package:weatherapp/services/navigationService.dart';
import 'package:weatherapp/ui/screens/splashscreen.dart';
import 'package:weatherapp/ui/utils/router.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  return runApp(MyApp());
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
      builder: (context, child) => Navigator(
        key: locator<DialogService>().dialogNavigationKey,
        onGenerateRoute: (settings) => MaterialPageRoute(
            builder: (context) => DialogManager(child: child)),
      ),
      navigatorKey: locator<NavigationService>().navigationKey,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    home: StartUpView(),
        onGenerateRoute: generateRoute,
    );
  }
}
