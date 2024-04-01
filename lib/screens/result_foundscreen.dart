import 'package:flutter/material.dart';
import 'package:BOOC/core/app_export.dart';

// Tela de resultado: Roteada apenas se a busca realizada na mainScreen tiver correspondências de nome em alguma URL de site de olímpiada
class ResultFoundScreen extends StatelessWidget {
  final String obmawards;
  final String obcawards;
  final String searchTerm;

  const ResultFoundScreen({
    Key? key,
    required this.obmawards,
    required this.obcawards,
    required this.searchTerm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: double.maxFinite,
          child: Column(
            children: [
              _buildTwentyTwo(context),
              SizedBox(height: 35.v),
              _buildFlexibleSizedbox(context),
              SizedBox(height: 96.v),
              Divider(
                color: appTheme.gray300,
              ),
              SizedBox(height: 50.v),
              Padding(
                padding: EdgeInsets.only(
                  left: 60.h,
                  right: 46.h,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 1.v),
                      child: CustomIconButton(
                        height: 68.adaptSize,
                        width: 68.adaptSize,
                        padding: EdgeInsets.all(12.h),
                        child: CustomImageView(
                          imagePath: ImageConstant.imgHome,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 1.v),
                      child: CustomIconButton(
                        height: 67.adaptSize,
                        width: 67.adaptSize,
                        padding: EdgeInsets.all(11.h),
                        child: CustomImageView(
                          imagePath: ImageConstant.imgVectorBlueGray700,
                        ),
                      ),
                    ),
                    CustomIconButton(
                      height: 67.adaptSize,
                      width: 67.adaptSize,
                      padding: EdgeInsets.all(10.h),
                      child: CustomImageView(
                        imagePath: ImageConstant.imgGridiconsCustomize,
                      ),
                    ),
                  ],
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
  Widget _buildTwentyTwo(BuildContext context) {
    return SizedBox(
      height: 355.v,
      width: double.maxFinite,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 31.v),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 137.v,
                    width: 224.h,
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
                  SizedBox(
                    height: 3.v,
                    width: 233.h,
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
                  Text(
                    "BOOC",
                    style: theme.textTheme.headlineLarge,
                  ),
                  SizedBox(height: 12.v),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              width: 359.h,
              child: Text(
                "Aluno(a): \n$searchTerm",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: theme.textTheme.displayMedium,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildFlexibleSizedbox(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24.h),
      padding: EdgeInsets.symmetric(
        horizontal: 19.h,
        vertical: 20.v,
      ),
      decoration: AppDecoration.outlineGray70001.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder10,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "OBM - 2022",
            style: CustomTextStyles.headlineSmallGray80001,
          ),
          SizedBox(height: 10.v),
          _buildMeans(
            context,
            pontuaO: "Local de realização:",
            oneHundredFiftyEight: "Fortaleza - CE",
          ),
          SizedBox(height: 10.v),
          _buildMeans(
            context,
            pontuaO: "Pontuação: ",
            oneHundredFiftyEight: "158",
          ),
          SizedBox(height: 9.v),
          _buildMeans(
            context,
            pontuaO: "Medalha: ",
            oneHundredFiftyEight: "Prata",
          ),
          SizedBox(height: 9.v),
        ],
      ),
    );
  }

  /// Common widget
  Widget _buildMeans(
    BuildContext context, {
    required String pontuaO,
    required String oneHundredFiftyEight,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 15.h,
        vertical: 12.v,
      ),
      decoration: AppDecoration.fillPrimary.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder10,
      ),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 4.v),
            child: Text(
              pontuaO,
              style: CustomTextStyles.titleMediumPrimaryContainer.copyWith(
                color: theme.colorScheme.primaryContainer,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 10.h,
              top: 2.v,
            ),
            child: Text(
              oneHundredFiftyEight,
              style: theme.textTheme.titleMedium!.copyWith(
                color: appTheme.blue500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
