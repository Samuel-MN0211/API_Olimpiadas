import 'package:flutter/material.dart';
import '../screens/mainscreen.dart';
import '../screens/splashscreen.dart';
import '../screens/result_failedscreen.dart';
import '../screens/result_foundscreen.dart';

class AppRoutes {
  static const String mainScreen = '/mainscreen';
  static const String splashScreen = '/splashscreen';
  static const String result_FailedScreen = '/result_failedscreen';
  static const String result_FoundScreen = '/result_foundscreen';

  static Map<String, WidgetBuilder> routes = {
    mainScreen: (context) => MainScreen(),
    splashScreen: (context) => SplashScreen(),
    result_FoundScreen: (context) {
  final args = ModalRoute.of(context)!.settings.arguments as ResultFoundScreenArguments;
  return ResultFoundScreen(
    obmawards: args.obmawards,
    obcawards: args.obcawards,
    searchTerm: args.searchTerm,
  );
},result_FailedScreen: (context) {
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
