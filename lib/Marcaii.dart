import 'package:flutter/material.dart';
import 'package:marcaii_flutter/Strings.dart';
import 'package:marcaii_flutter/models/state/EmpregoDto.dart';
import 'package:marcaii_flutter/modules/act_get_empregos/ActInsertEmpregos.dart';
import 'package:marcaii_flutter/modules/act_relacao/ActRelacao.dart';
import 'package:marcaii_flutter/modules/main_act/MainAct.dart';
import 'package:marcaii_flutter/state/MainState.dart';
import 'package:scoped_model/scoped_model.dart';

class Marcaii extends StatefulWidget {
  const Marcaii({Key key, this.state}) : super(key: key);
  final MainState state;

  @override
  MarcaiiState createState() => MarcaiiState();
}

class MarcaiiState extends State<Marcaii> {
  MainState state;

  @override
  Widget build(BuildContext context) {
    return ScopedModel<MainState>(
      model: widget.state,
      child: MaterialApp(
        title: Strings.appName,
        theme: ThemeData(
          primaryColor: Colors.indigo,
          primaryColorLight: Colors.white70,
          accentColor: Colors.blueAccent,
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
