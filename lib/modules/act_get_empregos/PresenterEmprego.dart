import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marcaii_flutter/Strings.dart';
import 'package:marcaii_flutter/models/PorcDiferDto.dart';
import 'package:marcaii_flutter/models/state/SalariosDto.dart';
import 'package:marcaii_flutter/modules/act_get_empregos/BtsOptionSalario.dart';
import 'package:marcaii_flutter/modules/act_get_empregos/DiferenciaisListItem.dart';
import 'package:marcaii_flutter/modules/act_get_empregos/ModelEmprego.dart';
import 'package:marcaii_flutter/modules/act_get_empregos/OptionSalario.dart';
import 'package:marcaii_flutter/modules/act_get_empregos/Styles.dart';
import 'package:marcaii_flutter/modules/act_get_empregos/full_screen_dialogs/ActGetAumentos.dart';
import 'package:marcaii_flutter/modules/act_get_empregos/full_screen_dialogs/ActGetPorcent.dart';
import 'package:marcaii_flutter/modules/act_get_empregos/full_screen_dialogs/ActGetSalario.dart';
import 'package:marcaii_flutter/modules/act_get_empregos/full_screen_dialogs/ActListSalarios.dart';
import 'package:marcaii_flutter/utils/Formatting.dart';
import 'package:marcaii_flutter/utils/YesNoDialog.dart';
import 'package:marcaii_flutter/widgets/BaseDivider.dart';
import 'package:marcaii_flutter/widgets/ListHeader.dart';
import 'package:marcaii_flutter/widgets/form_fields/IntPickerTile.dart';
import 'package:scoped_model/scoped_model.dart';

class PresenterEmprego {
  Widget getHeaderPorcentagem() => ListHeader(title: "Porcentagens");

  Widget getHeaderDiferenciais() => ListHeader(title: "Diferenciais");

  Widget getTextFieldNomeEmprego() {
    return ScopedModelDescendant<EmpregoState>(
      rebuildOnChange: false,
      builder: (ct, ch, md) {
        return Column(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.edit),
              title: TextFormField(
                initialValue: md.nomeEmprego,
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(
                  hintText: Strings.nomeEmprego,
                  labelText: Strings.nomeEmprego,
                ),
                onSaved: (emprego) => md.setNomeEmprego(emprego),
                validator: (s) {
                  if (s.isEmpty) return Warn.warNomeEmprego;
                  return null;
                },
              ),
            ),
            BaseDivider(),
          ],
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
    return Column(
      children: <Widget>[
        ListTile(
          leading: Icon(Icons.monetization_on),
          title: Text(
            Strings.valorSalario,
            style: Styles.getListTitleStyle(ct),
          ),
          trailing: Text(
            "R\$ " + Formatting.doubleToCurrency(md.valorSalario),
            style: Styles.getListSubtitleStyle(ct),
          ),
          onTap: () async {
            //final option = await EmpregosDialogs.showDialogOptionSalario(ct);
            final option =
                await showModalBottomSheet(context: ct, builder: (ct) => BtsOptionSalario());
            if (option != null && option is OptionSalario) {
              if (option == OptionSalario.ALTERAR) {
                double salarioCorrigido = await Navigator.of(ct).push(CupertinoPageRoute(
                    fullscreenDialog: true,
                    builder: (c) => ActGetSalario(initValue: md.valorSalario)));

                if (salarioCorrigido != null && salarioCorrigido > 0) {
                  md.updateSalario(salarioCorrigido);
                }
              } else if (option == OptionSalario.NOVO) {
                final aumento = await Navigator.of(ct).push(CupertinoPageRoute(
                    fullscreenDialog: true,
                    builder: (c) => ActGetAumentos(initValue: md.valorSalario)));

                if (aumento != null && aumento is Map<String, dynamic>) {
                  String ano = aumento["ano"];
                  String mes = Arrays.months
                      .indexWhere((m) => m == aumento["mes"])
                      .toString()
                      .padLeft(2, "0");

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
        ),
        BaseDivider(),
      ],
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
        return Column(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text(
                Strings.horarioSaida,
                style: Styles.getListTitleStyle(ct),
              ),
              trailing: Text(
                md.horarioSaida,
                style: Styles.getListSubtitleStyle(ct),
              ),
              onTap: () async {
                var seltime = await showTimePicker(
                  context: ct,
                  initialTime: TimeOfDay.now(),
                );

                if (seltime != null) {
                  md.setHorarioSaida(
                    MaterialLocalizations.of(ct).formatTimeOfDay(
                      seltime,
                      alwaysUse24HourFormat: true,
                    ),
                  );
                }
              },
            ),
            BaseDivider(),
          ],
        );
      },
    );
  }

  Widget getCargaHorariaTile() {
    return ScopedModelDescendant<EmpregoState>(
      rebuildOnChange: false,
      builder: (ct, ch, md) {
        return Column(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.timelapse),
              title: Text(
                Strings.cargaHoraria,
                style: Styles.getListTitleStyle(ct),
              ),
              trailing: DropdownButtonHideUnderline(
                child: DropdownButton(
                  value: md.cargaHoraria,
                  onChanged: (c) {
                    md.setCargaHoraria(c);
                  },
                  items: Arrays.cargas.map((c) => int.parse(c)).map((c) {
                    return DropdownMenuItem(
                      child: Text("$c", style: Styles.getListSubtitleStyle(ct)),
                      value: c,
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget getPorcNormalTile() {
    return ScopedModelDescendant<EmpregoState>(
      rebuildOnChange: false,
      builder: (ct, ch, md) {
        return Column(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.move_to_inbox),
              title: TextFormField(
                keyboardType: TextInputType.number,
                initialValue: md.porcNormal.toString(),
                decoration: InputDecoration(
                  hintText: Strings.valor,
                  labelText: Strings.porcNormal,
                ),
                validator: (e) => Formatting.isValidPercent(e) ? null : Warn.warPorcInvalida,
                onSaved: (e) => md.setPorcNormal(int.parse(e)),
              ),
            ),
            BaseDivider(),
          ],
        );
      },
    );
  }

  Widget getPorcFeriadosTile() {
    return ScopedModelDescendant<EmpregoState>(
      rebuildOnChange: false,
      builder: (ct, ch, md) {
        return ListTile(
          leading: Icon(Icons.move_to_inbox),
          title: TextFormField(
            initialValue: md.porcFeriados.toString(),
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: Strings.porcFeriados,
              hintText: Strings.valor,
            ),
            validator: (i) => Formatting.isValidPercent(i) ? null : Warn.warPorcInvalida,
            onSaved: (i) => md.setPorcFeriados(int.parse(i)),
          ),
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
