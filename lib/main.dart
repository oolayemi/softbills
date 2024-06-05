import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:no_name/styles/brand_color.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app/locator.dart';
import 'app/router.dart';
import 'core/managers/life_cycle_manager.dart';
import 'views/splash_screen/splash_screen.dart';
import 'widgets/utility_widgets.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  Platform.isAndroid
      ? SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent, statusBarBrightness: Brightness.light, statusBarIconBrightness: Brightness.light))
      : SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent, statusBarBrightness: Brightness.light, statusBarIconBrightness: Brightness.light));

  await dotenv.load(fileName: ".env");
  await setupLocator();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LifeCycleManager(
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Sample',
          onGenerateRoute: Routers().onGenerateRoute,
          navigatorKey: locator<NavigationService>().navigatorKey,
          theme: ThemeData(
            primaryColor: BrandColors.primary,
            primarySwatch: createMaterialColor(BrandColors.primary),
            visualDensity: VisualDensity.adaptivePlatformDensity,
            brightness: Brightness.light,
            textTheme: GoogleFonts.montserratTextTheme()
          ),
          home: const SplashScreen()),
    );
  }
}
