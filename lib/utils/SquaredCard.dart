import 'package:flutter/material.dart';

class SquaredCard extends StatelessWidget {
  final Widget child;
  final double padding;
  final EdgeInsets margin;
  final Color borderColor;
  final Color fillColor;

  const SquaredCard({
    Key key,
    this.child,
    this.padding: 0.0,
    this.margin,
    this.borderColor: Colors.grey,
    this.fillColor: Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: fillColor,
      shape: RoundedRectangleBorder(
        side: BorderSide(width: 0.0, color: borderColor),
      ),
      elevation: 0.0,
      margin: margin,
      child: Container(padding: EdgeInsets.all(padding), child: child),
    );
  }
}
