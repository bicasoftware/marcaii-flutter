import 'package:flutter/material.dart';
import 'package:marcaii_flutter/Strings.dart';
import 'package:marcaii_flutter/modules/act_get_empregos/OptionSalario.dart';

class BtsOptionSalario extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
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
    );
  }
}
