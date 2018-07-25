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
    @required this.onTap,
  }) : super(key: key);

  final String title;
  final int percent, position;
  final double value;
  final VoidCallback onClear;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(width: 0.0, color: Theme.of(context).dividerColor),
      ),
      child: ListTile(
        onTap: onTap,
        leading: IconButton(
          icon: Icon(Icons.timer),
          onPressed: onClear,
        ),
        trailing: IconButton(
          icon: Icon(Icons.delete_sweep),
          onPressed: onClear,
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
