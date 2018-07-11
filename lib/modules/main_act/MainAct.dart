import 'package:flutter/material.dart';
import 'package:marcaii_flutter/MarcaiiState.dart';
import 'package:marcaii_flutter/Strings.dart';
import 'package:marcaii_flutter/models/MdEmpregos.dart';
import 'package:marcaii_flutter/modules/act_get_empregos/ActInsertEmpregos.dart';
import 'package:scoped_model/scoped_model.dart';

class MainAct extends StatefulWidget {
  @override
  State createState() => _MainState();
}

class _MainState extends State<MainAct> with SingleTickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MarcaiiState>(
      builder: (context, child, model) =>
        Scaffold(
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
            onPressed: () async {
              if (model.pos == 0) {
                final result = await Navigator.pushNamed(context, Refs.refActGetEmprego);
                if(result is MdEmpregos && result != null){
                  model.appendEmprego(result);
                }
              } else {
                Navigator.of(context).pushNamed(Refs.refActRelatorio);
              }
            },
            child: model.currentFabIcon,
          ),
        ),
    );
  }
}