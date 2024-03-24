import 'package:flutter/material.dart';
import 'package:teste_olimpiadas/core/app_export.dart';
import 'package:teste_olimpiadas/screens/splashscreen/splashscreen.dart';
 

void main() {
  runApp(
    ChangeNotifierProvider<SettingsProvider>(
      create: (context) => SettingsProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:const SplashScreen(),
      routes: AppRoutes.routes,
      debugShowCheckedModeBanner: false,
    );
  }
}