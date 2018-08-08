import 'package:flutter/material.dart';
import 'package:marcaii_flutter/MainState.dart';
import 'package:marcaii_flutter/Strings.dart';
import 'package:marcaii_flutter/models/state/EmpregoDto.dart';
import 'package:marcaii_flutter/modules/main_act/pages/page_calendario/PageCalendar.dart';
import 'package:marcaii_flutter/modules/main_act/pages/page_list_empregos/PageListEmpregos.dart';
import 'package:marcaii_flutter/utils/DropDownAction.dart';
import 'package:marcaii_flutter/utils/Range.dart';
import 'package:scoped_model/scoped_model.dart';

class MainAct extends StatefulWidget {
  @override
  State createState() => _MainState();
}

class _MainState extends State<MainAct> with SingleTickerProviderStateMixin {
  int _mainPagePos = 0;

  void _setPagePos(int i) {
    setState(() {
      _mainPagePos = i;
    });
  }

  static List<DropdownMenuItem> get listAnos {
    final l = List<DropdownMenuItem>();
    for (final i in Range.range(2013, 2022)) {
      l.add(DropdownMenuItem(child: Text(i.toString()), value: i));
    }

    return l;
  }

  static final _mainPages = [
    PageListEmpregos(),
    PageCalendar(),
  ];

  static final _bottomBarIcons = [
    Icon(Icons.work),
    Icon(Icons.date_range),
  ];

  static final _fabIcons = [
    Icon(Icons.add),
    Icon(Icons.list),
  ];

  static final _titles = ["Cargos", "Calendario"];

  String get title => _titles[_mainPagePos];

  Widget get currentPage => _mainPages[_mainPagePos];

  Icon get currentBottonIcon => _bottomBarIcons[_mainPagePos];

  Icon get currentFabIcon => _fabIcons[_mainPagePos];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      //appBar: DualLineAppbar(bitText: Strings.appName, smallText: title),
      appBar: AppBar(
        title: Text(title),
        actions: <Widget>[
          ScopedModelDescendant<MainState>(
            builder: (_, __, st) {
              return DropDownAction<int>(
                onChanged: (i) {
                  st.setYear(i);
                },
                currentValue: st.currentYear,
                children: listAnos,
              );
            },
          ),
        ],
      ),
      body: currentPage,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _mainPagePos,
        items: [
          BottomNavigationBarItem(title: Text("Empregos"), icon: Icon(Icons.work)),
          BottomNavigationBarItem(title: Text("Calendário"), icon: Icon(Icons.date_range))
        ],
        onTap: (i) => _setPagePos(i),
      ),
      floatingActionButton: ScopedModelDescendant<MainState>(
        rebuildOnChange: false,
        builder: (context, child, model) {
          return FloatingActionButton(
            onPressed: () async {
              if (_mainPagePos == 0) {
                final result = await Navigator.pushNamed(context, Refs.refActGetEmprego);
                if (result != null && result is EmpregoDto) {
                  model.appendEmprego(result);
                }
              } else {
                Navigator.of(context).pushNamed(Refs.refActRelatorio);
              }
            },
            child: currentFabIcon,
          );
        },
      ),
    );
  }
}
