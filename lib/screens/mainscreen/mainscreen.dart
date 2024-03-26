import 'package:flutter/material.dart';
import 'package:teste_olimpiadas/core/app_export.dart';

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
    return Consumer<SettingsProvider>(
      builder: (context, settingsProvider, child) {
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
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        MainScreenIcons.buildMainScreenIcons(context),
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
                            String validatedText = TextValidation.validateText(context, textEditingController);
                            await SearchValidation.validateAndNavigate(context, validatedText, textEditingController, settingsProvider, data);
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
                    Positioned(
                      top: 20.v,
                      right: 20.h,
                      child: ElevatedButton(
                        onPressed: () {
                          
                          showSettingsModal(context);
                        },
                        style: ElevatedButton.styleFrom(
                          shape: CircleBorder(),
                          padding: EdgeInsets.all(20.h),
                          primary: Colors.red,
                        ),
                        child: Icon(Icons.settings, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}