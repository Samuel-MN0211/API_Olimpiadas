import 'package:flutter/material.dart';

// Classe TextValidation - Valida o texto que vai ser submetido para busca contido no TextEditingController: Exibe Snackbar para exibir nome se for vazio, caso contrário, capitaliza
//a primeira letra de cada palavra e capitaliza sobrenomes com mais de 4 letras
class TextValidation {
  static String validateText(
      BuildContext context, TextEditingController controller) {
    String text = controller.text.trim();
    if (text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Insira um nome'),
        ),
      );
    } else if (text.contains(RegExp(r'[0-9]'))) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Não coloque números na busca textual'),
        ),
      );
    } else {
      List<String> names = text.split(' ');
      for (int i = 0; i < names.length; i++) {
        if (names[i].length > 4 || i == 0) {
          names[i] = names[i].capitalize();
        }
      }
      text = names.join(' ');
    }
    return text;
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
  }
}
