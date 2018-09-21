import 'package:flutter/material.dart';

class DotIndicator extends StatelessWidget {

  final Color color;

  const DotIndicator({Key key, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10.0,
      height: 10.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,        
      ),
    );
  }
}