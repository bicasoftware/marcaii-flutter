import 'package:flutter/material.dart';
import 'package:marcaii_flutter/Strings.dart';
import 'package:marcaii_flutter/models/PorcDiferDto.dart';
import 'package:marcaii_flutter/modules/act_get_empregos/EmpregoState.dart';
import 'package:marcaii_flutter/modules/act_get_empregos/page_emprego_porcentagem/PorcDiferencialGridItem.dart';
import 'package:marcaii_flutter/utils/PercentDialog.dart';
import 'package:marcaii_flutter/utils/YesNoDialog.dart';
import 'package:scoped_model/scoped_model.dart';

class PorcDiferencialGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<EmpregoState>(
      rebuildOnChange: true,
      builder: (ct, ch, md) {
        return GridView.count(
          crossAxisCount: 2,
          childAspectRatio: 1.6,
          children: List.generate(md.porcList.length, (i) {
            final dif = md.porcList[i];
            return PorcDiferencialGridItem(
              porcent: dif.porcent,
              valor: dif.valor,
              weekDay: Arrays.weekDays[dif.diaSemana],
              onClean: () async {
                final action = await showConfirmationDialog(
                  context: context,
                  message: Strings.confirmar_remocao_difer,
                );

                if (action) md.clearPorcDifer(i);
              },
              onTap: () async {
                final int newPercent = await showPercentDialog(
                  percent: dif.porcent,
                  context: context,
                );

                if (newPercent != null) {
                  md.setPorcDifer(i, newPercent);
                }
              },
            );
          }),

          // children: md.porcList.map((dif) {
          //   return PorcDiferencialGridItem(
          //     porcent: dif.porcent,
          //     valor: dif.valor,
          //     weekDay: Arrays.weekDays[dif.diaSemana],
          //     onClean: () async {
          //       final action = await showConfirmationDialog(
          //         context: context,
          //         message: Strings.confirmar_remocao_difer,
          //       );

          //       if (action) md.clearPorcDifer(pos);
          //     },
          //     onTap: () async {
          //       final int newPercent = await showPercentDialog(
          //         percent: p.porcent,
          //         context: ct,
          //       );

          //       if (newPercent != null) {
          //         md.setPorcDifer(pos, newPercent);
          //       }
          //     },
          //   );
          // }).toList(),
        );
      },
    );
  }

  List<Widget> _getGridItems(BuildContext context, List<PorcDiferDto> items) {
    return List.generate(items.length, (i) {
      final dif = items[i];
      return PorcDiferencialGridItem(
        porcent: dif.porcent,
        valor: dif.valor,
        weekDay: Arrays.weekDays[dif.diaSemana],
        onClean: () async {
          final action = await showConfirmationDialog(
            context: context,
            message: Strings.confirmar_remocao_difer,
          );

          //if (action) md.clearPorcDifer(pos);
        },
        onTap: () async {
          final int newPercent = await showPercentDialog(
            percent: dif.porcent,
            context: context,
          );

          if (newPercent != null) {
            //md.setPorcDifer(pos, newPercent);
          }
        },
      );
    });

    // return items.map((dif) {
    //   return PorcDiferencialGridItem(
    //     porcent: dif.porcent,
    //     valor: dif.valor,
    //     weekDay: Arrays.weekDays[dif.diaSemana],
    //     onClean: () async {
    //       final action = await showConfirmationDialog(
    //         context: context,
    //         message: Strings.confirmar_remocao_difer,
    //       );

    //       if (action) md.clearPorcDifer(pos);
    //     },
    //     onTap: () async {
    //       final int newPercent = await showPercentDialog(
    //         percent: p.porcent,
    //         context: ct,
    //       );

    //       if (newPercent != null) {
    //         md.setPorcDifer(pos, newPercent);
    //       }
    //     },
    //   );
    // }).toList();
  }
}
