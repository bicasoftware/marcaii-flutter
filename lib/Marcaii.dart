import 'dart:async';

import 'package:flutter/material.dart';
import 'package:marcaii_flutter/MainState.dart';
import 'package:marcaii_flutter/MarcaiiStateBuilder.dart';
import 'package:marcaii_flutter/Strings.dart';
import 'package:marcaii_flutter/models/state/EmpregoDto.dart';
import 'package:marcaii_flutter/modules/act_get_empregos/ActInsertEmpregos.dart';
import 'package:marcaii_flutter/modules/act_relacao/ActRelacao.dart';
import 'package:marcaii_flutter/modules/main_act/MainAct.dart';
import 'package:scoped_model/scoped_model.dart';

class Marcaii extends StatefulWidget {
  @override
  MarcaiiState createState() => MarcaiiState();
}

class MarcaiiState extends State<Marcaii> {
  MainState appState;
  String nome;

  @override
  Future initState() async {
    MarcaiiStateBuilder.buildState().then((state) => appState = state);
    nome == "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<MainState>(
      model: appState,
      child: MaterialApp(
        title: Strings.appName,
        theme: ThemeData(
          primaryColor: Colors.indigo,
          accentColor: Colors.red,
          buttonColor: Colors.redAccent,
          disabledColor: Colors.blueGrey,
          brightness: Brightness.light,
          dividerColor: Colors.grey,
        ),
        home: MainAct(),
        routes: <String, WidgetBuilder>{
          Refs.refActGetEmprego: (BuildContext context) {
            return ActInsertEmpregos(emprego: EmpregoDto.newInstance());
          },
          Refs.refActRelatorio: (BuildContext context) => ActRelacao(),
        },
      ),
    );
  }
}
