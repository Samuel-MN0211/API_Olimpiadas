import 'package:flutter/material.dart';
import 'package:teste_olimpiadas/core/app_export.dart';
import 'package:teste_olimpiadas/screens/splashscreen.dart';
import 'core/data.dart'; 

void main() {
  runApp(MyApp());
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