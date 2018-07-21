import 'package:flutter/material.dart';
import 'package:marcaii_flutter/MarcaiiState.dart';
import 'package:marcaii_flutter/Strings.dart';
import 'package:marcaii_flutter/models/MdEmpregos.dart';
import 'package:marcaii_flutter/modules/act_get_empregos/ActInsertEmpregos.dart';
import 'package:marcaii_flutter/modules/act_relacao/ActRelacao.dart';
import 'package:marcaii_flutter/modules/main_act/MainAct.dart';
import 'package:marcaii_flutter/utils/PercentDialog.dart';
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
          accentColor: Colors.red,
          buttonColor: Colors.redAccent,
          disabledColor: Colors.blueGrey,
          brightness: Brightness.light,
          dividerColor: Colors.grey,
        ),
        home: MainAct(),
        routes: <String, WidgetBuilder>{
          Refs.refActGetEmprego: (BuildContext context) {
            return ActInsertEmpregos(emprego: MdEmpregos.getNewInstance());
          },
          Refs.refActRelatorio: (BuildContext context) => ActRelacao(),
        },
      ),
    );
  }
}

class TesteHome extends StatefulWidget {
  TesteHomeState createState() => TesteHomeState();
}

class TesteHomeState extends State<TesteHome> {
  int _percent = 12;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dialog Percent"),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: MaterialButton(
                    child: Text("Mostrar"),
                    onPressed: () async {
                      final p = await showPercentDialog(context: context, percent: _percent);
                      if (p != null) {
                        print(p.toString());
                        setState(() {
                          _percent = p;
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: <Widget>[
              Text("porcentagem"),
              Text("$_percent %"),
            ],
          ),
        ],
      ),
    );
  }
}
