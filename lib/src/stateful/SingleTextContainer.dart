import 'package:flutter/material.dart';

import '../stateful/ContentText.dart';
import '../stateless/AccentText.dart';

class SingleTextContainer extends StatefulWidget {
  const SingleTextContainer({Key key, this.title, this.value}) : super(key: key);

  final String title;
  final String value;

  @override
  State createState() => _SingleTextContainerState(title, value);
}

class _SingleTextContainerState extends State<SingleTextContainer> {
  String _title, _value;

  _SingleTextContainerState(String title, value) {
    _title = title;
    _value = value;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      margin: EdgeInsets.all(8.0),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            AccentText(
              caption: this._title,
            ),
            ContentText(
              value: this._value,
            ),
            Divider(color: Colors.yellow),
          ],
        ),
      ),
    );
  }
}
