import 'dart:async';

import 'package:flutter/material.dart';
import 'package:marcaii_flutter/Strings.dart';
import 'package:numberpicker/numberpicker.dart';

class IntPicker {
  static Future<int> showIntPicker({
    @required int min,
    @required int max,
    BuildContext context,
    int initValue,
  }) async {
    return await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ct) {
        int currentNumber;
        return AlertDialog(
          title: Text(Strings.diaFechamento),
          content: _PickerBody(
            min: min,
            max: max,
            selection: initValue,
            onChanged: (selected) => currentNumber = selected,
          ),
          contentPadding: EdgeInsets.all(16.0),
          actions: <Widget>[
            FlatButton(
              child: Text("Cancelar"),
              onPressed: () => Navigator.pop(ct),
            ),
            FlatButton(
              child: Text("Salvar"),
              onPressed: () {
                Navigator.of(ct).pop(currentNumber);
              },
            ),
          ],
        );
      },
    );
  }
}

class _PickerBody extends StatefulWidget {
  final int selection, min, max;
  final Function(int) onChanged;

  const _PickerBody({
    Key key,
    @required this.selection,
    @required this.onChanged,
    @required this.min,
    @required this.max,
  }) : super(key: key);

  @override
  __PickerBodyState createState() => __PickerBodyState();
}

class __PickerBodyState extends State<_PickerBody> {
  int _selection;

  @override
  void initState() {
    _selection = widget.selection;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: NumberPicker.integer(
        initialValue: _selection,
        minValue: widget.min,
        maxValue: widget.max,
        onChanged: (num) {
          if (num != null) {
            setState(() {
              _selection = num;
            });
            widget.onChanged(num);
          }
        },
      ),
    );
  }
}
