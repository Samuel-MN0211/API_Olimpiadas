import 'package:flutter/material.dart';
import 'package:teste_olimpiadas/widgets/custom_elevated_button.dart';
import 'package:teste_olimpiadas/core/app_export.dart';
import 'package:teste_olimpiadas/core/data.dart';


class MainScreen extends StatefulWidget {
  MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  TextEditingController textEditingController = TextEditingController();
  Data data = Data();
  

  @override
  Widget build(BuildContext context) {
     SettingsProvider settingsProvider = Provider.of<SettingsProvider>(context);

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Container(
            width: double.maxFinite,
            padding: EdgeInsets.only(
              left: 27.h,
              top: 35.v,
              right: 27.h,
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _buildIcons(context),
                SizedBox(height: 10.v),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.h),
                  child: TextField(
                    controller: textEditingController,
                    decoration: const InputDecoration(
                      hintText: "Pesquise o nome do(a) Aluno(a)",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(height: 20.v),
                GestureDetector(
  onTap: () async {
    String validatedText = TextValidation.validateText(context,textEditingController);
    if (validatedText.isNotEmpty) {
      textEditingController.text = validatedText;
      await data.fetchObmData(textEditingController.text);
      //await data.fetchObcData(textEditingController.text);

      if (data.obm_result == 'Aluno não encontrado\n' && data.obc_result == '') {
    Navigator.pushNamed(
      context,
      AppRoutes.result_FailedScreen,
      arguments: textEditingController.text,
    );
      } else {
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
  },
                  child: Container(
                    height: 223.v,
                    width: 225.h,
                    margin: EdgeInsets.only(right: 53.h),
                    child: Stack(
                      alignment: Alignment.topRight,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            height: 196.adaptSize,
                            width: 196.adaptSize,
                            decoration: AppDecoration.outlineBlueGray.copyWith(
                              borderRadius: BorderRadiusStyle.circleBorder98,
                            ),
                            child: Icon(
                              Icons.search,
                              size: 115.adaptSize,
                              color: appTheme.blueGray700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 50.v),
                Container(
                  height: 137.v,
                  width: 224.h,
                  margin: EdgeInsets.only(right: 55.h),
                  child: Stack(
                    alignment: Alignment.centerRight,
                    children: [
                      CustomImageView(
                        imagePath: ImageConstant.imgVector,
                        height: 74.v,
                        width: 224.h,
                        alignment: Alignment.bottomCenter,
                      ),
                      CustomImageView(
                        imagePath: ImageConstant.imgGroup,
                        height: 137.v,
                        width: 14.h,
                        alignment: Alignment.centerRight,
                        margin: EdgeInsets.only(right: 97.h),
                      ),
                      CustomImageView(
                        imagePath: ImageConstant.imgVector,
                        height: 74.v,
                        width: 224.h,
                        alignment: Alignment.bottomCenter,
                      ),
                      CustomImageView(
                        imagePath: ImageConstant.imgGroup,
                        height: 137.v,
                        width: 14.h,
                        alignment: Alignment.centerRight,
                        margin: EdgeInsets.only(right: 97.h),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.v),
                Container(
                  height: 3.v,
                  width: 233.h,
                  margin: EdgeInsets.only(right: 52.h),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          width: 233.h,
                          child: Divider(),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          width: 233.h,
                          child: Divider(),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8.v),
                Padding(
                  padding: EdgeInsets.only(right: 121.h),
                  child: Text(
                    "BOOC",
                    style: theme.textTheme.headlineLarge,
                  ),
                ),
                SizedBox(height: 5.v),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIcons(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 1.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: [
                CustomImageView(
                  imagePath: ImageConstant.imgObmProvisorio,
                  height: 125.v,
                  width: 200.h,
                  alignment: Alignment.centerRight,
                ),
                Padding(
                  padding: EdgeInsets.only(right: 30.h),
                  child: CustomImageView(
                    imagePath: ImageConstant.imgLogoObc,
                    height: 93.v,
                    width: 120.h,
                    alignment: Alignment.centerLeft,
                  ),
                ),
                CustomImageView(
                  imagePath: ImageConstant.imgLogoObi,
                  height: 130.v,
                  width: 102.h,
                  alignment: Alignment.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


//Argumentos (valores) para serem passados para a tela de "found"
class ResultFoundScreenArguments {
  final String obmawards;
  final String obcawards;
  final String searchTerm;

  ResultFoundScreenArguments({
    required this.obmawards,
    required this.obcawards,
    required this.searchTerm,
  });
}
// Classe TextValidation - Exibe Snackbar se for vazio, caso contrário, capitaliza 
//a primeira letra de cada palavra e capitaliza sobrenomes com mais de 4 letras
class TextValidation {
  static String validateText(BuildContext context, TextEditingController controller) {
    String text = controller.text.trim();
    if (text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Insira um nome'),
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