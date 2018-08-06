import 'package:flutter/material.dart';
import 'package:marcaii_flutter/Strings.dart';
import 'package:marcaii_flutter/modules/act_get_empregos/EmpregoState.dart';
import 'package:marcaii_flutter/modules/act_get_empregos/page_emprego_info/widgets/DefaultListItem.dart';
import 'package:marcaii_flutter/modules/act_get_empregos/page_emprego_info/widgets/DiferenciaisListItem.dart';
import 'package:marcaii_flutter/modules/act_get_empregos/page_emprego_info/widgets/ListHeader.dart';
import 'package:marcaii_flutter/modules/act_get_empregos/page_emprego_info/widgets/NomeEmpregoHolder.dart';
import 'package:marcaii_flutter/modules/act_get_empregos/page_emprego_info/widgets/PorcentagemHolder.dart';
import 'package:marcaii_flutter/modules/act_get_empregos/page_emprego_info/widgets/ValorSalarioHolder.dart';
import 'package:marcaii_flutter/utils/CurrencyUtils.dart';
import 'package:marcaii_flutter/utils/PercentDialog.dart';
import 'package:marcaii_flutter/utils/YesNoDialog.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:scoped_model/scoped_model.dart';

class PageEmpregoInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      child: Container(
        padding: EdgeInsets.all(8.0),
        child: ScopedModelDescendant<EmpregoState>(
          rebuildOnChange: true,
          builder: (ct, ch, md) => Form(
                key: md.formKey,
                child: ScopedModelDescendant<EmpregoState>(
                  rebuildOnChange: false,
                  builder: (ct, ch, md) {
                    return ListView(
                      shrinkWrap: false,
                      addAutomaticKeepAlives: true,
                      children: _contentList(ct, md),
                    );
                  },
                ),
              ),
        ),
      ),
    );
  }

  List<Widget> _contentList(BuildContext context, EmpregoState model) {
    final List<Widget> contentList = [
      _nomeEmpregoHolder(),
      _valorSalarioHolder(),
      _diaFechamentoHolder(),
      _horarioSaidaHolder(),
      _cargaHorariaHolder(),
      _bancoHorasHolder(),
      _headerPorcentagem(),
      _porcNormal(),
      _porcFeriados(),
      _headerDiferenciais(),
    ];

    final dias = Arrays.weekDays;
    model.getPorcList.forEach((d) {
      contentList.add(DiferenciaisListItem(
        isLast: d == model.getPorcList.last,
        title: dias[d.diaSemana],
        percent: d.porcent,
        value: CurrencyUtils.calcPorcentExtra(model.valorSalario, model.cargaHoraria, d.porcent),
        onClear: () => _showClearDiferencialDialog(context, model, d.diaSemana),
        onEdit: (int percent) {
          return showPercentDialog(percent: percent, context: context).then((int p) {
            if (p != null) model.setPorcDifer(d.diaSemana, p);
          });
        },
      ));
    });

    return contentList;
  }

  Widget _headerPorcentagem() => ListHeader(title: "Porcentagens");

  Widget _headerDiferenciais() => ListHeader(title: "Diferenciais");

  Widget _nomeEmpregoHolder() {
    return ScopedModelDescendant<EmpregoState>(
      rebuildOnChange: false,
      builder: (ct, ch, md) {
        return NomeEmpregoHolder(
          formKey: md.formKey,
          nomeEmprego: md.nomeEmprego,
          title: Strings.nomeEmprego,
          onSave: (emprego) => md.setNomeEmprego(emprego),
        );
      },
    );
  }

  Widget _valorSalarioHolder() {
    return ScopedModelDescendant<EmpregoState>(
      builder: (ct, ch, md) {
        return ValorSalarioHolder(
          formKey: md.formKey,
          title: Strings.valorSalario,
          valorSalario: md.valorSalario,
          onSave: (valor) => md.setValorSalario(valor),
        );
      },
    );
  }

  Widget _porcNormal() {
    return ScopedModelDescendant<EmpregoState>(
      rebuildOnChange: false,
      builder: (ct, ch, md) {
        return PorcentagemHolder(
          formKey: md.formKey,
          iconColor: Colors.green,
          title: Strings.porcNormal,
          porcent: md.porcNormal,
          onSave: (e) {
            md.setPorcNormal(e);
          },
        );
      },
    );
  }

  Widget _porcFeriados() {
    return ScopedModelDescendant<EmpregoState>(
      rebuildOnChange: false,
      builder: (ct, ch, md) {
        return PorcentagemHolder(
          isLast: true,
          formKey: md.formKey,
          iconColor: Colors.orange,
          title: Strings.porcFeriados,
          porcent: md.porcFeriados,
          onSave: (e) {
            md.setPorcFeriados(e);
          },
        );
      },
    );
  }

  Widget _diaFechamentoHolder() {
    return ScopedModelDescendant<EmpregoState>(
      builder: (ct, ch, md) {
        return DefaultListItem(
          title: Strings.diaFechamento,
          icon: Icons.calendar_today,
          onTap: () => _showDiaFechamentoDialog(ct, md),
          contentChild: Container(
            margin: EdgeInsets.only(right: 8.0),
            child: Text(
              md.diaFechamento.toString(),
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.black,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _cargaHorariaHolder() {
    return ScopedModelDescendant<EmpregoState>(
      rebuildOnChange: false,
      builder: (ct, ch, md) {
        return DefaultListItem(
          title: Strings.cargaHoraria,
          icon: Icons.timelapse,
          onTap: null,
          contentChild: DropdownButtonHideUnderline(
            child: DropdownButton(
              value: md.cargaHoraria,
              onChanged: (c) {
                md.setCargaHoraria(c);
              },
              items: Arrays.cargas
                  .map((c) => int.parse(c))
                  .map((c) => DropdownMenuItem(child: Text("$c"), value: c))
                  .toList(),
            ),
          ),
        );
      },
    );
  }

  Widget _horarioSaidaHolder() {
    return ScopedModelDescendant<EmpregoState>(
      builder: (ct, ch, md) {
        return DefaultListItem(
          title: Strings.horarioSaida,
          icon: Icons.exit_to_app,
          onTap: () => _showHoraSaidaDialog(md, ct),
          contentChild: Container(
            margin: EdgeInsets.only(right: 8.0),
            child: Text(
              md.horarioSaida,
              style: TextStyle(fontSize: 16.0),
            ),
          ),
        );
      },
    );
  }

  Widget _bancoHorasHolder() {
    return ScopedModelDescendant<EmpregoState>(
      rebuildOnChange: false,
      builder: (ct, ch, md) {
        return DefaultListItem(
          title: Strings.bancoHoras,
          icon: Icons.local_activity,
          onTap: () => md.toggleBancoHoras(),
          isLast: true,
          contentChild: Switch(value: md.isBancoHoras(), onChanged: (st) => md.setBancoHoras(st)),
        );
      },
    );
  }

  void _showDiaFechamentoDialog(BuildContext ct, EmpregoState md) {
    showDialog(
        context: ct,
        barrierDismissible: false,
        builder: (ct) {
          num selnum;
          return AlertDialog(
            title: Text(Strings.diaFechamento),
            content: NumberPicker.integer(
              initialValue: md.diaFechamento,
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
                  md.setDiaFechamento(selnum);
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
          MaterialLocalizations.of(context).formatTimeOfDay(seltime, alwaysUse24HourFormat: true));
    }
  }

  void _showClearDiferencialDialog(BuildContext context, EmpregoState model, int weekDay) async {
    final status = await showConfirmationDialog(
      context: context,
      message: Strings.confirmar_remocao_difer,
    );

    if (status != null && status == true) {
      model.clearPorcDifer(weekDay);
    }
  }
}
