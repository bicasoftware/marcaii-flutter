import 'package:flutter/material.dart';
import 'package:marcaii_flutter/utils/Formatting.dart';

class DiferenciaisListItem extends StatelessWidget {
  const DiferenciaisListItem({
    Key key,
    @required this.title,
    @required this.percent,
    @required this.value,
    @required this.onClear,
    @required this.onEdit,
    this.isLast: false,
  }) : super(key: key);

  final bool isLast;
  final String title;
  final int percent;
  final double value;
  final VoidCallback onClear;
  final Function(int porcent) onEdit;

  @override
  Widget build(BuildContext context) {
    final weekDayStyle =
        TextStyle(fontSize: 14.0, color: Colors.black, fontWeight: FontWeight.bold);

    final percentStyle = weekDayStyle.copyWith(
      color: Theme.of(context).primaryColor,
      fontWeight: FontWeight.normal,
    );

    final valueStyle = percentStyle.copyWith(
      color: Theme.of(context).accentColor,
    );

    return Column(
      children: <Widget>[
        ListTile(
          onTap: () => onEdit(percent),
          leading: IconButton(
            icon: Icon(Icons.timer),
            onPressed: onClear,
          ),
          trailing: IconButton(
            icon: Icon(Icons.delete_sweep),
            onPressed: onClear,
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Text(
                  "$title",
                  textAlign: TextAlign.left,
                  style: weekDayStyle,
                ),
              ),
              Expanded(
                child: Text(
                  "$percent %",
                  textAlign: TextAlign.right,
                  style: percentStyle,
                ),
              ),
              Expanded(
                child: Text(
                  "R\$ ${Formatting.doubleToCurrency(value)}",
                  textAlign: TextAlign.right,
                  style: valueStyle,
                ),
              ),              
            ],
          ),
        ),
        isLast == false ? Divider(height: 8.0) : Container(),
      ],
    );
  }
}
