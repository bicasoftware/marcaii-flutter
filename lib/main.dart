import 'package:flutter/material.dart';
import 'package:marcaii_flutter/MainState.dart';
import 'package:marcaii_flutter/Marcaii.dart';
import 'package:marcaii_flutter/MarcaiiStateBuilder.dart';

void main() {
  MainState state;
  MarcaiiStateBuilder
      .buildState()
      .then((s) => state = s)
      .whenComplete(() => runApp(Marcaii(state: state)));
}
