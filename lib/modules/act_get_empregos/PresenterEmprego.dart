import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marcaii_flutter/Strings.dart';
import 'package:marcaii_flutter/models/PorcDiferDto.dart';
import 'package:marcaii_flutter/models/state/SalariosDto.dart';
import 'package:marcaii_flutter/modules/act_get_empregos/BtsOptionSalario.dart';
import 'package:marcaii_flutter/modules/act_get_empregos/ModelEmprego.dart';
import 'package:marcaii_flutter/modules/act_get_empregos/OptionSalario.dart';
import 'package:marcaii_flutter/modules/act_get_empregos/full_screen_dialogs/ActGetAumentos.dart';
import 'package:marcaii_flutter/modules/act_get_empregos/full_screen_dialogs/ActGetPorcent.dart';
import 'package:marcaii_flutter/modules/act_get_empregos/full_screen_dialogs/ActGetSalario.dart';
import 'package:marcaii_flutter/modules/act_get_empregos/full_screen_dialogs/ActListSalarios.dart';
import 'package:marcaii_flutter/modules/act_get_empregos/widgets/DiferenciaisListItem.dart';
import 'package:marcaii_flutter/modules/act_get_empregos/widgets/PorcentagemHolder.dart';
import 'package:marcaii_flutter/utils/Formatting.dart';
import 'package:marcaii_flutter/utils/YesNoDialog.dart';
import 'package:marcaii_flutter/widgets/BaseDivider.dart';
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

  Widget getTileSalario() {
    return ScopedModelDescendant<EmpregoState>(builder: (ct, ch, md) {
      return md.id == null ? _getTextFieldSalario(ct, md) : _getAumentoSalarioTile(ct, md);
    });
  }

  Widget _getTextFieldSalario(BuildContext ct, EmpregoState md) {
    final controller = Formatting.defaultMoneyMask(md.valorSalario);
    return Column(
      children: <Widget>[
        ListTile(
          leading: Icon(Icons.monetization_on),
          title: TextFormField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: Strings.valorSalario,
              labelText: Strings.valorSalario,
            ),
            validator: (s) {
              if (controller.numberValue <= 0) return Warn.warSalarioInvalido;
              return null;
            },
            onSaved: (s) => md.updateSalario(controller.numberValue),
          ),
        ),
        BaseDivider(),
      ],
    );
  }

  Widget _getAumentoSalarioTile(BuildContext ct, EmpregoState md) {
    return DefaultListItem(
      title: Strings.valorSalario,
      icon: Icons.monetization_on,
      contentChild: Text("R\$ " + Formatting.doubleToCurrency(md.valorSalario)),
      onTap: () async {
        //final option = await EmpregosDialogs.showDialogOptionSalario(ct);
        final option = await showModalBottomSheet(
          context: ct, builder: (ct) => BtsOptionSalario()          
        );
        if (option != null && option is OptionSalario) {
          if (option == OptionSalario.ALTERAR) {
            double salarioCorrigido = await Navigator.of(ct).push(CupertinoPageRoute(
                fullscreenDialog: true, builder: (c) => ActGetSalario(initValue: md.valorSalario)));

            if (salarioCorrigido != null && salarioCorrigido > 0) {
              md.updateSalario(salarioCorrigido);
            }
          } else if (option == OptionSalario.NOVO) {
            final aumento = await Navigator.of(ct).push(CupertinoPageRoute(
                fullscreenDialog: true,
                builder: (c) => ActGetAumentos(initValue: md.valorSalario)));

            if (aumento != null && aumento is Map<String, dynamic>) {
              String ano = aumento["ano"];
              String mes =
                  Arrays.months.indexWhere((m) => m == aumento["mes"]).toString().padLeft(2, "0");

              double valor = aumento["valor"];
              md.appendSalario("$ano-$mes", valor);
            }
          } else if (option == OptionSalario.LISTAR) {
            final listSalarios = await Navigator.of(ct).push(
              CupertinoPageRoute(
                fullscreenDialog: true,
                builder: (BuildContext context) => ActListSalarios(salarios: md.salarios),
              ),
            );

            if (listSalarios != null && listSalarios is List<SalariosDto>) {
              md.resetSalarios(listSalarios);
            }
          }
        }
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
              md.setHorarioSaida(MaterialLocalizations.of(ct)
                  .formatTimeOfDay(seltime, alwaysUse24HourFormat: true));
            }
          },
          contentChild: Text(
            md.horarioSaida,
            style: TextStyle(fontSize: 16.0),
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
          isLast: true,
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
        onClear: () async {
          Dialogs.showConfirmationDialog(
            context: context,
            message: Strings.confirmar_remocao_difer,
          ).then((status) {
            if (status != null && status == true) {
              onClear(d.diaSemana);
            }
          });
        },

        ///enquanto existir o bug que repinta o widget abaixo do dialog, continuar usando uma fullscreen dialog
        onEdit: (int percent) async {
          final result = await Navigator.of(context).push(
            CupertinoPageRoute(
              fullscreenDialog: true,
              builder: (context) => ActGetPorcentagem(porc: d.porcent, diaSemana: d.diaSemana),
            ),
          );

          if (result != null && result is int) {
            onUpdate(d.diaSemana, result);
          }
        },
      ));
    });

    return listDifer;
  }
}
