import 'package:flutter/material.dart';
import 'package:marcaii_flutter/Strings.dart';
import 'package:marcaii_flutter/widgets/DefaultListItem.dart';
import 'package:marcaii_flutter/modules/act_get_horas/ModelHora.dart';
import 'package:marcaii_flutter/utils/DateUtils.dart';
import 'package:scoped_model/scoped_model.dart';

class PresenterHora {
  static TextStyle hintTextStyle(BuildContext context) {
    return Theme
        .of(context)
        .primaryTextTheme
        .caption
        .copyWith(color: Theme.of(context).accentColor);
  }

  static TextStyle errorTextStyle(BuildContext context) {
    return hintTextStyle(context).copyWith(
      color: Theme.of(context).errorColor,
      fontWeight: FontWeight.bold,
    );
  }

  Widget get title => Text(Strings.actGetHoras);

  Widget get actionSalvar {
    return ScopedModelDescendant<ModelHora>(
        rebuildOnChange: false,
        builder: (context, child, model) {
          return IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                final isValidated = DateUtils.isValidTimeRange(
                  model.horaInicial,
                  model.horaTermino,
                );

                if (isValidated) {
                  Navigator.of(context).pop(model.popResult());
                }
              });
        });
  }

  Widget get horaInicialContainer {
    return ScopedModelDescendant<ModelHora>(
      rebuildOnChange: true,
      builder: (context, child, model) {
        return DefaultListItem(
          icon: Icons.timer,
          onTap: () async {
            final time =
                await showTimePicker(context: context, initialTime: model.horaInicial);

            if (time != null && time is TimeOfDay) {
              model.setHoraInicio(time);
            }
          },
          title: Strings.horaInicial,
          contentChild: Text(DateUtils.timeOfDayToStr(model.horaInicial)),
        );
      },
    );
  }

  Widget get horaTerminoHolder {
    return ScopedModelDescendant<ModelHora>(
      rebuildOnChange: true,
      builder: (context, child, model) {
        return DefaultListItem(
          icon: Icons.timer,
          onTap: () async {
            final time = await showTimePicker(
              context: context,
              initialTime: model.horaTermino,
            );

            if (time != null && time is TimeOfDay) {
              model.setHoraTermino(time);
            }
          },
          title: Strings.horaTermino,
          contentChild: Text(DateUtils.timeOfDayToStr(model.horaTermino)),
        );
      },
    );
  }

  Widget hintTipoHora(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
      alignment: AlignmentDirectional.topStart,
      child: Text(
        Strings.tipoExtra,
        style: hintTextStyle(context),
      ),
    );
  }

  Widget get radioGroupTipoHora {
    return ScopedModelDescendant<ModelHora>(
      rebuildOnChange: true,
      builder: (context, child, model) {
        return Expanded(
          child: Column(
            children: <Widget>[
              RadioListTile(
                activeColor: Colors.green,
                value: Consts.horaNormal,
                title: Text(Strings.horaNormal, style: TextStyle(color: Colors.green)),
                onChanged: (tipoHora) => model.setTipoHora(tipoHora),
                groupValue: model.tipoHora,
              ),
              RadioListTile(
                activeColor: Colors.orange,
                value: Consts.horaFeriados,
                title: Text(
                  Strings.horaFeriado,
                  style: TextStyle(color: Colors.orange),
                ),
                onChanged: (tipoHora) => model.setTipoHora(tipoHora),
                groupValue: model.tipoHora,
              ),
              model.hasDiferencial()
                  ? RadioListTile(
                      activeColor: Colors.red,
                      value: Consts.horaDiferencial,
                      title: Text(
                        Strings.horaDiferencial,
                        style: TextStyle(color: Colors.red),
                      ),
                      onChanged: (tipoHora) => model.setTipoHora(tipoHora),
                      groupValue: model.tipoHora,
                    )
                  : Container(),
            ],
          ),
        );
      },
    );
  }

  Widget get quantidadeMinutosCounter {
    return ScopedModelDescendant<ModelHora>(
      rebuildOnChange: true,
      builder: (context, child, model) {
        return Row(
          children: <Widget>[
            Expanded(
              child: Container(
                padding: EdgeInsets.all(8.0),
                child: ScopedModelDescendant<ModelHora>(
                  builder: (_, __, model) {
                    return model.minutes > 0
                        ? Text(
                            "Quantidade: ${model.minutes} minutos",
                            textAlign: TextAlign.right,
                            style: hintTextStyle(context),
                          )
                        : Text(
                            Warn.warHorasInvalidas,
                            textAlign: TextAlign.right,
                            style: errorTextStyle(context),
                          );
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
