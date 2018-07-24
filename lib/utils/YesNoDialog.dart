import 'dart:async';

import 'package:flutter/material.dart';
import 'package:marcaii_flutter/Strings.dart';

Future<bool> showConfirmationDialog({
  @required BuildContext context,
  @required String message,
}) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(Strings.confirmacao),
        actions: <Widget>[
          FlatButton(
            child: Text("Não"),
            onPressed: () => Navigator.of(context).pop(false),
          ),
          FlatButton(
            child: Text("Sim"),
            onPressed: () => Navigator.of(context).pop(true),
          ),
        ],
        content: Container(
          child: Text(message),
        ),
      );
    },
  );
}
