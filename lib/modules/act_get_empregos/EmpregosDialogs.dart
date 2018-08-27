import 'dart:async';

import 'package:flutter/material.dart';
import 'package:marcaii_flutter/Strings.dart';
import 'package:marcaii_flutter/modules/act_get_empregos/AumentoDialog.dart';
import 'package:marcaii_flutter/modules/act_get_empregos/OptionSalario.dart';
import 'package:marcaii_flutter/utils/Validation.dart';

class EmpregosDialogs {
  static Future<OptionSalario> showDialogOptionSalario(BuildContext ct) {
    return showDialog(
      context: ct,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          title: Text(Strings.optSalarios),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.new_releases, color: Colors.green),
                title: Text(Strings.aumentoSalario, maxLines: 2),
                onTap: () => Navigator.of(context).pop(OptionSalario.NOVO),
              ),
              ListTile(
                leading: Icon(Icons.edit, color: Colors.orange),
                title: Text(Strings.alterarSalario),
                onTap: () => Navigator.of(context).pop(OptionSalario.ALTERAR),
              ),
              ListTile(
                leading: Icon(Icons.list, color: Colors.blue),
                title: Text(Strings.verSalarios),
                onTap: () => Navigator.of(context).pop(OptionSalario.LISTAR),
              ),
            ],
          ),
        );
      },
    );
  }

  static Future<double> showDialogSalario({
    @required BuildContext context,
    @required double defaultValue,
  }) {
    final controller = Validation.defaultMoneyMask(defaultValue);
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (c) {
        return AlertDialog(
          title: Text(Strings.alterarSalario),
          actions: <Widget>[
            FlatButton(
              child: Text(Strings.cancelar),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text(Strings.salvar),
              onPressed: () {
                Navigator.of(context).pop(controller.numberValue);
              },
            )
          ],
          content: TextFormField(
            controller: controller,
            decoration: InputDecoration(
              hintText: Strings.hintSalario,
              labelText: Strings.valorSalario,
            ),
          ),
        );
      },
    );
  }

  static Future<Map<String, dynamic>> showDialogGetAumento({
    BuildContext context,
    double defaultValue,
  }) {
    final controller = Validation.defaultMoneyMask(defaultValue);

    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (c) {
        String mes, ano;
        return AlertDialog(
          title: Text(Strings.aumentoSalario),
          actions: <Widget>[
            FlatButton(
              child: Text(Strings.cancelar),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text(Strings.salvar),
              onPressed: () {
                Navigator
                    .of(context)
                    .pop({"ano": ano, "mes": mes, "valor": controller.numberValue});
              },
            )
          ],
          content: AumentoDialog(
            salario: defaultValue,
            onAnoSelected: (_ano) => ano = _ano,
            onMesSelected: (_mes) => mes = _mes,
            controller: controller,
          ),
        );
      },
    );
  }
}
