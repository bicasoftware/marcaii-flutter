import 'package:flutter/material.dart';
import 'package:marcaii_flutter/Strings.dart';

class PlaceholderCalendario extends StatelessWidget {

  const PlaceholderCalendario({Key key}):super(key: key);

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
