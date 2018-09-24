import 'package:flutter/material.dart';
import 'package:marcaii_flutter/modules/act_get_horas/PresenterHora.dart';
import 'package:marcaii_flutter/widgets/BaseDivider.dart';

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
      body: Container(
        margin: EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            presenter.horaInicialContainer,
            BaseDivider(),
            presenter.horaTerminoHolder,
            BaseDivider(),
            presenter.hintTipoHora(context),
            presenter.radioGroupTipoHora,
          ],
        ),
      ),
      bottomNavigationBar: presenter.getBottomBar(),
    );
  }
}
