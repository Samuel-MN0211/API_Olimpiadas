import 'package:flutter/material.dart';

import '../../core/app_export.dart';

//Classe para validar, fazer validações referentes a busca, chamada de funções de fetch / find dados e tratamento do clique do botão
class SearchValidation {
  static Future<void> validateAndNavigate(
      BuildContext context,
      String validatedText,
      TextEditingController textEditingController,
      SettingsProvider settingsProvider,
      Data data) async {
    if (validatedText.isNotEmpty) {
      textEditingController.text = validatedText;
      if (settingsProvider.isObmSelected == true) {
        print('ATIVOU ATIVOU ATIVOU OBM');
        await data.fetchObmData(textEditingController.text, settingsProvider);
      }
      if (settingsProvider.isObcSelected == true) {
        print('ATIVOU ATIVOU ATIVOU OBC');
        await data.fetchObcData(textEditingController.text);
      }
      if (settingsProvider.isObiSelected == true) {
        await data.fetchObiData(textEditingController.text);
      }
      if (settingsProvider.isObmepSelected == true) {
        await data.fetchObmepData(textEditingController.text);
      }

      if (data.obm_result == 'Aluno não encontrado\n' &&
          data.obc_result == 'Aluno não encontrado\n' &&
          data.obi_result == 'Aluno não encontrado\n' &&
          data.obmep_result == 'Aluno não encontrado\n') {
        Navigator.pushNamed(
          context,
          AppRoutes.result_FailedScreen,
          arguments: textEditingController.text,
        );
      } else if (data.obm_result != 'Aluno não encontrado\n' ||
          data.obc_result != 'Aluno não encontrado\n' ||
          data.obmep_result != 'Aluno não encontrado\n') {
        Navigator.pushNamed(
          context,
          AppRoutes.result_FoundScreen,
          arguments: ResultFoundScreenArguments(
            obmawards: data.obm_result,
            obcawards: data.obc_result,
            obiAwards: data.obi_result,
            obmepAwards: data.obmep_result,
            searchTerm: textEditingController.text,
          ),
        );
      }
    }
  }

  static Future<void> handleButtonPress(
      BuildContext context,
      TextEditingController textEditingController,
      SettingsProvider settingsProvider,
      Data data) async {
    String validatedText =
        TextValidation.validateText(context, textEditingController);

    if (validatedText.isEmpty) {
      print("Busca bloqueada: números no texto");
      return; // Bloqueia a busca
    }

    await validateAndNavigate(
        context, validatedText, textEditingController, settingsProvider, data);
  }
}
