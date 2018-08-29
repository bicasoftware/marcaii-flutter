import 'package:flutter/material.dart';
import 'package:marcaii_flutter/Strings.dart';
import 'package:marcaii_flutter/models/state/EmpregoDto.dart';
import 'package:marcaii_flutter/modules/page_calendario/ViewPageCalendario.dart';
import 'package:marcaii_flutter/modules/page_list_emprego/PageListEmpregos.dart';
import 'package:marcaii_flutter/state/MainState.dart';
import 'package:scoped_model/scoped_model.dart';

class MainAct extends StatefulWidget {
  @override
  State createState() => _MainState();
}

class _MainState extends State<MainAct> with SingleTickerProviderStateMixin {
  int _mainPagePos = 0;
  CrossFadeState _crossFadeState;

  void initState() { 
    _crossFadeState = CrossFadeState.showFirst;  
    super.initState();
  }

  void _setPagePos(int i) {
    if(i != _mainPagePos) setState(() => _mainPagePos = i);
  }

  static final _mainPages = [ 
    const PageListEmpregos(title: Strings.empregos),
    const ViewPageCalendario(),
  ];

  static final _bottomBarIcons = [
    Icon(Icons.work),
    Icon(Icons.date_range),
  ];

  static final _fabIcons = [
    Icon(Icons.add),
    Icon(Icons.list),
  ];

  static final _fabLabel = [
    Strings.novo,
    Strings.verTotais,
  ];

  static final _titles = ["Cargos", "Calendario"];

  String get title => _titles[_mainPagePos];

  Widget get currentPage => _mainPages[_mainPagePos];

  Icon get currentBottonIcon => _bottomBarIcons[_mainPagePos];

  Icon get currentFabIcon => _fabIcons[_mainPagePos];

  String get currentFabLabel => _fabLabel[_mainPagePos];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //body: currentPage,
      body: AnimatedCrossFade(
        crossFadeState: _crossFadeState,
        firstChild: _mainPages[0],
        secondChild: _mainPages[1],
        duration: Duration(milliseconds: 200),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _mainPagePos,
        items: [
          BottomNavigationBarItem(title: Text("Empregos"), icon: Icon(Icons.work)),
          BottomNavigationBarItem(title: Text("Calendário"), icon: Icon(Icons.date_range))
        ],
        onTap: (i) {
          _setPagePos(i);
          if(i == 0){
            _crossFadeState = CrossFadeState.showFirst;
          } else {
            _crossFadeState = CrossFadeState.showSecond;
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: ScopedModelDescendant<MainState>(
        rebuildOnChange: false,
        builder: (context, child, model) {
          return FloatingActionButton.extended(
            icon: currentFabIcon,
            label: Text(currentFabLabel),
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
          );
        },
      ),
    );
  }
}
