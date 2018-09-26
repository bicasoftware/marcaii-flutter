import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marcaii_flutter/Strings.dart';
import 'package:marcaii_flutter/models/state/EmpregoDto.dart';
import 'package:marcaii_flutter/modules/act_get_empregos/ActInsertEmpregos.dart';
import 'package:marcaii_flutter/modules/act_relacao/ActRelacao.dart';
import 'package:marcaii_flutter/modules/main_act/PlaceholderCalendario.dart';
import 'package:marcaii_flutter/modules/page_calendario/ViewPageCalendario.dart';
import 'package:marcaii_flutter/modules/page_list_emprego/PageListEmpregos.dart';
import 'package:marcaii_flutter/state/MainState.dart';
import 'package:scoped_model/scoped_model.dart';

class MainAct extends StatefulWidget {
  final bool hasEmprego;

  const MainAct({Key key, @required this.hasEmprego}) : super(key: key);

  @override
  State createState() => _MainState();
}

class _MainState extends State<MainAct> with SingleTickerProviderStateMixin {
  int _mainPagePos = 0;
  CrossFadeState _crossFadeState;

  void initState() {
    //se já existem empregos salvos, vai direto pro calendário
    if (widget.hasEmprego) {
      _crossFadeState = CrossFadeState.showSecond;
      _mainPagePos = 1;
    } else {
      _crossFadeState = CrossFadeState.showFirst;
      _mainPagePos = 0;
    }
    super.initState();
  }

  void _setPagePos(int i) {
    if (i != _mainPagePos) setState(() => _mainPagePos = i);
  }

  static const _bottomBarIcons = const [
    Icon(Icons.work),
    Icon(Icons.date_range),
  ];

  static const _fabIcons = const [
    Icon(Icons.add),
    Icon(Icons.list),
  ];

  static const _fabLabel = const [
    Strings.novo,
    Strings.verTotais,
  ];

  static const _titles = const ["Cargos", "Calendario"];

  String get title => _titles[_mainPagePos];

  Icon get currentBottonIcon => _bottomBarIcons[_mainPagePos];

  Icon get currentFabIcon => _fabIcons[_mainPagePos];

  String get currentFabLabel => _fabLabel[_mainPagePos];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScopedModelDescendant<MainState>(
        builder: (context, child, model) {
          return AnimatedCrossFade(
            crossFadeState: _crossFadeState,
            layoutBuilder: (tela1, key1, tela2, key2) {
              return Stack(
                fit: StackFit.loose,
                children: <Widget>[
                  Positioned(
                    key: key2,
                    child: tela2,
                  ),
                  Positioned(
                    key: key1,
                    child: tela1,
                  ),
                ],
              );
            },
            firstChild: PageListEmpregos(title: Strings.empregos),
            secondChild: model.hasEmpregos ? ViewPageCalendario() : PlaceholderCalendario(),
            duration: Duration(milliseconds: 300),
            alignment: Alignment.bottomCenter,
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _mainPagePos,
        items: [
          BottomNavigationBarItem(title: Text("Empregos"), icon: Icon(Icons.work)),
          BottomNavigationBarItem(title: Text("Calendário"), icon: Icon(Icons.date_range))
        ],
        onTap: (i) {
          _setPagePos(i);
          if (i == 0) {
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
                final result = await Navigator.of(context).push(
                  CupertinoPageRoute(
                      fullscreenDialog: true,
                      builder: (c) {
                        return ActInsertEmpregos(
                          emprego: EmpregoDto.newInstance(),
                        );
                      }),
                );
                if (result != null && result is EmpregoDto) {
                  model.appendEmprego(result);
                }
              } else {
                if (model.hasEmpregos) {
                  Navigator.of(context).push(
                    CupertinoPageRoute(
                      fullscreenDialog: true,
                      builder: (c) {
                        return ActRelacao(
                          model: model.empregos[model.currentPageViewPosition].toModelRelacao(
                            ano: model.currentYear,
                            mes: model.currentMonth,
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text(Strings.nadaTotalizar),
                    )
                  );
                }
              }
            },
          );
        },
      ),
    );
  }
}
