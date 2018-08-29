import 'package:flutter/material.dart';
import 'package:marcaii_flutter/models/calendar/CalendarCellDto.dart';
import 'package:marcaii_flutter/models/state/DiferenciaisDto.dart';
import 'package:marcaii_flutter/models/state/SalariosDto.dart';
import 'package:marcaii_flutter/modules/bts_info_horas/PresenterBtsInfoHora.dart';

class BottomSheetInfoHoras extends StatelessWidget {
  final CalendarCellDto cell;
  final int porcNormal, porcFeriados, cargaHoraria;
  final List<DiferenciaisDto> listDif;
  final List<SalariosDto> salarios;

  const BottomSheetInfoHoras({
    Key key,
    @required this.cell,
    @required this.porcNormal,
    @required this.porcFeriados,
    @required this.listDif,
    @required this.cargaHoraria,
    @required this.salarios,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final presenter = PresenterBtsInfoHora(
      cell: cell,
      cargaHoraria: cargaHoraria,
      salarios: salarios,
      porcNormal: porcNormal,
      porcFeriados: porcFeriados,
      listDif: listDif,
    );

    return Container(
      padding: EdgeInsets.only(
        top: 16.0,
        left: 36.0,
        bottom: 16.0,
        right: 16.0,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              presenter.getDateLabel(),
              presenter.getUpdateBtn(context),
              presenter.getDeleteBtn(context),
            ],
          ),
          Divider(),
          presenter.getMinutesLabel(context),
          Divider(),
          presenter.getTipoHora(),
          presenter.getValorHora(),
        ],
      ),
    );
  }
}
