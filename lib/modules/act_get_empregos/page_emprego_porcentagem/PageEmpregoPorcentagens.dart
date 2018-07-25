import 'package:flutter/material.dart';
import 'package:marcaii_flutter/modules/act_get_empregos/page_emprego_porcentagem/PorcDiferencialGrid.dart';
import 'package:marcaii_flutter/modules/act_get_empregos/page_emprego_porcentagem/PorcDiferencialList.dart';

class PageEmpregoPorcentagens extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(child: PorcDiferencialList()),
        //Expanded(child: PorcDiferencialGrid(),)
      ],
    );
  }
}
