import 'package:flutter/material.dart';
import 'package:marcaii_flutter/fragments/PageListEmpregos/PageListEmpregos.dart';
import 'package:marcaii_flutter/fragments/pageCalendar/PageCalendar.dart';
import 'package:scoped_model/scoped_model.dart';

class MarcaiiState extends Model {

  final mainPages = [
    PageListEmpregos(),
    PageCalendar(),
  ];

  final bottomBarIcons = [
    Icon(Icons.work),
    Icon(Icons.date_range),
  ];

  final fabIcons = [
    Icon(Icons.add),
    Icon(Icons.list),
  ];

  int _mainPagePos = 0;
  final titles = [ "Cargos", "Calendario" ];
  String get title => titles[_mainPagePos];
  int get pos => _mainPagePos;
  Widget get currentPage => mainPages[_mainPagePos];
  Icon get currentBottonIcon => bottomBarIcons[_mainPagePos];
  Icon get currentFabIcon => fabIcons[_mainPagePos];

  void setCurrentPagePos(int i) {
    _mainPagePos = i;
    notifyListeners();
  }

}