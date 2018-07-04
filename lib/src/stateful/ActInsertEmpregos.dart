import 'package:flutter/material.dart';
import'package:marcaii_flutter/res/Strings.dart';
import 'package:marcaii_flutter/main.dart';
import 'PageEmpregoInfo.dart';

class ActInsertEmpregos extends StatefulWidget {
    @override
    _ActInsertEmpregosState createState() => _ActInsertEmpregosState();
}

class _ActInsertEmpregosState extends State<ActInsertEmpregos> with SingleTickerProviderStateMixin {

    TabController controller;

    @override
    void initState() {
        super.initState();
        controller = TabController(length: 2, vsync: this);
    }

    @override
    void dispose() {
        controller.dispose();
        super.dispose();
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                actions: <Widget>[
                    IconButton(
                        icon: Icon(Icons.save),
                        onPressed: () => Navigator.pop(context, "OPAAAA"),
                    )
                ],
                title: Text(Strings.actGetEmprego),

                bottom: TabBar(
                    controller: controller,
                    tabs: <Widget>[
                        Tab(icon: Icon(Icons.subtitles), text: Strings.dadosCargo,),
                        Tab(icon: Icon(Icons.list), text: Strings.porcentagens,),
                    ],
                ),
            ),

            body: TabBarView(
                controller: controller,
                children: <Widget>[
                    PageEmpregoInfo(),
                    Act2(),
                ],
            )
        );
    }
}
