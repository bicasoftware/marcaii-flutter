import 'package:flutter/material.dart';
import 'package:marcaii_flutter/Strings.dart';
import 'package:marcaii_flutter/modules/main_act/pages/page_calendario/widgets/TipoHoraIndicator.dart';
import 'package:marcaii_flutter/state/CalendarCellDto.dart';
import 'package:marcaii_flutter/state/HoraDto.dart';

///todo - implementar on click, ou longclick, remover, deletar horas
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
            _getIndicator(cell.hora.tipoHora),
          ],
        ),
      ),
    );
  }

  Widget _getIndicator(String tipoHora) {
    if (tipoHora == Consts.horaNormal) {
      return TipoHoraIndicator(color: Colors.green);
    } else if (tipoHora == Consts.horaNormal) {
      return TipoHoraIndicator(color: Colors.orange);
    } else if (tipoHora == Consts.horaNormal) {
      return TipoHoraIndicator(color: Colors.red);
    } else {
      return Container(width: 1.0, height: 1.0);
    }
  }
}