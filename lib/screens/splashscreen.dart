import 'package:flutter/material.dart';
import 'package:teste_olimpiadas/core/app_export.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);
  
  @override
Widget build(BuildContext context) {
  return SafeArea(
    child: Scaffold(
      body: GestureDetector(
        onTap: () {
          onTapScreenTitle(context, AppRoutes.mainScreen);
        },
        child: Container(
          width: double.maxFinite,
          padding: EdgeInsets.only(top: 252.v),
          child: Column(
            children: [
              Text(
                "BOOC",
                style: CustomTextStyles.righteousOnPrimary,
              ),
              SizedBox(height: 23.v),
              SizedBox(
                height: 164.v,
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
  void onTapScreenTitle(
    BuildContext context,
    String routeName,
  ) {
    Navigator.pushNamed(context, routeName);
  }
}
