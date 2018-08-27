import 'package:flutter/material.dart';

class ErrorText extends StatelessWidget {
  final String text;
  final TextAlign align;

  const ErrorText({Key key, @required this.text, this.align: TextAlign.left}) : super(key: key);

  static TextStyle errorTextStyle(BuildContext context) {
    return Theme
        .of(context)
        .primaryTextTheme
        .caption
        .copyWith(color: Theme.of(context).errorColor, fontWeight: FontWeight.bold);
  }

  @override
  Widget build(BuildContext context) {
    return Text(text, textAlign: align, style: errorTextStyle(context));
  }
}
