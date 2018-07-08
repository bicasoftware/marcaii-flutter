import 'package:flutter/material.dart';

class Themes {
  static TextStyle getTitleTextStyle(BuildContext context) {
    return TextStyle(color: Theme
      .of(context)
      .accentColor, fontSize: 12.0);
  }

  static getContentTextStyle(BuildContext context) {
    return TextStyle(fontSize: 26.0);
  }

}