import 'package:flutter/material.dart';


//Classe com variáveis globais, pode ser disponibilizada para qualquer widget o envolvendo em um "consumer" ou "listener"
class SettingsProvider extends ChangeNotifier {
  bool isObmSelected = true;
  bool isObcSelected = true;

  void toggleObm() {
    if (isObmSelected == true && isObcSelected == false) {
      return; // Retorna sem fazer nada se ambos estiverem desmarcados
    }
    isObmSelected = !isObmSelected;
    notifyListeners();
  }

  void toggleObc() {
    if (isObcSelected == true && isObmSelected == false) {
      return; // Retorna sem fazer nada se ambos estiverem desmarcados
    }
    isObcSelected = !isObcSelected;
    notifyListeners();
  }
}




