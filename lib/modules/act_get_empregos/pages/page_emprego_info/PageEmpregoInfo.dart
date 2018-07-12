import 'package:flutter/material.dart';
import 'package:marcaii_flutter/Strings.dart';
import 'package:marcaii_flutter/modules/act_get_empregos/EmpregoState.dart';
import 'package:marcaii_flutter/modules/act_get_empregos/pages/page_emprego_info/DefaultListItem.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:scoped_model/scoped_model.dart';

class PageEmpregoInfo extends StatelessWidget {
  ///criar mask para salários
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<EmpregoState>(
      builder: (ct, ch, md) {
        return Container(
          margin: EdgeInsets.all(8.0),
          child: Form(
            key: md.formKey,
            child: ListView(

              shrinkWrap: true,
              children: <Widget>[
                _nomeEmpregoHolder(md, ct),
                _valorSalarioHolder(md),
                _diaFechamentoHolder(md, ct),
                _horarioSaidaHolder(md, ct),
                _cargaHorariaHolder(md, ct),
                _bancoHorasHolder(md, ct),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _nomeEmpregoHolder(EmpregoState md, BuildContext ct) {
    return Column(
      children: <Widget>[
        ListTile(
          title: TextFormField(
            initialValue: md.nomeEmprego,
            decoration: InputDecoration(
              hintText: Strings.hintEmprego,
              labelText: Strings.nomeEmprego
            ),

            validator: (t) {
              if (t.isEmpty) {
                return Warn.warNomeEmprego;
              }
            },

            onSaved: (e) {
              md.setNomeEmprego(e);
            },
          ),
          leading: Icon(Icons.layers, color: Colors.red,),
        ),
        BaseDivider(),
      ],
    );
  }

  Widget _valorSalarioHolder(EmpregoState md) {
    return Column(
      children: <Widget>[
        ListTile(
          title: TextFormField(
            initialValue: md.valorSalarioParsed,
            decoration: InputDecoration(
              prefixText: Strings.cashReal,
              hintText: Strings.hintSalario,
              labelText: Strings.valorSalario
            ),

            keyboardType: TextInputType.numberWithOptions(
              decimal: true,
              signed: false,
            ),
            validator: (e) {
              if (e == null) return Warn.warSalarioInvalido;
              if (e.isEmpty) return Warn.warSalarioInvalido;
              if (double.parse(e.replaceAll(",", ".")) < 0) return Warn.warSalarioInvalido;
            },

            onSaved: (e) {
              md.setValorSalario(double.parse(e.replaceAll(",", ".")));
            },
          ),
          leading: Icon(Icons.monetization_on, color: Colors.green,),
        ),
        BaseDivider(),
      ],
    );
  }

  Widget _diaFechamentoHolder(EmpregoState md, BuildContext ct) {
    return DefaultListItem(
      title: Strings.diaFechamento,
      icon: Icons.calendar_today,
      color: Colors.orange,
      onTap: () => _showDiaFechamentoDialog(ct, md),
      contentChild: Container(
        margin: EdgeInsets.only(right: 8.0),
        child: Text(
          md.diaFechamento,
          style: TextStyle(
            fontSize: 14.0,
            color: Colors.black,
          ),
        ),
      ),

    );
  }

  Widget _cargaHorariaHolder(EmpregoState md, BuildContext ct) {
    return DefaultListItem(
      title: Strings.cargaHoraria,
      icon: Icons.timelapse,
      color: Colors.teal,
      onTap: null,
      contentChild: DropdownButton(
        value: md.cargaHoraria,
        onChanged: (c) => md.setCargaHoraria(c),
        items: Arrays.cargas.map((c) =>
          DropdownMenuItem(
            child: Text(c,),
            value: c,)
        ).toList(),
      ),
    );
  }

  Widget _horarioSaidaHolder(EmpregoState md, BuildContext ct) {
    return DefaultListItem(
      title: Strings.horarioSaida,
      icon: Icons.exit_to_app,
      color: Colors.blue,
      onTap: () => _showHoraSaidaDialog(md, ct),
      contentChild: Container(
        margin: EdgeInsets.only(right: 8.0),
        child: Text(
          md.horarioSaida,
          style: TextStyle(
            fontSize: 16.0
          ),
        )
      ),
    );
  }

  Widget _bancoHorasHolder(EmpregoState md, BuildContext ct) {
    return DefaultListItem(
      title: Strings.bancoHoras,
      icon: Icons.local_activity,
      color: Colors.cyan,
      onTap: () => md.toggleBancoHoras(),
      isLast: true,
      contentChild: Switch(
        value: md.isBancoHoras(),
        onChanged: (st) => md.setBancoHoras(st)
      ),
    );
  }

  void _showDiaFechamentoDialog(BuildContext ct, EmpregoState md,) {
    showDialog(context: ct, barrierDismissible: false, builder: (ct) {
      num selnum;
      return AlertDialog(
        title: Text(Strings.diaFechamento),
        content: NumberPicker.integer(
          initialValue: int.parse(md.diaFechamento),
          minValue: 1,
          maxValue: 28,
          onChanged: (num) {
            if (num != null) {
              selnum = num;
            }
          },
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
              print(selnum.toString());
              md.setDiaFechamento(selnum.toString());
              Navigator.pop(ct);
            },
          ),
        ],
      );
    });
  }

  void _showHoraSaidaDialog(EmpregoState md, BuildContext context) async {
    var seltime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (seltime != null) {
      md.setHorarioSaida(
        MaterialLocalizations.of(context).formatTimeOfDay(
          seltime,
          alwaysUse24HourFormat: true
        )
      );
    }
  }
}

class BaseDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 8.0,
      color: Theme
        .of(context)
        .dividerColor,
    );
  }
}