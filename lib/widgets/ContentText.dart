import 'package:flutter/material.dart';

class ContentText extends StatelessWidget {
  final String text;

  const ContentText({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Text(
        text,
        style: TextStyle(fontSize: 16.0),
      ),
    );
  }
}
