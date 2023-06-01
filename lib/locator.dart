import 'package:flutter_mvvm_template/core/config/config.dart';
import 'package:get_it/get_it.dart';

import 'core/enums/env.dart';

import 'core/services/firebase_auth_service.dart';
import 'core/services/firebase_service.dart';
import 'core/services/file_picker_service.dart';
import 'core/services/notifications_service.dart';
import 'core/services/local_storage_service.dart';

GetIt locator = GetIt.instance;

/// [setupLocator] is used to register all the services
setupLocator(Env env) async {
  locator.registerSingleton(Config(env));
  locator.registerSingleton(LocalStorageService());
  locator.registerSingleton(NotificationsService());
  locator.registerLazySingleton<FirebaseService>(() => FirebaseService());
  locator.registerSingleton<FirebaseAuthService>(FirebaseAuthService());
  locator.registerLazySingleton(() => FilePickerService());
}
