import 'package:flutter/material.dart';
import 'package:marcaii_flutter/modules/act_get_empregos/page_emprego_porcentagem/PercentHolder.dart';
import 'package:marcaii_flutter/modules/act_get_empregos/page_emprego_porcentagem/PorcDiferencialList.dart';

class PageEmpregoPorcentagens extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        PercentHolder(),
        Expanded(child: PorcDiferencialList()),
      ],
    );
  }
}
