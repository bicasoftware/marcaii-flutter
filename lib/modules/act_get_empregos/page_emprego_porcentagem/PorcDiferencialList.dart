import 'package:flutter/material.dart';
import 'package:marcaii_flutter/Strings.dart';
import 'package:marcaii_flutter/models/PorcDiferDto.dart';
import 'package:marcaii_flutter/modules/act_get_empregos/EmpregoState.dart';
import 'package:marcaii_flutter/modules/act_get_empregos/page_emprego_porcentagem/PorcDiferencialListItem.dart';
import 'package:marcaii_flutter/utils/PercentDialog.dart';
import 'package:marcaii_flutter/utils/YesNoDialog.dart';
import 'package:scoped_model/scoped_model.dart';

class PorcDiferencialList extends StatelessWidget {
  const PorcDiferencialList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<EmpregoState>(
      builder: (ct, ch, md) {
        return ListView.builder(
          itemCount: 7,
          itemBuilder: (context, pos) {
            final PorcDiferDto p = md.getPorcDiferAt(pos);
            return PorcDiferencialListItem(
              title: Arrays.weekDays[pos],
              percent: p.porcent,
              value: p.valor,
              position: pos,
              onClear: () async {
                final action = await showConfirmationDialog(
                  context: context,
                  message: Strings.confirmar_remocao_difer,
                );

                if(action) md.clearPorcDifer(pos);
              },
              onTap: () async {
                final int newPercent = await showPercentDialog(
                  percent: p.porcent,
                  context: ct,
                );

                if (newPercent != null) {
                  md.setPorcDifer(pos, newPercent);
                }
              },
            );
          },
        );
      },
    );
  }
}
