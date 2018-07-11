import 'package:flutter/material.dart';
import 'package:marcaii_flutter/models/MdEmpregos.dart';
import 'package:marcaii_flutter/modules/main_act/pages/page_calendario/PageCalendar.dart';
import 'package:marcaii_flutter/modules/main_act/pages/page_list_empregos/PageListEmpregos.dart';
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

  final List<MdEmpregos> _empregos = [
    MdEmpregos(
      id: 1,
      nomeEmprego: "Exemplo 1",
      diaFechamento: "25",
      bancoHoras: 0,
      porcNormal: "50",
      porcFeriados: "100",
      cargaHoraria: "220",
      horarioSaida: "18:00",
    ),
  ];

  List<MdEmpregos> get empregos => _empregos;
  MdEmpregos empregoAt(int pos) => _empregos[pos];

  int _mainPagePos = 0;

  void setCurrentPagePos(int i) {
    _mainPagePos = i;
    notifyListeners();
  }

  String get title => _titles[_mainPagePos];

  int get pos => _mainPagePos;

  Widget get currentPage => _mainPages[_mainPagePos];

  Icon get currentBottonIcon => _bottomBarIcons[_mainPagePos];

  Icon get currentFabIcon => _fabIcons[_mainPagePos];

  void appendEmprego(MdEmpregos emprego){
    _empregos.add(emprego);
    notifyListeners();
  }

  /**
   * TODO
   * implementar rotina pedindo acesso ao cartão de memória
   * mostrando dialog com opções de TXT e CSV
   * gerar arquivo no cartão de memória
   * */
}