import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:no_name/views/splash_screen/splash_screen.dart';

import '../views/dashboard/dashboard_view.dart';
import '../views/homepage/homepage_view.dart';
import '../widgets/utility_widgets.dart';

abstract class Routes {
  static const startupViewRoute = '/start-up';
  static const signinViewRoute = '/start-up';
  static const homePageViewRoute = '/home-page';
  static const dashboardViewRoute = '/dashboard';
}

class Routers {
  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch(settings.name) {
      case Routes.startupViewRoute:
        return CupertinoPageRoute<dynamic>(
          builder: (context) => const SplashScreen(),
          settings: settings
        );

      case Routes.dashboardViewRoute:
        return CupertinoPageRoute<dynamic>(
            builder: (context) => const DashboardView(),
            settings: settings
        );

        case Routes.homePageViewRoute:
        return CupertinoPageRoute<dynamic>(
          builder: (context) => const HomePageView(),
          settings: settings
        );


      default:
        return unknownRoutePage(settings.name);
    // case Routes.dashBoardView:
    // return CupertinoPageRoute<dynamic>(
    // builder: (context) => DashboardView(),
    // settings: settings
    // );
    }
  }
}

// borrowed from auto_route:
// returns an error page routes with a helper message.
PageRoute unknownRoutePage(String? routeName) => CupertinoPageRoute(
  builder: (ctx) => Scaffold(
    body: Container(
      color: Colors.white,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
            child: Text(
              routeName == "/"
                  ? 'Initial route not found! \n did you forget to annotate your home page with @initial or @MaterialRoute(initial:true)?'
                  : 'Route name $routeName is not found!',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
          ),
          RoundedButton(
            title: "Back",
            onPressed: () => Navigator.of(ctx).pop(),
          ),
        ],
      ),
    ),
  ),
);