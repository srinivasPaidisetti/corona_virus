import 'package:coronavirus/ui/base_widget.dart';
import 'package:coronavirus/utils/common_utils.dart';
import 'package:coronavirus/utils/image_utils.dart';
import 'package:coronavirus/utils/res/colors.dart';
import 'package:coronavirus/utils/string_utils.dart';
import 'package:coronavirus/viewmodels/appmodel/app_model.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  @override
  Widget build(BuildContext context) {
    return BaseWidget<AppModel>(
      model: AppModel(),
      onModelReady: (model) => model.init(context),
      builder: (context, model, child) {
        return Scaffold(
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0.1, 0.3, 0.8, 1.0],
                colors: [
                  primaryColor,
                  primaryColorDark,
                  primaryColorDark,
                  primaryColor
                ],
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ImageUtils.getImage(
                      imageType: IMAGE.ICON,
                      imageName: 'corona-virus-logo.png',
                      color: lightGreyColor),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    appTitle,
                    style: textStyleBold,
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
