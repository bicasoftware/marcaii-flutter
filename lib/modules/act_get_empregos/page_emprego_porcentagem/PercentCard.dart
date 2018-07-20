import 'package:flutter/material.dart';
import 'package:marcaii_flutter/utils/CurrencyUtils.dart';

class PercentCard extends StatelessWidget {
  const PercentCard({
    Key key,
    @required this.title,
    this.percent: 0,
    this.value: 0.0,
    this.pos,
    @required this.onClean,
  }) : super(key: key);

  final String title;
  final int percent;
  final double value;
  final int pos;
  final Function(int) onClean;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        elevation: 1.0,
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 8.0, right: 8.0),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          title,
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: 12.0,
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      IconButton(
                        alignment: AlignmentDirectional.centerEnd,
                        iconSize: 12.0,
                        icon: Icon(
                          Icons.clear,
                          color: Colors.black87,
                        ),
                        onPressed: () => null,
                      )
                    ],
                  ),
                  Divider(height: 1.0),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          "$percent %",
                          style: TextStyle(fontSize: 20.0, color: Colors.black54),
                        ),
                        Text(
                          CurrencyUtils.doubleToCurrency(value),
                          style: TextStyle(fontSize: 14.0, color: Theme.of(context).accentColor),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
