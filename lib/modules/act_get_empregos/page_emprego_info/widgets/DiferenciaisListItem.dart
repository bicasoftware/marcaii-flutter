import 'package:flutter/material.dart';
import 'package:marcaii_flutter/utils/CurrencyUtils.dart';
import 'package:marcaii_flutter/utils/ExpandedText.dart';

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
              ExpandedText(
                text: "$title",
                align: TextAlign.left,
                innerStyle: TextStyle(
                  fontSize: 14.0,
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,                  
                ),
              ),
              ExpandedText(
                text: "$percent %",
                align: TextAlign.right,
                innerStyle: TextStyle(                  
                  fontSize: 14.0,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              ExpandedText(
                text: "R\$ ${CurrencyUtils.doubleToCurrency(value)}",
                align: TextAlign.right,
                innerStyle: TextStyle(
                  color: Theme.of(context).accentColor,
                  fontSize: 14.0,
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
