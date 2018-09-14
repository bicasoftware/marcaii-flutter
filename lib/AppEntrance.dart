import 'dart:async';

import 'package:flutter/material.dart';
import 'package:marcaii_flutter/Strings.dart';
import 'package:marcaii_flutter/modules/main_act/MainAct.dart';
import 'package:marcaii_flutter/modules/splash_screen/SplashScreen.dart';
import 'package:marcaii_flutter/state/MainState.dart';
import 'package:marcaii_flutter/state/MarcaiiStateBuilder.dart';
import 'package:scoped_model/scoped_model.dart';

class AppEntrance extends StatefulWidget {
  @override
  AppEntranceState createState() {
    return new AppEntranceState();
  }
}

class AppEntranceState extends State<AppEntrance> {
  MainState state;

  Future<MainState> generateState() async {
    if (state == null) {
      state = await MarcaiiStateBuilder.buildState();
    }
    return state;
  }

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
        future: generateState(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("Erro lendo dados do cliente");
          } else {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return SplashScreen();
            } else if (snapshot.connectionState == ConnectionState.done) {
              state = snapshot.data;
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
