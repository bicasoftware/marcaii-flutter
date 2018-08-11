import 'package:flutter/material.dart';
import 'package:marcaii_flutter/modules/main_act/pages/page_calendario/widgets/CalendarBodyItem.dart';

class CalendarBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.count(
        crossAxisCount: 7,
        crossAxisSpacing: 2.0,
        mainAxisSpacing: 2.0,
        padding: EdgeInsets.all(1.0),
        children: List.generate(35, (i) => CalendarBodyItem(day: i, idHora: 0,tipoHora: 0,)),
      ),
    );
  }
}
