import 'package:flutter/material.dart';
import 'package:marcaii_flutter/modules/main_act/pages/page_calendario/widgets/CalendarBodyItem.dart';
import 'package:marcaii_flutter/state/CalendarCellDto.dart';

class CalendarBody extends StatelessWidget {
  const CalendarBody({Key key, @required this.cells}) : super(key: key);

  final List<CalendarCellDto> cells;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.count(
        shrinkWrap: true,
        childAspectRatio: 1.0,
        crossAxisCount: 7,
        crossAxisSpacing: 0.0,
        mainAxisSpacing: 0.0,
        padding: EdgeInsets.all(1.0),
        children: _preparedList(),

      ),
    );
  }

  List<CalendarBodyItem> _preparedList() {
    return cells.map((cell) {
      return CalendarBodyItem(
        cell: cell,
        onCellTap: (data, hora){
          if(hora == null){
            ///mostrar ActGetHoras
          } else {
            ///mostrar BottomSheetTotais
          }
        },
      );
    }).toList();
  }
}
