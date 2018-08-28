import 'package:flutter/material.dart';

class TitleText extends StatelessWidget {
  final String text;
  final TextAlign align;
  final double size;

  const TitleText({
    Key key,
    this.text,
    this.align: TextAlign.left,
    this.size: 14.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Text(
        text,
        textAlign: align,
        style: TextStyle(color: Theme.of(context).accentColor, fontSize: size),
      ),
    );
  }
}
