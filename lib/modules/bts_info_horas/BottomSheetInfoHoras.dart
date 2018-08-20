import 'package:flutter/material.dart';
import 'package:marcaii_flutter/modules/bts_info_horas/PresenterBtsInfoHora.dart';
import 'package:marcaii_flutter/state/CalendarCellDto.dart';
import 'package:marcaii_flutter/state/DiferenciaisDto.dart';

class BottomSheetInfoHoras extends StatelessWidget {
  final CalendarCellDto cell;
  final double salarioHora;
  final int porcNormal, porcFeriados;
  final List<DiferenciaisDto> listDif;

  const BottomSheetInfoHoras({
    Key key,
    @required this.cell,
    @required this.salarioHora,
    @required this.porcNormal,
    @required this.porcFeriados,
    @required this.listDif,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final presenter = PresenterBtsInfoHora(
      cell: cell,
      salarioHora: salarioHora,
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
