import 'package:flutter/material.dart';

class ExpandedText extends StatelessWidget {
  final String text;
  final TextStyle innerStyle;
  final TextAlign align;

  const ExpandedText({Key key, @required this.text, this.innerStyle, this.align}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).primaryTextTheme.caption.copyWith(color: Colors.black);

    return Expanded(
      child: Text(
        text,        
        maxLines: 1,
        textAlign: align ?? TextAlign.left,
        style: innerStyle ?? theme,
      ),
    );
  }
}
