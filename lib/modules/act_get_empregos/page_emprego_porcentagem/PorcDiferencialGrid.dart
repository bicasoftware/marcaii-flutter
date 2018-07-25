import 'package:flutter/material.dart';
import 'package:marcaii_flutter/Strings.dart';
import 'package:marcaii_flutter/modules/act_get_empregos/EmpregoState.dart';
import 'package:marcaii_flutter/modules/act_get_empregos/page_emprego_porcentagem/PorcDiferencialGridItem.dart';
import 'package:marcaii_flutter/utils/PercentDialog.dart';
import 'package:marcaii_flutter/utils/YesNoDialog.dart';
import 'package:scoped_model/scoped_model.dart';

//todo - verificar possível bug dos dialogs na api 24

class PorcDiferencialGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text("Diferenciais"),
        Expanded(
          child: GridView.count(
            crossAxisCount: 2,
            childAspectRatio: 1.6,
            children: List.generate(7, (i) {
              return ScopedModelDescendant<EmpregoState>(
                builder: (ct, ch, md) {
                  var difer = md.getPorcDiferAt(i);
                  return PorcDiferencialGridItem(
                    porcent: difer.porcent,
                    valor: difer.valor,
                    weekDay: Arrays.weekDays[i],
                    onClean: () async {
                      final bool action = await showConfirmationDialog(
                        context: context,
                        message: Strings.confirmar_remocao_difer,
                      );

                      if (action) md.clearPorcDifer(i);
                    },
                    onTap: () async {
                      final int newPercent = await showPercentDialog(
                        percent: difer.porcent,
                        context: context,
                      );

                      if (newPercent != null) {
                        print("pos: $i, percent: $newPercent");
                        md.setPorcDifer(i, newPercent);
                      }
                    },
                  );
                },
              );
            }),
          ),
        ),
      ],
    );
  }

  // _generateList(){
  //   children: List.generate(7, (i) {
  //       return ScopedModelDescendant<EmpregoState>(
  //         builder: (ct, ch, md) => PorcDiferencialGridItem(
  //           porcent: md.porcList[i].porcent,
  //           valor: md.porcList[i].valor,
  //           weekDay: Arrays.weekDays[i],
  //           onClean: () async {
  //             final action = await showConfirmationDialog(
  //               context: context,
  //               message: Strings.confirmar_remocao_difer,
  //             );

  //             if (action) md.clearPorcDifer(i);
  //           },
  //           onTap: () async {
  //             final int newPercent = await showPercentDialog(
  //               percent: md.porcList[i].porcent,
  //               context: context,
  //             );

  //             if (newPercent != null) {
  //               print("pos: $i, percent: $newPercent");
  //               md.setPorcDifer(i, newPercent);
  //             }
  //           },
  //         ),
  //       );
  //     });
  // }
}
