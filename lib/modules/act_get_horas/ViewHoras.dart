import 'package:flutter/material.dart';
import 'package:marcaii_flutter/modules/act_get_horas/PresenterHora.dart';

class ViewHoras extends StatelessWidget {
  final presenter = PresenterHora();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: presenter.title,
        actions: <Widget>[
          presenter.actionSalvar,
        ],
      ),
      body: Card(
        child: Container(
          padding: EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              presenter.horaInicialContainer,
              presenter.horaTerminoHolder,
              presenter.hintTipoHora(context),
              presenter.radioGroupTipoHora,
              Divider(),
              presenter.quantidadeMinutosCounter,
            ],
          ),
        ),
      ),
    );
  }
}