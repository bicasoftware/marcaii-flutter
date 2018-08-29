import 'package:flutter/material.dart';
import 'package:marcaii_flutter/models/calendar/CalendarCellDto.dart';
import 'package:marcaii_flutter/models/state/DiferenciaisDto.dart';
import 'package:marcaii_flutter/models/state/SalariosDto.dart';
import 'package:marcaii_flutter/modules/main_act/pages/page_calendario/widgets/CalendarBody.dart';

class PageCalendarioItem extends StatelessWidget {
  const PageCalendarioItem({
    Key key,
    @required this.cells,
    @required this.listDifer,
    @required this.porcNormal,
    @required this.porcFeriados,
    @required this.cargaHoraria,
    @required this.salarios,
  }) : super(key: key);

  final List<CalendarCellDto> cells;
  final List<DiferenciaisDto> listDifer;
  final int porcNormal, porcFeriados, cargaHoraria;
  final List<SalariosDto> salarios;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          CalendarBody(
            cells: cells,
            listDifer: listDifer,
            porcNormal: porcNormal,
            porcFeriados: porcFeriados,
            cargaHoraria: cargaHoraria,
            salarios: salarios,
          )
        ],
      ),
    );
  }
}
