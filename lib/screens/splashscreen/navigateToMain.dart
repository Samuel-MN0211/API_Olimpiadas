import 'package:flutter/material.dart';


//Função para navegar para a tela principal quando "Gesture Detector" da SplashScreen recebe um toque na tela.
void NavigateToMain(
    BuildContext context,
    String routeName,
  ) {
    Navigator.pushNamed(context, routeName);
  }
