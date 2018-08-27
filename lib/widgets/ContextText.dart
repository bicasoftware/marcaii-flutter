import 'package:flutter/material.dart';

class ContextText extends StatelessWidget {
  final String text;

  const ContextText({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Text(
        text,
        style: TextStyle(fontSize: 20.0),
      ),
    );
  }
}
