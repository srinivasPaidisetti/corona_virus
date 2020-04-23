import 'package:coronavirus/utils/res/colors.dart';
import 'package:flutter/cupertino.dart';

TextStyle textStyleBold =
    TextStyle(color: lightGreyColor, fontSize: 30, fontWeight: FontWeight.bold);

navigateTo(BuildContext context, Widget name) {
  Navigator.push(context, CupertinoPageRoute(builder: (context) => name));
}
