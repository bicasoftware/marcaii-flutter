import 'package:flutter/material.dart';
import 'package:marcaii_flutter/MarcaiiState.dart';
import 'package:marcaii_flutter/activities/MainAct.dart';
import 'package:marcaii_flutter/res/Strings.dart';
import 'package:marcaii_flutter/activities/ActInsertEmpregos.dart';
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
          primaryColor: Colors.indigo,
          accentColor: Colors.blue,
          brightness: Brightness.light,
          bottomAppBarColor: Colors.indigo,
          dividerColor: Colors.blueGrey,
        ),
        home: MainAct(),
        routes: <String, WidgetBuilder>{
          Refs.refActGetEmprego: (BuildContext context) => ActInsertEmpregos(),
        }
      ),
    );
  }
}