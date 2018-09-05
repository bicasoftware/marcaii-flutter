import 'package:flutter/material.dart';
import 'package:marcaii_flutter/Strings.dart';
import 'package:marcaii_flutter/modules/act_relacao/ModelRelacao.dart';
import 'package:marcaii_flutter/modules/act_relacao/TotaisItem.dart';
import 'package:marcaii_flutter/widgets/BaseDivider.dart';
import 'package:scoped_model/scoped_model.dart';

class PresenterRelacao {
  Widget get printAction {
    return IconButton(
      icon: Icon(
        Icons.print,
      ),
      onPressed: () {},
    );
  }

  Widget provideList() {
    return ScopedModelDescendant<ModelRelacao>(
      builder: (context, child, model) {
        return Expanded(
          child: ListView.builder(
            itemCount: model.items.length,
            itemBuilder: (c, i) {
              final item = model.items[i];
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: item.color,
                  child: Icon(Icons.timelapse),
                ),
                title: Text("${item.inicio} às ${item.termino}"),
                subtitle: Text("${item.minutos} minutos | R\$ ${item.valor}"),
                trailing: Text(
                  item.date,
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
    return BottomAppBar(
      elevation: 8.0,
      notchMargin: 2.0,
      shape: CircularNotchedRectangle(),
      child: Container(
          padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(Strings.totais),
                    Divider(),
                    TotaisItem(
                      color: Colors.green,
                      minutos: 120,
                      title: Strings.horasNormais,
                      valor: 165.0,
                    ),
                    TotaisItem(
                      color: Colors.orange,
                      minutos: 120,
                      title: Strings.horasCompletas,
                      valor: 165.0,
                    ),
                    TotaisItem(
                      color: Colors.red,
                      minutos: 120,
                      title: Strings.horasDiferencias,
                      valor: 165.0,
                    ),
                    BaseDivider(),
                    TotaisItem(
                      title: "",
                      minutos: 300,
                      valor: 200.0,
                    )
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
