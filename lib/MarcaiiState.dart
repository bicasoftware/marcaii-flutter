import 'package:flutter/material.dart';
import 'package:marcaii_flutter/fragments/pageCalendar/PageCalendar.dart';
import 'package:marcaii_flutter/fragments/pageListEmpregos/PageListEmpregos.dart';
import 'package:scoped_model/scoped_model.dart';

class MarcaiiState extends Model {

  final _mainPages = [
    PageListEmpregos(),
    PageCalendar(),
  ];

  final _bottomBarIcons = [
    Icon(Icons.work),
    Icon(Icons.date_range),
  ];

  final _fabIcons = [
    Icon(Icons.add),
    Icon(Icons.list),
  ];

  final _titles = [
    "Cargos", "Calendario"
  ];

  int _mainPagePos = 0;

  String get title => _titles[_mainPagePos];
  int get pos => _mainPagePos;
  Widget get currentPage => _mainPages[_mainPagePos];
  Icon get currentBottonIcon => _bottomBarIcons[_mainPagePos];
  Icon get currentFabIcon => _fabIcons[_mainPagePos];

  void setCurrentPagePos(int i) {
    _mainPagePos = i;
    notifyListeners();
  }

}