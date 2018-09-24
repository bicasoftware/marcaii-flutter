import 'dart:async';

import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:marcaii_flutter/models/state/EmpregoDto.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Strings.dart';
import 'modules/main_act/MainAct.dart';
import 'modules/presentation/ActWelcome.dart';
import 'modules/splash_screen/SplashScreen.dart';
import 'state/MainState.dart';
import 'state/MarcaiiStateBuilder.dart';

class AppEntrance extends StatefulWidget {
  @override
  AppEntranceState createState() {
    return new AppEntranceState();
  }
}

class AppEntranceState extends State<AppEntrance> {
  MainState state;
  final AsyncMemoizer _memoizer = AsyncMemoizer();

  _fetchMe() {
    return _memoizer.runOnce(() async {
      bool fr = await isFirstRun();
      final state = await MarcaiiStateBuilder.buildState();

      Map<String, dynamic> map = {
        "isFirstRun": fr,
        "data": state,
      };

      return map;
    });
  }

  Future<bool> isFirstRun() async {
    final preferences = await SharedPreferences.getInstance();
    if (preferences.getKeys().contains(Consts.sharedPref_firstRun)) {
      return preferences.getBool(Consts.sharedPref_firstRun);
    } else {
      preferences.setBool(Consts.sharedPref_firstRun, true);
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Strings.app_name,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        primaryColor: Colors.indigo,
        primaryColorLight: Colors.white70,
        accentColor: Colors.blueAccent,
        brightness: Brightness.light,
        dividerColor: Colors.grey,
      ),
      home: FutureBuilder(
        future: _fetchMe(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("Erro lendo dados do cliente");
          } else {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return SplashScreen();
            } else if (snapshot.connectionState == ConnectionState.done) {
              return ScopedModel<MainState>(
                model: snapshot.data["data"],
                child: MaterialApp(
                  title: Strings.app_name,
                  theme: ThemeData(
                    primaryColor: Colors.indigo,
                    primaryColorLight: Colors.white70,
                    accentColor: Colors.blueAccent,
                    brightness: Brightness.light,
                    dividerColor: Colors.grey,
                  ),
                  home: WelcomeOrMain(resultMap: snapshot.data),
                ),
              );
            }
          }
        },
      ),
    );
  }
}

class WelcomeOrMain extends StatefulWidget {
  final Map<String, dynamic> resultMap;

  const WelcomeOrMain({Key key, this.resultMap}) : super(key: key);

  _WelcomeOrMainState createState() => _WelcomeOrMainState();
}

class _WelcomeOrMainState extends State<WelcomeOrMain> {
  List<Widget> viewList = [];
  Widget _visibleView;
  MainState state;
  bool isFirstRun;

  void initState() {
    state = widget.resultMap["data"] as MainState;
    isFirstRun = widget.resultMap["isFirstRun"] as bool;
    viewList = [
      ActWelcome(onFinished: _onFinished),
      MainAct(hasEmprego: state.empregos.length > 0)
    ];
    _visibleView = isFirstRun ? viewList[0] : viewList[1];
    super.initState();
  }

  void _onFinished(EmpregoDto emprego) {
    SharedPreferences.getInstance().then((instance) async {
      await instance.setBool(Consts.sharedPref_firstRun, false);
      state.appendEmprego(emprego);
    }).whenComplete(() {
      setState(() {
        _visibleView = viewList[1];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return _visibleView;
  }
}
