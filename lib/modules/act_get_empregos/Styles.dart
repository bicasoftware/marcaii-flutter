import 'package:flutter/material.dart';

class Styles {
  static TextStyle getListTitleStyle(BuildContext context) {
    return TextStyle(
      color: Colors.black87,
      fontSize: 14.0,
      //fontWeight: FontWeight.bold,
    );
  }

  static TextStyle getListSubtitleStyle(BuildContext context) {
    return TextStyle(
      color: Theme.of(context).accentColor,
      fontSize: 14.0,
      fontWeight: FontWeight.normal,
    );
  }
}
