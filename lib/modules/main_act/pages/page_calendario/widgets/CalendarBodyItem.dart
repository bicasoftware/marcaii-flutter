import 'package:flutter/material.dart';
import 'package:marcaii_flutter/modules/main_act/pages/page_calendario/widgets/TipoHoraIndicator.dart';
import 'package:marcaii_flutter/utils/SquaredCard.dart';

class CalendarBodyItem extends StatelessWidget {

  final int day;
  final int tipoHora;
  final int idHora;

  const CalendarBodyItem({Key key, this.day, this.tipoHora, this.idHora}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SquaredCard(      
      padding: 4.0,
      margin: EdgeInsets.all(0.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(day.toString()),
          TipoHoraIndicator(
            color: Colors.green,
          ),
        ],
      ),      
    );
  }
}