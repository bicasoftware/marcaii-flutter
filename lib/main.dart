import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:marcaii_flutter/AppEntrance.dart';

void main() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(AppEntrance());
  });
}
