import 'package:flutter/material.dart';
import 'package:BOOC/core/app_export.dart';

//Classe para validar, fazer validações referentes a busca e chamada de funções de fetch / find dados
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
        await data.fetchObmData(textEditingController.text);
      }
      if (settingsProvider.isObcSelected == true) {
        print('ATIVOU ATIVOU ATIVOU OBC');
        await data.fetchObcData(textEditingController.text);
      }

      if (data.obm_result == 'Aluno não encontrado\n' &&
          data.obc_result == '') {
        Navigator.pushNamed(
          context,
          AppRoutes.result_FailedScreen,
          arguments: textEditingController.text,
        );
      } else if (data.obm_result != 'Aluno não encontrado\n' ||
          data.obc_result != '') {
        Navigator.pushNamed(
          context,
          AppRoutes.result_FoundScreen,
          arguments: ResultFoundScreenArguments(
            obmawards: data.obm_result,
            obcawards: data.obc_result,
            searchTerm: textEditingController.text,
          ),
        );
      }
    }
  }
}
