import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:marcaii_flutter/Strings.dart';
import 'package:marcaii_flutter/modules/act_get_empregos/Styles.dart';
import 'package:marcaii_flutter/utils/Formatting.dart';
import 'package:marcaii_flutter/widgets/BaseDivider.dart';

class ActGetAumentos extends StatefulWidget {
  final double initValue;

  const ActGetAumentos({Key key, this.initValue}) : super(key: key);

  @override
  _ActGetAumentosState createState() => _ActGetAumentosState();
}

class _ActGetAumentosState extends State<ActGetAumentos> {
  MoneyMaskedTextController controller;
  GlobalKey<FormState> key;
  String _ano, _mes;

  @override
  void initState() {
    super.initState();
    _ano = null;
    _mes = null;
    key = GlobalKey<FormState>();
    controller = Formatting.defaultMoneyMask(widget.initValue);
  }

  void _setAno(String ano) {
    setState(() => _ano = ano);
  }

  void _setMes(String mes) {
    setState(() => _mes = mes);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(Strings.aumentoSalario)),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.save),
        onPressed: () {
          final status = key.currentState;
          if (status.validate()) {
            Navigator.of(context).pop(
              {"ano": _ano, "mes": _mes, "valor": controller.numberValue},
            );
          }
        },
      ),
      body: Column(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.monetization_on),
            title: Form(
              key: key,
              child: TextFormField(
                autofocus: true,
                controller: controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: Strings.valorSalario,
                  labelText: Strings.valorSalario,
                  prefix: Text("R\$"),
                ),
                validator: (s) {
                  if (s == "" || controller.numberValue <= 0) {
                    return Warn.warSalarioInvalido;
                  }
                  return null;
                },
              ),
            ),
          ),
          BaseDivider(),
          ListTile(
            leading: Icon(Icons.date_range),
            onTap: null,
            title: Text(
              Strings.mesAumento,
              style: Styles.getListTitleStyle(context),
            ),
            trailing: DropdownButtonHideUnderline(
              child: DropdownButton(
                  value: _mes,
                  items: Arrays.months.map((m) {
                    return DropdownMenuItem(
                      child: Text(m),
                      value: m,
                    );
                  }).toList(),
                  onChanged: _setMes),
            ),
          ),
          BaseDivider(),
          ListTile(
            leading: Icon(Icons.date_range),
            onTap: null,
            title: Text(
              Strings.anoAumento,
              style: Styles.getListTitleStyle(context),
            ),
            trailing: DropdownButtonHideUnderline(
              child: DropdownButton(
                  value: _ano,
                  items: List.generate(11, (i) {
                    int _ano = 2010 + i;
                    return DropdownMenuItem(
                      value: _ano.toString(),
                      child: Text(_ano.toString()),
                    );
                  }),
                  onChanged: _setAno),
            ),
          ),
        ],
      ),
    );
  }
}
