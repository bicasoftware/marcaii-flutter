import 'package:flutter/material.dart';

class BaseDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 8.0,
      color: Theme.of(context).dividerColor,
    );
  }
}