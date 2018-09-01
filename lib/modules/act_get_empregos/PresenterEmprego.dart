import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marcaii_flutter/Strings.dart';
import 'package:marcaii_flutter/models/PorcDiferDto.dart';
import 'package:marcaii_flutter/modules/act_get_empregos/ActListSalarios.dart';
import 'package:marcaii_flutter/modules/act_get_empregos/EmpregosDialogs.dart';
import 'package:marcaii_flutter/modules/act_get_empregos/ModelEmprego.dart';
import 'package:marcaii_flutter/modules/act_get_empregos/OptionSalario.dart';
import 'package:marcaii_flutter/modules/act_get_empregos/page_emprego_info/widgets/DiferenciaisListItem.dart';
import 'package:marcaii_flutter/modules/act_get_empregos/page_emprego_info/widgets/PorcentagemHolder.dart';
import 'package:marcaii_flutter/utils/CurrencyUtils.dart';
import 'package:marcaii_flutter/utils/ActGetPorcent.dart';
import 'package:marcaii_flutter/utils/Validation.dart';
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
    final controller = Validation.defaultMoneyMask(md.valorSalario);
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
      contentChild: Text("R\$ " + CurrencyUtils.doubleToCurrency(md.valorSalario)),
      onTap: () async {
        final result = await EmpregosDialogs.showDialogOptionSalario(ct);
        if (result != null && result is OptionSalario) {
          if (result == OptionSalario.ALTERAR) {
            double newSalario = await EmpregosDialogs.showDialogSalario(
              context: ct,
              defaultValue: md.valorSalario,
            );

            if (newSalario != null && newSalario is double) {
              md.updateSalario(newSalario);
            }
          } else if (result == OptionSalario.NOVO) {
            final Map<String, dynamic> result = await EmpregosDialogs.showDialogGetAumento(
              context: ct,
              defaultValue: md.valorSalario,
            );

            if (result != null) {
              String ano = result["ano"];
              String mes =
                  Arrays.months.indexWhere((m) => m == result["mes"]).toString().padLeft(2, "0");

              double valor = result["valor"];
              md.appendSalario("$ano-$mes", valor);
            }
          } else if (result == OptionSalario.LISTAR) {
            Navigator.of(ct)
                .push(
                  CupertinoPageRoute(
                    fullscreenDialog: false,
                    builder: (BuildContext context) => ActListSalarios(salarios: md.salarios),
                  ),
                )
                .then((s) => md.resetSalarios(s));
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
          showConfirmationDialog(
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
              builder: (context) {
                return ActGetPorcentagem(
                  porc: d.porcent,
                );
              },
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
