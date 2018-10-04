import 'package:flutter/material.dart';
import 'package:marcaii_flutter/Strings.dart';
import 'package:marcaii_flutter/modules/act_relacao/ModelRelacao.dart';
import 'package:marcaii_flutter/modules/act_relacao/widgets/TotaisItem.dart';
import 'package:marcaii_flutter/utils/DateUtils.dart';
import 'package:marcaii_flutter/widgets/BaseDivider.dart';
import 'package:scoped_model/scoped_model.dart';

//todo - verificar o index do calendário, repassar rotina de relacao, insercao de horas

class PresenterRelacao {
  Widget provideList() {
    return ScopedModelDescendant<ModelRelacao>(
      builder: (context, child, model) {
        return Expanded(
          child: ListView.builder(
            itemCount: model.items.length,
            itemBuilder: (c, i) {
              final item = model.items[i];
              final String horas = DateUtils.minutesToHours(item.minutos);
              final String valorReceber = model.isBancoHoras ? "" : "| R\$ ${item.valor}";
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: item.color,
                  child: Icon(Icons.av_timer, color: Colors.white70),
                ),
                title: Text("${item.inicio} às ${item.termino}"),
                subtitle: Text("$horas horas $valorReceber"),
                trailing: Text(
                  DateUtils.dateTimeToBrString(item.date),
                  style: TextStyle(color: Theme.of(context).accentColor),
                ),
                dense: true,
              );
            },
          ),
        );
      },
    );
  }

  Widget provideBottomBar() {
    return ScopedModelDescendant<ModelRelacao>(
      rebuildOnChange: false,
      builder: (context, child, model) {
        return BottomAppBar(
          elevation: 8.0,
          notchMargin: 2.0,
          shape: CircularNotchedRectangle(),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: !model.isBancoHoras ? _horasReceber(model) : _isBancoHoras(context, model),
          ),
        );
      },
    );
  }

  Widget _horasReceber(ModelRelacao model) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                Strings.totais,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Divider(),
              TotaisItem(
                color: Colors.green,
                minutos: model.minutosNormais,
                title: Strings.horasNormais,
                valor: model.valorNormal,
              ),
              TotaisItem(
                color: Colors.orange,
                minutos: model.minutosCompletos,
                title: Strings.horasCompletas,
                valor: model.valorCompletos,
              ),
              TotaisItem(
                color: Colors.red,
                minutos: model.minutosDifer,
                title: Strings.horasDiferencias,
                valor: model.valorDiferencial,
              ),
              BaseDivider(),
              TotaisItem(
                title: "",
                minutos: model.totalMinutos,
                valor: model.totalValor,
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _isBancoHoras(BuildContext context, ModelRelacao model) {
    final int total = model.minutosNormais + model.minutosCompletos + model.minutosDifer;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: Text(
                Strings.totais,
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        Divider(),
        Container(
          padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 4.0),
          child: Row(
            children: <Widget>[
              Text(
                Strings.horasBancoHoras,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              Expanded(
                child: Text(
                  "${DateUtils.minutesToHours(total)} horas",
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: Theme.of(context).accentColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
