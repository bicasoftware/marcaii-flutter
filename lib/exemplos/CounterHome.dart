import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:marcaii_flutter/res/Strings.dart';
import 'package:marcaii_flutter/models/CounterModel.dart';
import 'package:marcaii_flutter/main.dart';

class _CounterState extends State<MainAct> {

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
            home: ScopedModel<CounterModel>(
                model: CounterModel(),
                child: CounterHome(),
            ),
        );
    }
}

class CounterHome extends StatelessWidget {

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: Text("Scoped model Counter")
            ),

            body: Column(
                children: <Widget>[
                    Text("Counter: "),
                    ScopedModelDescendant<CounterModel>(
                        builder: (context, child, model) =>
                            Text(
                                model.count.toString(),
                            ),
                    )
                ],
            ),

            floatingActionButton: ScopedModelDescendant<CounterModel>(
                builder: (cont, child, model) =>
                    ButtonBar(
                        children: <Widget>[
                            IconButton(icon: Icon(Icons.remove), onPressed: model.dec,),
                            IconButton(icon: Icon(Icons.add), onPressed: model.inc,),
                            IconButton(icon: Icon(Icons.delete), onPressed: model.clear,)
                        ],
                    ),
            ),
        );
    }
}