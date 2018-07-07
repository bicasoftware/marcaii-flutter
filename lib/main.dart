import 'package:flutter/material.dart';
import 'package:marcaii_flutter/MarcaiiState.dart';
import 'package:marcaii_flutter/res/Strings.dart';
import 'package:marcaii_flutter/src/stateful/ActInsertEmpregos.dart';
import 'package:scoped_model/scoped_model.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {

  var marcaiiState = MarcaiiState();

  @override
  Widget build(BuildContext context) {
    return ScopedModel<MarcaiiState>(
      model: marcaiiState,
      child: MaterialApp(
        title: "Marcaii - Flutter",
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

class MainAct extends StatefulWidget {
  @override
  State createState() => _MainState();
}

class _MainState extends State<MainAct> with SingleTickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MarcaiiState>(
      builder: (context, child, model) => Scaffold(
        resizeToAvoidBottomPadding: true,
        appBar: AppBar(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                Strings.appName,
                style: TextStyle(
                  fontSize: 22.0,
                  color: Colors.white
                ),
              ),
              Text(
                model.title,
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.white
                ),
              )
            ],
          ),

        ),

        body: model.currentPage,

        bottomNavigationBar: BottomNavigationBar(
          currentIndex: model.pos,

          items: [
            BottomNavigationBarItem(
              title: Text("Empregos",),
              icon: Icon(Icons.work,),
            ),
            BottomNavigationBarItem(
              title: Text("Calendário",),
              icon: Icon(Icons.date_range,),
            )
          ],

          onTap: (i) {
            model.setCurrentPagePos(i);
          },
        ),

        floatingActionButton: FloatingActionButton(
          //onPressed: () => Navigator.of(context).pushNamed(Refs.refActGetEmprego),
          onPressed: () {
            _callActGetEmpregos(context);
          },
          child: model.currentFabIcon,
        ),

      ),
    );
  }

  _callActGetEmpregos(BuildContext ctx) async {
    final result = await Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => ActInsertEmpregos())
    );

    //todo - Receber o state da ActInsertEmpregos e salvar na lista de empregos!

    print(result);
  }
}