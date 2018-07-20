import 'package:flutter/material.dart';
import 'package:marcaii_flutter/Strings.dart';
import 'package:marcaii_flutter/models/PorcDiferDto.dart';
import 'package:marcaii_flutter/utils/CurrencyUtils.dart';

class PorcDiferItem extends StatelessWidget {
  const PorcDiferItem({Key key, this.item}) : super(key: key);

  final PorcDiferDto item;
  final _weekDays = Arrays.weekDays;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          child: ListTile(
            leading: Icon(Icons.av_timer, color: Colors.black87),
            trailing: Icon(Icons.delete_sweep, color: Theme.of(context).dividerColor),
            title: Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        _weekDays[item.diaSemana],
                        style: TextStyle(fontSize: 14.0, color: Theme.of(context).accentColor),
                      ),
                      Text(
                        "${item.porcent} %",
                        style: TextStyle(color: Colors.black87, fontSize: 16.0),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        Strings.valor,
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                      Text(
                        CurrencyUtils.doubleToCurrency(item.valor),
                        style: TextStyle(color: Colors.black87, fontSize: 16.0),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),        
      ],
    );
  }
}
