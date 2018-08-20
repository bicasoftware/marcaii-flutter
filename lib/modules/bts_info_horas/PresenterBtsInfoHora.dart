import 'package:flutter/material.dart';
import 'package:marcaii_flutter/Strings.dart';
import 'package:marcaii_flutter/modules/act_get_horas/PresenterHora.dart';
import 'package:marcaii_flutter/modules/bts_info_horas/BtsAction.dart';
import 'package:marcaii_flutter/state/CalendarCellDto.dart';
import 'package:marcaii_flutter/utils/CurrencyUtils.dart';
import 'package:marcaii_flutter/utils/DateUtils.dart';

class PresenterBtsInfoHora {
  final CalendarCellDto cell;

  PresenterBtsInfoHora(this.cell);

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

  //todo - mostrar activity para atualizar a hora
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

  ///todo - mostrar dialog e remover a hora
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
    return ListTile(
      leading: Icon(Icons.monetization_on, color: Colors.blue),
      title: Text("R\$ ${CurrencyUtils.doubleToCurrency(12.0)}"),
    );
  }
}
