import 'package:flutter/material.dart';

class DualLineAppbar extends AppBar {

  final String bigText, smallText;
  final List<Widget> actions;

  DualLineAppbar({
    Key key,
    @required this.bigText,
    @required this.smallText,
    this.actions,
  }) : super(key: key, actions: actions, title: _buildTitle(bigText, smallText));

  static Widget _buildTitle(String bigText, String smallText) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          bigText,
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.white,
          ),
        ),
        Text(
          smallText,
          style: TextStyle(
            fontSize: 14.0,
            color: Colors.white,
          ),
        )
      ],
    );
  }
}
