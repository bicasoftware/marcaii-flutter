import 'package:flutter/material.dart';

class ExpandedRow extends StatelessWidget {

  final List<Widget> children;

  const ExpandedRow({Key key, this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: children,
      ),
    );
  }
}