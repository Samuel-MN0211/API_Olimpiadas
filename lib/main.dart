import 'package:flutter/material.dart';
import 'package:teste_olimpiadas/core/app_export.dart';
import 'screens/home.dart'; 

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: AppRoutes.splashScreen,
      routes: AppRoutes.routes,
      debugShowCheckedModeBanner: false,
    );
  }
}