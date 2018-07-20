import 'package:flutter/material.dart';
import 'package:marcaii_flutter/utils/CurrencyUtils.dart';

class PercentListItem extends StatelessWidget {
  const PercentListItem({
    Key key,
    @required this.title,
    @required this.percent,
    @required this.value,
    @required this.onClear,
    @required this.position,
  }) : super(key: key);

  final Function(int) onClear;
  final String title;
  final int percent, position;
  final double value;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1.0,
      child: ListTile(
        leading: Icon(Icons.timer),
        trailing: IconButton(
          icon: Icon(Icons.delete_sweep),
          onPressed: () => onClear,
        ),
        title: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                maxLines: 1,
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Divider(
                height: 16.0,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      "$percent %",
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      CurrencyUtils.doubleToCurrency(value),
                      style: TextStyle(
                        color: Theme.of(context).accentColor,
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
