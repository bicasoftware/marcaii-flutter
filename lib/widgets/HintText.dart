import 'package:flutter/material.dart';

class HintText extends StatelessWidget {
  final String text;
  final TextAlign align;

  const HintText({Key key, @required this.text, this.align: TextAlign.left}) : super(key: key);

  static TextStyle hintTextStyle(BuildContext context) {
    return Theme
        .of(context)
        .primaryTextTheme
        .caption
        .copyWith(color: Theme.of(context).accentColor);
  }

  @override
  Widget build(BuildContext context) {
    return Text(text, textAlign: align, style: hintTextStyle(context));
  }
}
