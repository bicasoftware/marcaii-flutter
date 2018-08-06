import 'package:flutter/material.dart';

class HorizontalExpanded extends StatelessWidget {
  const HorizontalExpanded({Key key, this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[Expanded(child: child)]);
  }
}
