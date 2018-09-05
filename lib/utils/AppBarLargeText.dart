import 'package:flutter/material.dart';

class AppBarLargeText extends StatelessWidget {
  const AppBarLargeText({Key key, this.text}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 20.0,
        color: Colors.white,
      ),
    );
  }
}
