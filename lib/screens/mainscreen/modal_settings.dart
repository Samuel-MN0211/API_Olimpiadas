import 'package:flutter/material.dart';
import 'package:BOOC/core/app_export.dart';

//Classe que retorna instancia de SettingsScreen para ser exibida como modal
void showSettingsModal(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return SettingsScreen();
    },
  );
}

void showSearchSettingsModal(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return SearchScreen();
    },
  );
}
