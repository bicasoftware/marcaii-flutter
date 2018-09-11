import 'package:flutter/material.dart';
import 'package:marcaii_flutter/Strings.dart';
import 'package:marcaii_flutter/modules/main_act/MainAct.dart';
import 'package:marcaii_flutter/modules/splash_screen/SplashScreen.dart';
import 'package:marcaii_flutter/state/MainState.dart';
import 'package:marcaii_flutter/state/MarcaiiStateBuilder.dart';
import 'package:scoped_model/scoped_model.dart';

class AppEntrance extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Strings.app_name,
      theme: ThemeData(
        primaryColor: Colors.indigo,
        primaryColorLight: Colors.white70,
        accentColor: Colors.blueAccent,
        brightness: Brightness.light,
        dividerColor: Colors.grey,
      ),
      home: FutureBuilder<MainState>(
        future: MarcaiiStateBuilder.buildState(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("Erro lendo dados do cliente");
          } else {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return SplashScreen();
            } else if (snapshot.connectionState == ConnectionState.done) {
              return ScopedModel<MainState>(
                model: snapshot.data,
                child: MaterialApp(
                  title: Strings.app_name,
                  theme: ThemeData(
                    primaryColor: Colors.indigo,
                    primaryColorLight: Colors.white70,
                    accentColor: Colors.blueAccent,
                    brightness: Brightness.light,
                    dividerColor: Colors.grey,
                  ),
                  home: MainAct(hasEmprego: snapshot.data.empregos.length > 0),
                ),
              );
            }
          }
        },
      ),
    );
  }
}
