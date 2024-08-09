import 'package:flutter/material.dart';

//Classe com variáveis globais, pode ser disponibilizada para qualquer widget o envolvendo em um "consumer" ou "listener"
class SettingsProvider extends ChangeNotifier {
  bool isObmSelected = true;
  bool isObcSelected = true;
  bool isObiSelected = true;
  bool isObmepSelected = true;
  int? startYear;
  int? endYear;

  void toggleObm() {
    isObmSelected = !isObmSelected;
    notifyListeners();
  }

  void toggleObc() {
    isObcSelected = !isObcSelected;
    notifyListeners();
  }

  void toggleObi() {
    isObiSelected = !isObiSelected;
    notifyListeners();
  }

  void toggleObmep() {
    isObmepSelected = !isObmepSelected;
    notifyListeners();
  }

  void setStartYear(int? year) {
    startYear = year;
    notifyListeners();
  }

  void setEndYear(int? year) {
    endYear = year;
    notifyListeners();
  }
}
