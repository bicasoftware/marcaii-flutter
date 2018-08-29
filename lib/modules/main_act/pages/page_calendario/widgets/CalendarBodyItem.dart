import 'package:flutter/material.dart';
import 'package:marcaii_flutter/Strings.dart';
import 'package:marcaii_flutter/models/calendar/CalendarCellDto.dart';
import 'package:marcaii_flutter/models/state/HoraDto.dart';
import 'package:marcaii_flutter/modules/main_act/pages/page_calendario/widgets/TipoHoraIndicator.dart';

class CalendarBodyItem extends StatelessWidget {
  final CalendarCellDto cell;
  final Function(DateTime, HoraDto) onCellTap;

  const CalendarBodyItem({
    Key key,
    @required this.cell,
    @required this.onCellTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return cell != null ? _filledCell(context) : _emptyCell(context);
  }

  Widget _emptyCell(BuildContext context) {
    return Container(
      color: Theme.of(context).cardColor,
    );
  }

  Widget _filledCell(BuildContext context) {
    return GestureDetector(
      onTap: () => onCellTap(cell.date, cell.hora),
      child: Container(
        padding: EdgeInsets.all(4.0),
        margin: EdgeInsets.all(0.5),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          border: Border.all(color: Colors.black12, width: 0.5),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(cell.date.day.toString().padLeft(2, "0")),
            _getIndicator(cell.hora.id, cell.hora.idEmprego, cell.hora.tipoHora),
          ],
        ),
      ),
    );
  }

  Widget _getIndicator(int id, int idEmprego, String tipoHora) {
    if(id != null && idEmprego != null) {
      if (tipoHora == Consts.horaNormal) {
        return TipoHoraIndicator(color: Colors.green);
      } else if (tipoHora == Consts.horaFeriados) {
        return TipoHoraIndicator(color: Colors.orange);
      } else if (tipoHora == Consts.horaDiferencial) {
        return TipoHoraIndicator(color: Colors.red);
      } else {
        Container();
      }
    }

    return Container(width: 1.0, height: 1.0);
  }
}
