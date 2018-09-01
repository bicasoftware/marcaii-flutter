import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:marcaii_flutter/Strings.dart';

class AumentoDialog extends StatefulWidget {
  const AumentoDialog({
    Key key,
    this.salario,
    this.onAnoSelected,
    this.onMesSelected,
    this.controller,
  }) : super(key: key);

  final Function(String) onAnoSelected, onMesSelected;
  final double salario;
  final MoneyMaskedTextController controller;

  @override
  _AumentoDialogState createState() => _AumentoDialogState();
}

class _AumentoDialogState extends State<AumentoDialog> {
  String _ano, _mes;

  @override
  void initState() {
    _ano = null;
    _mes = null;
    super.initState();
  }

  void _setAno(String ano) {
    setState(() => _ano = ano);
    widget.onAnoSelected(ano);
  }

  void _setMes(String mes) {
    setState(() => _mes = mes);
    widget.onMesSelected(mes);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        TextFormField(
          controller: widget.controller,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: Strings.hintSalario,
            labelText: Strings.valorSalario,
          ),
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: DropdownButtonHideUnderline(
                child: DropdownButton(
                    hint: Text("Mês inicial"),
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
          ],
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: DropdownButtonHideUnderline(
                child: DropdownButton(
                    value: _ano,
                    hint: Text("Ano do aumento"),
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
      ],
    );
  }
}
