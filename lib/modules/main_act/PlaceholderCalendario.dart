import 'package:flutter/material.dart';
import 'package:marcaii_flutter/Strings.dart';

class PlaceholderCalendario extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.calendario),
      ),
      body: Center(
        child: Text(Strings.emptyEmprego),
      ),
    );
  }
}
