import 'package:flutter/material.dart';
import '../core/app_export.dart';

class ResultFailedScreen extends StatefulWidget {
  final String searchTerm;

  ResultFailedScreen({Key? key, required this.searchTerm}) : super(key: key);

  @override
  _ResultFailedScreenState createState() => _ResultFailedScreenState();
}

class _ResultFailedScreenState extends State<ResultFailedScreen> {
  late TextEditingController headerController;

  @override
  void initState() {
    super.initState();
    headerController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SizedBox(
          width: double.maxFinite,
          child: Column(
            children: [
              _buildTwenty(context),
              SizedBox(height: 33.v),
              Padding(
                padding: EdgeInsets.only(
                  left: 49.h,
                  right: 36.h,
                ),
              ),
              SizedBox(height: 37.v),
              Container(
                width: 359.h,
                margin: EdgeInsets.only(
                  left: 42.h,
                  right: 27.h,
                ),
                child: FittedBox(
                  fit: BoxFit.fitHeight,
                  child: Text(
                    "Aluno(a): \n${widget.searchTerm}",
                    overflow: TextOverflow.clip,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.displayMedium,
                  ),
                ),
              ),
              SizedBox(height: 48.v),
              Expanded(
                child: Container(
                  width: 333.h,
                  alignment: Alignment.center,
                  child: Text(
                    "Nenhuma premiação encontrada!",
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.headlineSmall!.copyWith(
                      height: 1.33,
                    ),
                  ),
                ),
              ),
              Divider(
                color: appTheme.gray300,
              ),
              SizedBox(height: 39.v),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(
                    context,
                    AppRoutes.mainScreen,
                  );
                },
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(), backgroundColor: appTheme.blueGray700,
                  padding: EdgeInsets.all(20.h),
                ),
                child: Icon(Icons.home, color: Colors.white),
              ),
              SizedBox(height: 46.v),
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildTwenty(BuildContext context) {
    return SizedBox(
      height: 241.v,
      width: double.maxFinite,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 36.v),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 5.v),
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
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Text(
              "BOOC",
              style: theme.textTheme.headlineLarge,
            ),
          ),
        ],
      ),
    );
  }
}
