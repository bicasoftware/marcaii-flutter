import 'package:flutter/material.dart';

class Styles {
  static hintStyle(BuildContext context) {
    return TextStyle(
      color: Theme.of(context).accentColor,
    );
  }

  static welcomeTextStyle(BuildContext context) {
    return TextStyle(
      fontSize: 30.0,
      color: Theme.of(context).accentColor,
    );
  }
}
