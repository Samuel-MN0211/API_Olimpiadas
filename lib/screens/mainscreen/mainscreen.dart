import 'package:flutter/material.dart';
import '../../core/app_export.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  TextEditingController textEditingController = TextEditingController();
  Data data = Data();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsProvider>(
      builder: (context, settingsProvider, child) {
        return SafeArea(
          child: Scaffold(
            body: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
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
                        SizedBox(height: 40.v),
                        Stack(
                          alignment: Alignment
                              .center, // Centraliza o conteúdo do Stack
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 75.h),
                              child: Ink(
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(
                                      100), // Define a borda do círculo para o Container
                                ),
                                child: ElevatedButton(
                                  onPressed: isLoading
                                      ? null
                                      : () async {
                                          setState(() {
                                            isLoading = true;
                                          });
                                          await SearchValidation
                                              .handleButtonPress(
                                                  context,
                                                  textEditingController,
                                                  settingsProvider,
                                                  data);
                                          setState(() {
                                            isLoading = false;
                                          });
                                        },
                                  style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(112.5),
                                      side: BorderSide(
                                          color: appTheme.blueGray700),
                                    ),
                                    minimumSize: Size(192.h, 190.v),
                                  ),
                                  child: isLoading
                                      ? CircularProgressIndicator()
                                      : Icon(
                                          Icons.search,
                                          size: 115.adaptSize,
                                          color: appTheme.blueGray700,
                                        ),
                                ),
                              ),
                            ),
                          ],
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
                      top: 220.v,
                      right: 20.h,
                      child: ElevatedButton(
                        onPressed: () {
                          showSettingsModal(context);
                        },
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          padding: EdgeInsets.all(20.h),
                          side: BorderSide(color: appTheme.blueGray700),
                        ),
                        child:
                            Icon(Icons.settings, color: appTheme.blueGray700),
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
