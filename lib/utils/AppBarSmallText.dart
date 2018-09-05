import 'package:flutter/material.dart';

class AppBarSmallText extends StatelessWidget {
  const AppBarSmallText({Key key, this.text}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 14.0,
        color: Colors.white,
      ),
    );
  }
}
