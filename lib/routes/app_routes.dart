import 'package:flutter/material.dart';
import '../screens/mainscreen.dart';
import '../screens/splashscreen.dart';
import '../screens/result_failedscreen.dart';
import '../screens/result_foundscreen.dart';


class AppRoutes {
  static const String mainScreen =
      '/mainscreen';

  static const String splashScreen =
      '/splashscreen';

  static const String result_FailedScreen =
      '/result_failedscreen';

  static const String result_FoundScreen =
      '/result_foundscreen';


  static Map<String, WidgetBuilder> routes = {
    mainScreen: (context) => MainScreen(),
    splashScreen: (context) => SplashScreen(),
    result_FailedScreen: (context) => ResultFailedScreen(),
    result_FoundScreen: (context) => ResultFoundScreen(),
  };
}
