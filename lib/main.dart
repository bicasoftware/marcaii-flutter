import 'package:flutter/material.dart';
import 'package:marcaii_flutter/res/Strings.dart';
import 'package:marcaii_flutter/src/stateful/ActInsertEmpregos.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {

    @override
    Widget build(BuildContext context) {
        return MaterialApp(
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
        );
    }
}

class MainAct extends StatefulWidget {
    @override
    State createState() => _MainState();
}

class _MainState extends State<MainAct> with SingleTickerProviderStateMixin {

    TabController tabController;
    int _tabIndex = 0;
    final fabIcons = [
        Icon(Icons.add),
        Icon(Icons.list)
    ];

    final subtitles = [Strings.empregos, Strings.calendario];

    void _setIndex(int i) {
        setState(() {
            _tabIndex = i;
        });
    }

    @override
    void initState() {
        super.initState();
        tabController = TabController(length: 2, vsync: this);
    }

    @override
    void dispose() {
        super.dispose();
        tabController.dispose();
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
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
                            subtitles[_tabIndex],
                            style: TextStyle(
                                fontSize: 12.0,
                                color: Colors.white
                            ),
                        )
                    ],
                ),

            ),

            body: TabBarView(
                children: <Widget>[
                    Act2(),
                    Act3()
                ],

                controller: tabController,
            ),

            bottomNavigationBar: BottomNavigationBar(
                currentIndex: _tabIndex,

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
                    tabController.animateTo(i);
                    _setIndex(i);
                },
            ),

            floatingActionButton: FloatingActionButton(
                //onPressed: () => Navigator.of(context).pushNamed(Refs.refActGetEmprego),
                onPressed: (){
                    _callActGetEmpregos(context);
                },
                child: fabIcons[_tabIndex],
            ),

        );
    }

    _callActGetEmpregos(BuildContext ctx) async {
        final result = await Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => ActInsertEmpregos())
        );

        print(result);
    }
}

class Act2 extends StatelessWidget {

    @override
    Widget build(BuildContext context) {
        return Container(
            alignment: Alignment.center,
            margin: EdgeInsets.all(8.0),
            padding: EdgeInsets.all(8.0),

            child: Column(
                children: <Widget>[
                    Text("Activity 2"),
                ],
            ),
        );
    }
}

class Act3 extends StatelessWidget {

    @override
    Widget build(BuildContext context) {
        return Container(
            margin: EdgeInsets.all(8.0),
            padding: EdgeInsets.all(16.0),
            child: Column(
                children: <Widget>[
                    Text("Activity 3"),
                    FlatButton(
                        child: Text("Voltar"),
                        onPressed: () => Navigator.pop(context, "OPAAAAA, popiou"),
                    ),
                ],
            )
        );
    }
}



