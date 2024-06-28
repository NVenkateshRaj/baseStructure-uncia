import 'package:flutter/material.dart';
import 'package:network_issue_handle/screens/dashbord_screen.dart';
import 'package:network_issue_handle/screens/network_error_screen.dart';
import 'package:network_issue_handle/screens/splash_screen.dart';


class Routes {
  static const String splash = "/";
  static const String dashboard = "/dashboard";
  static const String intro = "/intro";
  static const String noNetwork = "no_network";

}

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {

    switch (settings.name) {

      case Routes.splash:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
          settings: RouteSettings(name: settings.name),
        );

      case Routes.dashboard:
        return MaterialPageRoute(
          builder: (_) => const DashboardScreen(),
          settings: RouteSettings(name: settings.name),
        );

      case Routes.noNetwork:
        return MaterialPageRoute(
          builder: (_) => const NoNetWorkScreen(),
          settings: RouteSettings(name: settings.name),
        );

      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
              body: Center(
                child: Text('No route defined for ${settings.name}'),
              ),
            )
        );
    }
  }
}