import 'package:flutter/material.dart';
import 'package:marcaii_flutter/Strings.dart';
import 'package:marcaii_flutter/models/PorcDiferDto.dart';
import 'package:marcaii_flutter/modules/act_get_empregos/ModelEmprego.dart';
import 'package:marcaii_flutter/modules/act_get_empregos/page_emprego_info/widgets/DiferenciaisListItem.dart';
import 'package:marcaii_flutter/modules/act_get_empregos/page_emprego_info/widgets/PorcentagemHolder.dart';
import 'package:marcaii_flutter/modules/act_get_empregos/page_emprego_info/widgets/ValorSalarioHolder.dart';
import 'package:marcaii_flutter/utils/PercentDialog.dart';
import 'package:marcaii_flutter/utils/YesNoDialog.dart';
import 'package:marcaii_flutter/widgets/DefaultListItem.dart';
import 'package:marcaii_flutter/widgets/ListHeader.dart';
import 'package:marcaii_flutter/widgets/form_fields/IntPickerTile.dart';
import 'package:marcaii_flutter/widgets/form_fields/TileTextField.dart';
import 'package:scoped_model/scoped_model.dart';

class PresenterEmprego {
  Widget getHeaderPorcentagem() => ListHeader(title: "Porcentagens");

  Widget getHeaderDiferenciais() => ListHeader(title: "Diferenciais");

  Widget getTextFieldNomeEmprego() {
    return ScopedModelDescendant<EmpregoState>(
      rebuildOnChange: false,
      builder: (ct, ch, md) {
        return TileTextField(
          autoValidate: false,
          showDivider: false,
          labelText: Strings.nomeEmprego,
          initialValue: md.nomeEmprego,
          hintText: Strings.nomeEmprego,
          onSaved: (emprego) => md.setNomeEmprego(emprego),
          validator: (s) {
            if (s.isEmpty) return Warn.warNomeEmprego;
            return null;
          },
        );
      },
    );
  }

  Widget getTextFieldSalario() {
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

  Widget getPickerTileFechamento() {
    return ScopedModelDescendant<EmpregoState>(
      builder: (context, _, model) {
        return IntPickerTile(
          context: context,
          min: 1,
          max: 28,
          initialValue: model.diaFechamento,
          hintText: Strings.diaFechamento,
          labelText: Strings.diaFechamento,
          showDivider: true,
          onNumberSelected: (num) => model.setDiaFechamento(num),
          onSaved: null,
          validator: (int i) {
            if (i == 0 || i > 28) return Warn.warDiaInvalido;
            return null;
          },
        );
      },
    );
  }

  Widget getHoraSaidaTile() {
    return ScopedModelDescendant<EmpregoState>(
      builder: (ct, ch, md) {
        return DefaultListItem(
          title: Strings.horarioSaida,
          icon: Icons.exit_to_app,
          onTap: () async {
            var seltime = await showTimePicker(
              context: ct,
              initialTime: TimeOfDay.now(),
            );

            if (seltime != null) {
              md.setHorarioSaida(MaterialLocalizations
                  .of(ct)
                  .formatTimeOfDay(seltime, alwaysUse24HourFormat: true));
            }
          },
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

  Widget getCargaHorariaTile() {
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

  Widget getBancoHorasTile() {
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

  Widget getPorcNormalTile() {
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

  Widget getPorcFeriadosTile() {
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

  List<Widget> provideListDifer({
    BuildContext context,
    double salarioHora,
    List<PorcDiferDto> diferDto,
    Function(int) onClear,
    Function(int, int) onUpdate,
  }) {
    final listDifer = List<DiferenciaisListItem>();

    final dias = Arrays.weekDays;

    diferDto.forEach((d) {
      listDifer.add(DiferenciaisListItem(
        isLast: d == diferDto.last,
        title: dias[d.diaSemana],
        percent: d.porcent,
        value: d.porcent == 0 ? 0.0 : salarioHora * (1 + (d.porcent / 100)),
        onClear: () {
          showConfirmationDialog(
            context: context,
            message: Strings.confirmar_remocao_difer,
          ).then((status) {
            if (status != null && status == true) {
              onClear(d.diaSemana);
            }
          });
        },
        onEdit: (int percent) {
          showPercentDialog(
            percent: percent,
            context: context,
          ).then((int p) {
            if (p != null) onUpdate(d.diaSemana, p);
          });
        },
      ));
    });

    return listDifer;
  }
}
