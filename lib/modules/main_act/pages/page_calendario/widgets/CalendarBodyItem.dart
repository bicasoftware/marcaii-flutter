import 'package:flutter/material.dart';
import 'package:marcaii_flutter/Strings.dart';
import 'package:marcaii_flutter/modules/main_act/pages/page_calendario/widgets/TipoHoraIndicator.dart';
import 'package:marcaii_flutter/state/CalendarCellDto.dart';
import 'package:marcaii_flutter/utils/SquaredCard.dart';

class CalendarBodyItem extends StatelessWidget {
  final CalendarCellDto cell;

  const CalendarBodyItem({Key key, this.cell}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return cell != null ? _filledCell() : _emptyCell();
  }

  Widget _emptyCell() {
    return Container();
  }

  Widget _filledCell() {
    return SquaredCard(
      padding: 4.0,
      margin: EdgeInsets.all(0.0),
      child: Column(
        children: <Widget>[
          Text(cell.date.day.toString().padLeft(2, "0")),
          Expanded(
            child: _getIndicator(cell.hora.tipoHora),
          ),
        ],
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
      //return TipoHoraIndicator(color: Colors.green);
      return Container(width: 1.0, height: 1.0);
    }
  }
}
