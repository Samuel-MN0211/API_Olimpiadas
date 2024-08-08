import 'package:flutter/material.dart';


//Classe com variáveis globais, pode ser disponibilizada para qualquer widget o envolvendo em um "consumer" ou "listener"
class SettingsProvider extends ChangeNotifier {
  bool isObmSelected = true;
  bool isObcSelected = true;
  bool isObmepSelected = true;

  void toggleObm() {
    isObmSelected = !isObmSelected;
    notifyListeners();
  }

  void toggleObc() {
    isObcSelected = !isObcSelected;
    notifyListeners();
  }

  void toggleObmep() {
    isObmepSelected = !isObmepSelected;
    notifyListeners();
  }
}




