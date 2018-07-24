import 'package:flutter/material.dart';
import 'package:marcaii_flutter/Strings.dart';
import 'package:marcaii_flutter/modules/act_get_empregos/EmpregoState.dart';
import 'package:marcaii_flutter/modules/act_get_empregos/page_emprego_porcentagem/PercentCard.dart';
import 'package:marcaii_flutter/utils/PercentDialog.dart';
import 'package:scoped_model/scoped_model.dart';

//todo - rever pq não está alterando as porcentagens normal e feriados
class PercentHolder extends StatelessWidget {
  const PercentHolder({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        ScopedModelDescendant<EmpregoState>(
          builder: (ct, ch, md) {
            return PercentCard(
              title: Strings.porcNormal,
              percent: md.getPorcNormal,
              value: 12.0,
              onTap: () async {
                final int newPercent = await showPercentDialog(
                  percent: md.getPorcNormal,
                  context: ct,
                );

                if (newPercent != null) {
                  md.setPorcNormal(newPercent);
                }
              },
            );
          },
        ),
        ScopedModelDescendant<EmpregoState>(
          builder: (ct, ch, md) {
            return PercentCard(
              title: Strings.porcFeriados,
              percent: md.getPorcFeriados,
              value: 24.0,
              onTap: () async {
                final int percent = await showPercentDialog(context: context, percent: md.getPorcFeriados);
                if (percent != null) {
                  md.setPorcFeriados(percent);
                }
              },
            );
          },
        ),
      ],
    );

    // return ScopedModelDescendant<EmpregoState>(
    //   builder: (ct, ch, md) {
    //     return Row(
    //       children: <Widget>[
    //         Text(md.porcNormal.toString()),
    //         PercentCard(
    //           title: Strings.porcNormal,
    //           percent: pn,
    //           value: 12.0,
    //           onTap: () async {
    //             int percent = await showPercentDialog(context: context, percent: pn);
    //             if (percent != null) {
    //               md.setPorcNormal(percent);
    //               print(md.porcNormal);
    //             }
    //           },
    //         ),
    //         Text(md.porcFeriados.toString()),
    //         PercentCard(
    //           title: Strings.porcFeriados,
    //           percent: pf,
    //           value: 24.0,
    //           onTap: () async {
    //             int percent = await showPercentDialog(context: context, percent: pf);
    //             if (percent != null) {
    //               md.setPorcFeriados(percent);
    //             }
    //           },
    //         ),
    //       ],
    //     );
    //   },
    // );
  }
}
