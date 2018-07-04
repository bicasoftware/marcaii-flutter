import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:marcaii_flutter/res/Strings.dart';
import 'package:marcaii_flutter/models/NomesModel.dart';
import 'package:marcaii_flutter/main.dart';

class _NomesState extends State<MainAct> {

    @override
    Widget build(BuildContext context) {
        return MaterialApp(
            title: Strings.appName,
            theme: ThemeData(
                primaryColor: Colors.indigo,
                accentColor: Colors.orange,
                accentColorBrightness: Brightness.dark,
                dividerColor: Colors.grey,
                primaryColorLight: Colors.blue,
            ),
            home: ScopedModel<NomesModel>(
                model: NomesModel(),
                child: NomeHome(),
            ),
        );
    }
}

class NomeHome extends StatelessWidget {

    @override
    Widget build(BuildContext context) =>
        Scaffold(
            appBar: AppBar(
                title: Text("Scoped model nomes")
            ),

            body: ScopedModelDescendant<NomesModel>(
                builder: (ctx, child, md) =>
                    Column(
                        children: <Widget>[
                            Expanded(child: ListView(children: md.getListView(),),)
                        ],
                    ),
            ),

            floatingActionButton: ScopedModelDescendant<NomesModel>(
                builder: (cont, child, model) =>
                    ButtonBar(
                        children: <Widget>[
                            IconButton(icon: Icon(Icons.remove), onPressed: model.removeLastNome,),
                            IconButton(icon: Icon(Icons.add), onPressed: model.addNome,),
                            IconButton(icon: Icon(Icons.delete), onPressed: model.clear,)
                        ],
                    ),
            ),
        );
}