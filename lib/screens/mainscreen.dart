import 'package:teste_olimpiadas/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:teste_olimpiadas/core/app_export.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.only(
            left: 27.h,
            top: 69.v,
            right: 27.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _buildFourteen(context),
              SizedBox(height: 25.v),
              CustomElevatedButton(
                text: "Pesquise o nome do(a) Aluno(a)",
                margin: EdgeInsets.only(
                  left: 25.h,
                  right: 6.h,
                ),
              ),
              SizedBox(height: 20.v),
              Container(
                height: 223.v,
                width: 232.h,
                margin: EdgeInsets.only(right: 53.h),
                child: Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Container(
                        height: 196.adaptSize,
                        width: 196.adaptSize,
                        padding: EdgeInsets.only(
                          left: 59.h,
                          top: 59.v,
                        ),
                        decoration: AppDecoration.outlineBlueGray.copyWith(
                          borderRadius: BorderRadiusStyle.circleBorder98,
                        ),
                        child: CustomImageView(
                          imagePath: ImageConstant.imgSearch,
                          height: 69.adaptSize,
                          width: 69.adaptSize,
                          alignment: Alignment.topLeft,
                        ),
                      ),
                    ),
                    CustomImageView(
                      imagePath: ImageConstant.imgInbox,
                      height: 55.adaptSize,
                      width: 55.adaptSize,
                      alignment: Alignment.topRight,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 79.v),
              Container(
                height: 137.v,
                width: 224.h,
                margin: EdgeInsets.only(right: 65.h),
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
                margin: EdgeInsets.only(right: 62.h),
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
                padding: EdgeInsets.only(right: 131.h),
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
    );
  }

  /// Section Widget
  Widget _buildFourteen(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 1.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 125.v,
            width: 253.h,
            margin: EdgeInsets.only(bottom: 8.v),
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                CustomImageView(
                  imagePath: ImageConstant.imgObmProvisorio,
                  height: 125.v,
                  width: 200.h,
                  alignment: Alignment.centerRight,
                ),
                CustomImageView(
                  imagePath: ImageConstant.imgLogoObc,
                  height: 93.v,
                  width: 150.h,
                  alignment: Alignment.centerLeft,
                ),
              ],
            ),
          ),
          CustomImageView(
            imagePath: ImageConstant.imgLogoObi,
            height: 130.v,
            width: 122.h,
            margin: EdgeInsets.only(top: 3.v),
          ),
        ],
      ),
    );
  }
}
