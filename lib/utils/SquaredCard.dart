import 'package:flutter/material.dart';

class SquaredCard extends StatelessWidget {
  final Widget child;
  final double padding;
  final EdgeInsets margin;

  const SquaredCard({Key key, this.child, this.padding: 0.0, this.margin}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(width: 0.0, color: Theme.of(context).dividerColor),
      ),
      elevation: 0.0,
      margin: margin,
      child: Container(
        padding: EdgeInsets.all(padding),
        child: child
      ),
    );
  }
}
