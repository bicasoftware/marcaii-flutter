import 'package:flutter/material.dart';

class ContentText extends StatefulWidget {

    const ContentText({Key key, this.value }) : super(key: key);

    final String value;

    @override
    State createState() => _ContentTextState(value);
}

class _ContentTextState extends State<ContentText> {

    var value = "";

    _ContentTextState(String value) {
        this.value = value;
    }

    @override
    Widget build(BuildContext context) {
        return Text(
            this.value,
            style: TextStyle(
                color: Colors.black87,
                fontSize: 20.0
            )
        );
    }
}