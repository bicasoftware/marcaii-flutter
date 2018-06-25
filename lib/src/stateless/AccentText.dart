import 'package:flutter/material.dart';

class AccentText extends StatelessWidget {

    const AccentText({Key key, this.caption}) : super(key: key);

    final String caption;

    @override
    Widget build(BuildContext context) {
        return
            Text(
                this.caption,
                style: TextStyle(
                    color: Theme
                        .of(context)
                        .accentColor,
                    fontSize: 14.0)
            );
    }

}