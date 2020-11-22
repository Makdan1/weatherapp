import 'package:get_it/get_it.dart';
import 'package:weatherapp/services/apiService.dart';
import 'package:weatherapp/services/authenticationService.dart';
import 'package:weatherapp/services/dialogService.dart';
import 'package:weatherapp/services/firestoreService.dart';
import 'package:weatherapp/services/navigationService.dart';

GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => AuthenticationService());
  locator.registerLazySingleton(() => FirestoreService());
  locator.registerLazySingleton(() => ApiService());
}
