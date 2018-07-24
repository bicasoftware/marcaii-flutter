import 'dart:async';

import 'package:flutter/material.dart';
import 'package:marcaii_flutter/Strings.dart';
import 'package:marcaii_flutter/utils/Validation.dart';

Future<int> showPercentDialog({BuildContext context, int percent}) {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (ct) {
      return AlertDialog(
        title: Text(Strings.novaPorcentagem),
        content: _PercentDialog(percent: percent, formKey: _key),
        actions: <Widget>[
          FlatButton(
            child: Text(Strings.cancelar),
            onPressed: () {
              Navigator.of(ct).pop();
            },
          ),
          FlatButton(
            child: Text(Strings.salvar),
            onPressed: () {
              final state = _key.currentState;
              if (state.validate()) {
                state.save();
              }
            },
          ),
        ],
      );
    },
  );
}

class _PercentDialog extends StatelessWidget {
  const _PercentDialog({Key key, this.formKey, this.percent});

  final int percent;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return Column(      
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Form(
          key: formKey,
          child: TextFormField(
            initialValue: percent.toString(),
            keyboardType: TextInputType.numberWithOptions(
              decimal: false,
              signed: false,
            ),
            decoration: InputDecoration(
              labelText: Strings.digiteValor,
              hintText: Strings.hintPorc,
              suffixText: "%",
            ),
            validator: (e) {
              if (!Validation.isValidPercent(e.trim())) {
                return Warn.warPorcInvalida;
              }
            },
            onSaved: (e) {
              //if (Navigator.of(context).canPop()) {
                Navigator.pop(context, int.parse(e));
              //}
            },
          ),
        )
      ],
    );
  }
}
