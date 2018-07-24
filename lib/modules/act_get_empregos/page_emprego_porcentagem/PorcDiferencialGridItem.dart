import 'package:flutter/material.dart';
import 'package:marcaii_flutter/utils/CurrencyUtils.dart';

class PorcDiferencialGridItem extends StatelessWidget {
  const PorcDiferencialGridItem({
    Key key,
    @required this.weekDay,
    @required this.porcent,
    @required this.valor,
    @required this.onTap,
    @required this.onClean,
  }) : super(key: key);

  final String weekDay;
  final int porcent;
  final double valor;
  final VoidCallback onTap;
  final VoidCallback onClean;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        side: BorderSide(width: 0.0, color: Theme.of(context).dividerColor),
      ),
      child: InkWell(
        onTap: onTap,
        splashColor: Colors.grey,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              _header(weekDay),
              Divider(height: 0.0),
              _content(context, porcent, valor),
            ],
          ),
        ),
      ),
    );
  }

  Widget _header(String weekDay) {
    return Row(
      children: <Widget>[
        Expanded(child: _title(weekDay)),
        IconButton(
          iconSize: 12.0,
          alignment: Alignment.centerRight,
          icon: Icon(
            Icons.clear,
            color: Colors.black87,
          ),
          onPressed: onClean,
        )
      ],
    );
  }

  Widget _title(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 12.0,
        color: Colors.black87,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _content(BuildContext context, int percent, double valor) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _percent(context, "$porcent \%"),
          _valor(context, valor),
        ],
      ),
    );
  }

  Widget _percent(BuildContext context, String valor) {
    return Text(
      "$porcent \%",
      style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 20.0),
    );
  }

  Widget _valor(BuildContext context, double valor) {
    return Text(
      "R\$ ${CurrencyUtils.doubleToCurrency(valor)}",
      style: TextStyle(color: Theme.of(context).accentColor, fontSize: 12.0),
    );
  }
}
