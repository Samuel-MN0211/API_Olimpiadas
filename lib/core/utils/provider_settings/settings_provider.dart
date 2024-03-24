import 'package:flutter/material.dart';

class SettingsProvider extends ChangeNotifier {
  bool isObmSelected = true;
  bool isObcSelected = true;

  void toggleObm() {
    isObmSelected = !isObmSelected;
    notifyListeners();
  }

  void toggleObc() {
    isObcSelected = !isObcSelected;
    notifyListeners();
  }
}



