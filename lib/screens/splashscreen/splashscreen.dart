import 'package:flutter/material.dart';
import 'package:BOOC/core/app_export.dart';

// classe de "SplashScreen" que é a tela de abertura do aplicativo.
//Roteia para a main ao receber qualquer toque na tela. (Gesture Detector + função navigateToMain Envolvendo todo o Scaffold)
class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          NavigateToMain(context, AppRoutes.mainScreen);
        },
        child: Scaffold(
          body: Container(
            width: double.maxFinite,
            padding: EdgeInsets.only(top: 202.v),
            child: Column(
              children: [
                Text(
                  "BOOC",
                  style: CustomTextStyles.righteousOnPrimary,
                ),
                SizedBox(height: 23.v),
                SizedBox(
                  height: 134.v,
                  width: 268.h,
                  child: Stack(
                    alignment: Alignment.centerRight,
                    children: [
                      CustomImageView(
                        imagePath: ImageConstant.imgVector,
                        height: 89.v,
                        width: 268.h,
                        alignment: Alignment.bottomCenter,
                      ),
                      CustomImageView(
                        imagePath: ImageConstant.imgGroup,
                        height: 164.v,
                        width: 17.h,
                        alignment: Alignment.centerRight,
                        margin: EdgeInsets.only(right: 116.h),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.v),
                SizedBox(
                  width: 278.h,
                  child: Divider(
                    color: appTheme.blueGray700,
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
}
