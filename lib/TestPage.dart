import 'package:flutter/material.dart';
import 'package:marcaii_flutter/MarcaiiStateBuilder.dart';
import 'package:marcaii_flutter/Strings.dart';
import 'package:marcaii_flutter/modules/act_relacao/ActRelacao.dart';

class TestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Strings.appName,
      theme: ThemeData(
        primaryColor: Colors.indigo,
        accentColor: Colors.red,
        buttonColor: Colors.redAccent,
        disabledColor: Colors.blueGrey,
        brightness: Brightness.light,
        dividerColor: Colors.grey,
      ),
      home: TestScaffold(),
      routes: <String, WidgetBuilder>{
        Refs.refActGetEmprego: (BuildContext context) {
          //return ActInsertEmpregos(emprego: MdEmpregos.getNewInstance());
        },
        Refs.refActRelatorio: (BuildContext context) => ActRelacao(),
      },
    );
  }

  //todo - pode bugar!!!
  getAppState() async => await MarcaiiStateBuilder.buildState();
}

class TestScaffold extends StatelessWidget {
  void _ler() async {
    try {
      final state = await MarcaiiStateBuilder.buildState();
      print(state);
    } catch (e) {
      print(e);
    }
  }

  void _insertFirstRecord() async {
    try {
      MarcaiiStateBuilder.doOnFirstRun();
    } catch (e) {
      print(e);
    }
  }

//todo - testar MarcaiiStateBuilder, testar carregar isso no ScopedModel
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Teste"),
      ),
      body: Container(
        margin: EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            MaterialButton(
              onPressed: _ler,
              child: Text(
                "Ler Banco",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              color: Theme.of(context).primaryColor,
            ),
            FlatButton(
              color: Theme.of(context).accentColor,
              child: Text("Inserir Dados"),
              onPressed: _insertFirstRecord,
            ),
          ],
        ),
      ),
    );
  }
}
