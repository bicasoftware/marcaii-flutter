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
        crossAxisCount: 7,
        crossAxisSpacing: 2.0,
        mainAxisSpacing: 2.0,
        padding: EdgeInsets.all(1.0),
        children: _preparedList(),
      ),
    );
  }

  List<CalendarBodyItem> _preparedList() {
    return cells.map((cell) => CalendarBodyItem(cell: cell)).toList();
  }
}
