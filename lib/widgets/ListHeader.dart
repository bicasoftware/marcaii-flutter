import 'package:flutter/material.dart';

class ListHeader extends StatelessWidget {
  const ListHeader({
    Key key,
    @required this.title,
    this.color,
    this.textColor,
  }) : super(key: key);

  final String title;
  final MaterialColor color;
  final MaterialColor textColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
            padding: EdgeInsets.all(8.0),
            color: color ?? Theme.of(context).primaryColor,
            child: Text(
              title ?? "Header",
              textAlign: TextAlign.left,
              style: Theme.of(context).primaryTextTheme.title,
            ),
          ),
        )
      ],
    );
  }
}
