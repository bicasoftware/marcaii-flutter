import 'package:flutter/material.dart';
import 'package:marcaii_flutter/Strings.dart';
import 'package:marcaii_flutter/models/PorcDiferDto.dart';
import 'package:marcaii_flutter/modules/act_get_empregos/EmpregoState.dart';
import 'package:marcaii_flutter/modules/act_get_empregos/page_emprego_porcentagem/PercentCard.dart';
import 'package:marcaii_flutter/modules/act_get_empregos/page_emprego_porcentagem/PercentListItem.dart';
import 'package:scoped_model/scoped_model.dart';

//todo - Gerar Dialog pegando nova porcentagem diferencial

class PageEmpregoPorcentagens extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        PercentHolder(),
        Expanded(
          child: PorcDiferList(),
        ),
      ],
    );
  }
}

class PercentHolder extends StatelessWidget {
  const PercentHolder({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 0,
      child: ScopedModelDescendant<EmpregoState>(
        builder: (ct, ch, md) {
          return Row(
            children: <Widget>[
              PercentCard(
                title: Strings.porcNormal,
                percent: md.getPorcNormal,
                value: 12.0,
                onClean: null,
              ),
              PercentCard(
                title: Strings.porcFeriados,
                percent: 100,
                value: 24.0,
                onClean: null,
              ),
            ],
          );
        },
      ),
    );
  }
}

class PorcDiferList extends StatelessWidget {
  const PorcDiferList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<EmpregoState>(
      builder: (ct, ch, md) {
        return ListView.builder(
          itemCount: 7,
          itemBuilder: (context, pos) {
            final PorcDiferDto p = md.getPorcDiferAt(pos);
            return PercentListItem(
              title: Arrays.weekDays[pos],
              percent: p.porcent,
              value: p.valor,
              position: pos,
              onClear: (pos) {
                //mostrar yesNoDialog e limpar dados
              },
            );
          },
        );
      },
    );
  }
}
