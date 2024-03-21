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
              bottom: MediaQuery.of(context).viewInsets.bottom, // Leva em consideração a altura do teclado
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _buildIcons(context),
                SizedBox(height: 10.v),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.h), // TAMANHO TEXTFIELD
                  child: TextField(
                    controller: textEditingController,
                    decoration: InputDecoration(
                      hintText: "Pesquise o nome do(a) Aluno(a)",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                 SizedBox(height: 20.v),
                GestureDetector(
  onTap: () async {
    print({textEditingController.text});
    print('Executou!!');
                  await data.fetchObmData(textEditingController.text);
                  await data.fetchObcData(textEditingController.text);
                  setState(() {});
                },
  child: Container(
    height: 223.v,
    width: 215.h,
    margin: EdgeInsets.only(right: 53.h),
    child: Stack(
      alignment: Alignment.topRight,
      children: [
        Align(
          alignment: Alignment.center, // Centraliza o ícone
          child: Container(
            height: 196.adaptSize,
            width: 196.adaptSize,
            decoration: AppDecoration.outlineBlueGray.copyWith(
              borderRadius: BorderRadiusStyle.circleBorder98,
            ),
            child: Icon(
              Icons.search,
              size: 115.adaptSize, // Tamanho do ícone
              color: appTheme.blueGray700, // Cor do ícone
            ),
          ),
        ),
      ],
    ),
  ),
),

                SizedBox(height: 50.v), // CONTAINER DO LOGO DO BOOC
                Container(
                  height: 137.v,
                  width: 224.h,
                  margin: EdgeInsets.only(right: 55.h), // margem do logo inteiro
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
                  margin: EdgeInsets.only(right: 52.h), // linha do logo aqui
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
                  padding: EdgeInsets.only(right: 121.h), // Padding texto
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
                  padding: EdgeInsets.only(right: 30.h), // Adicione o espaçamento aqui
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

