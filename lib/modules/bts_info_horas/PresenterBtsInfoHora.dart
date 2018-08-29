import 'package:flutter/material.dart';
import 'package:marcaii_flutter/Strings.dart';
import 'package:marcaii_flutter/models/calendar/CalendarCellDto.dart';
import 'package:marcaii_flutter/models/state/DiferenciaisDto.dart';
import 'package:marcaii_flutter/models/state/SalariosDto.dart';
import 'package:marcaii_flutter/modules/act_get_horas/PresenterHora.dart';
import 'package:marcaii_flutter/modules/bts_info_horas/BtsAction.dart';
import 'package:marcaii_flutter/utils/CurrencyUtils.dart';
import 'package:marcaii_flutter/utils/DateUtils.dart';

class PresenterBtsInfoHora {
  final CalendarCellDto cell;
  final int cargaHoraria;
  final List<SalariosDto> salarios;
  final int porcNormal, porcFeriados;
  final List<DiferenciaisDto> listDif;

  const PresenterBtsInfoHora({
    @required this.cargaHoraria,
    @required this.salarios,
    @required this.cell,
    @required this.porcNormal,
    @required this.porcFeriados,
    @required this.listDif,
  });

  Widget getDateLabel() {
    return Expanded(
      child: Text(
        DateUtils.dateTimeToBrString(cell.date),
        textAlign: TextAlign.start,
        style: TextStyle(
          fontSize: 20.0,
        ),
      ),
    );
  }

  Widget getUpdateBtn(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.refresh,
        color: Colors.amber,
      ),
      onPressed: () {
        return Navigator.of(context).pop(BtsResult(action: BtsAction.UPDATE, cellDto: cell));
      },
    );
  }

  Widget getDeleteBtn(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.delete_sweep,
        color: Colors.red,
      ),
      onPressed: () {
        Navigator.of(context).pop(BtsResult(action: BtsAction.DELETE, cellDto: cell));
      },
    );
  }

  Widget getMinutesLabel(BuildContext context) {
    final minutes = DateUtils.minutesBetween(
      init: cell.hora.horaInicial,
      end: cell.hora.horaTermino,
    );

    return Row(
      children: <Widget>[
        Expanded(
          child: Text(
            "$minutes minutos",
            style: PresenterHora.hintTextStyle(context),
          ),
        ),
      ],
    );
  }

  Widget getTipoHora() {
    Color color = Colors.green;
    String tipoHora = Strings.horaNormal;
    if (cell.hora.tipoHora == Consts.horaFeriados) {
      color = Colors.orange;
      tipoHora = Strings.horaFeriado;
    } else if (cell.hora.tipoHora == Consts.horaDiferencial) {
      color = Colors.red;
      tipoHora = Strings.horaDiferencial;
    }

    return ListTile(
      leading: Icon(Icons.graphic_eq, color: color),
      title: Text(tipoHora, style: TextStyle(color: color)),
    );
  }

  Widget getValorHora() {
    double valor = 0.0;
    if (cell.hora.tipoHora == Consts.horaNormal) {
      valor = _calcTotal(porcNormal);
    } else if (cell.hora.tipoHora == Consts.horaFeriados) {
      valor = _calcTotal(porcFeriados);
    } else if (cell.hora.tipoHora == Consts.horaDiferencial) {
      final porc = listDif
          .firstWhere((d) => d.diaSemana == DateUtils.getCurrentWeekday(cell.date))
          .porcAdicional;

      valor = _calcTotal(porc ?? 30);
    }
    return ListTile(
      leading: Icon(Icons.monetization_on, color: Colors.blue),
      title: Text("R\$ ${CurrencyUtils.doubleToCurrency(valor)}"),
    );
  }

  ///O valor é calculado dividindo o salário hora por 60 minutos, obtendo o valor do minuto extra
  ///multiplicado pela porcentagem
  ///e finalmente multiplicando pela quantidade de minutos extras;
  double _calcTotal(int porc) {
    final s = salarios.lastWhere((s) => DateUtils.vigenciaToDate(s.vigencia).isBefore(cell.date));
    return (((s.valorSalario / cargaHoraria) / 60) * (1 + (porc / 100))) * cell.hora.quantidade;
  }
}
