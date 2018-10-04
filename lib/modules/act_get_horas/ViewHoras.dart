import 'package:flutter/material.dart';
import 'package:marcaii_flutter/modules/act_get_horas/PresenterHora.dart';
import 'package:marcaii_flutter/widgets/BaseDivider.dart';

class ViewHoras extends StatelessWidget {
  ViewHoras({
    Key key,
    @required this.isBancoHoras,
  }) : super(key: key);

  final presenter = PresenterHora();
  final bool isBancoHoras;

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
            !isBancoHoras
                ? Column(
                    children: <Widget>[
                      BaseDivider(),
                      presenter.hintTipoHora(context),
                      presenter.radioGroupTipoHora,
                    ],
                  )
                : Container()
          ],
        ),
      ),
      bottomNavigationBar: presenter.getBottomBar(),
    );
  }
}
