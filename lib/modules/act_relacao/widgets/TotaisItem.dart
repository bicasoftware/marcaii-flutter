import 'package:flutter/material.dart';
import 'package:marcaii_flutter/utils/Formatting.dart';

class TotaisItem extends StatelessWidget {
  const TotaisItem({Key key, this.title, this.color, this.minutos, this.valor}) : super(key: key);

  final String title;
  final Color color;
  final int minutos;
  final double valor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(2.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              title,
              style: TextStyle(color: color, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Text(
              "$minutos minutos",
              textAlign: TextAlign.end,
            ),
          ),
          Expanded(
            child: Text(
              "R\$ ${Formatting.doubleToCurrency(valor)}",
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}
