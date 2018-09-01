import 'package:flutter/material.dart';
import 'package:marcaii_flutter/Marcaii.dart';
import 'package:marcaii_flutter/state/MainState.dart';
import 'package:marcaii_flutter/state/MarcaiiStateBuilder.dart';

///todo - criar animação para as tabs;
///Usar um Stack ao invés de uma list de itens

void main() {
  MainState state;
  MarcaiiStateBuilder
      .buildState()
      .then((s) => state = s)
      .whenComplete(() {
        MaterialPageRoute.debugEnableFadingRoutes = true;
        runApp(Marcaii(state: state));
      });
}
