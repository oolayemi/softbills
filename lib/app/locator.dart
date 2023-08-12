import 'dart:io';

import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:stacked_services/stacked_services.dart';

import '../core/services/auth_service.dart';
import '../core/services/http/http_service.dart';
import '../core/services/http/http_service_impl.dart';
import '../core/services/notification/notification_service.dart';
import '../core/services/notification/notification_service_impl.dart';
import '../core/services/user_service.dart';
import '../core/services/utility_storage_service.dart';
import '../views/services/transfer_funds_service.dart';

GetIt locator = GetIt.instance;
Future<void> setupLocator({bool test = false})async {
  Directory appDocDir = test ? Directory.current : await getApplicationDocumentsDirectory();
  Hive.init(appDocDir.path);

  if(!test) {
    locator.registerLazySingleton<HiveInterface>(() => Hive);
  }
  locator.registerLazySingleton<NavigationService>(
          () => NavigationService()
  );
  locator.registerLazySingleton<DialogService>(
        () => DialogService(),
  );
  locator.registerLazySingleton<SnackbarService>(
        () => SnackbarService(),
  );
  locator.registerLazySingleton<HttpService>(() => HttpServiceImpl());
  locator.registerLazySingleton<NotificationService>(() => NotificationRemindersServiceImpl());
  locator.registerLazySingleton<AuthService>(
          () => AuthService()
  );
  locator.registerLazySingleton<StorageService>(
          () => StorageService()
  );
  locator.registerLazySingleton<UserService>(
          () => UserService()
  );

  locator.registerLazySingleton<TransferFundsService>(
          () => TransferFundsService()
  );


  // Logger.d('Initializing boxes...');
  await UserService().init();
  await StorageService().init();
  await AuthService().setBiometricStatus();
}