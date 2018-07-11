import 'package:flutter/material.dart';
import 'package:marcaii_flutter/MarcaiiState.dart';
import 'package:marcaii_flutter/Strings.dart';
import 'package:marcaii_flutter/models/MdEmpregos.dart';
import 'package:marcaii_flutter/modules/act_get_empregos/ActInsertEmpregos.dart';
import 'package:marcaii_flutter/modules/act_get_empregos/EmpregoState.dart';
import 'package:marcaii_flutter/modules/act_relacao/ActRelacao.dart';
import 'package:marcaii_flutter/modules/main_act/MainAct.dart';
import 'package:marcaii_flutter/utils/CurrencyUtils.dart';
import 'package:scoped_model/scoped_model.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ScopedModel<MarcaiiState>(
      model: MarcaiiState(),
      child: MaterialApp(
        title: Strings.appName,
        theme: ThemeData(
          primaryColor: Colors.deepPurple,
          accentColor: Colors.red,
          brightness: Brightness.light,
          dividerColor: Colors.blueGrey,
        ),
        home: MainAct(),
        routes: <String, WidgetBuilder>{
          Refs.refActGetEmprego: (BuildContext context) {
            return ActInsertEmpregos(
              emprego: MdEmpregos.getNewInstance()
            );
          },
          Refs.refActRelatorio: (BuildContext context) => ActRelacao(),
        }
      ),
    );
  }
}