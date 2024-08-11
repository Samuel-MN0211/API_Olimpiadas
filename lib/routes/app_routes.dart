import 'package:flutter/material.dart';

import '../core/app_export.dart';
import '../screens/splashscreen/splashscreen.dart';

class AppRoutes {
  static const String mainScreen = '/mainscreen';
  static const String splashScreen = '/splashscreen';
  static const String result_FailedScreen = '/result_failedscreen';
  static const String result_FoundScreen = '/result_foundscreen';
  static const String settings_Screen = '/settings_screen';

  static Map<String, WidgetBuilder> routes = {
    mainScreen: (context) => MainScreen(),
    splashScreen: (context) => const SplashScreen(),
    settings_Screen: (context) => SettingsScreen(),
    result_FoundScreen: (context) {
      final args = ModalRoute.of(context)!.settings.arguments
          as ResultFoundScreenArguments;
      return ResultFoundScreen(
        obmawards: args.obmawards,
        obcawards: args.obcawards,
        obiAwards: args.obiAwards,
        obmepAwards: args.obmepAwards,
        searchTerm: args.searchTerm,
      );
    },
    result_FailedScreen: (context) {
      final args = ModalRoute.of(context)!.settings.arguments as String;
      return ResultFailedScreen(searchTerm: args);
    },
  }; // Adicionado

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case result_FailedScreen:
        if (args is String) {
          return MaterialPageRoute(
            builder: (_) => ResultFailedScreen(searchTerm: args),
          );
        }
        return _errorRoute();
      case result_FoundScreen:
        if (args is ResultFoundScreenArguments) {
          return MaterialPageRoute(
            builder: (_) => ResultFoundScreen(
              obmawards: args.obmawards,
              obcawards: args.obcawards,
              obiAwards: args.obiAwards,
              obmepAwards: args.obmepAwards,
              searchTerm: args.searchTerm,
            ),
          );
        }
        return _errorRoute();
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Text('Error'),
        ),
      ),
    );
  }
}
