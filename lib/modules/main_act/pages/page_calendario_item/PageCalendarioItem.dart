import 'package:flutter/material.dart';
import 'package:marcaii_flutter/modules/main_act/pages/page_calendario/widgets/CalendarBody.dart';
import 'package:marcaii_flutter/state/CalendarCellDto.dart';
import 'package:marcaii_flutter/state/DiferenciaisDto.dart';

class PageCalendarioItem extends StatelessWidget {
  const PageCalendarioItem({
    Key key,
    @required this.cells,
    @required this.listDifer,
  }) : super(key: key);

  final List<CalendarCellDto> cells;
  final List<DiferenciaisDto> listDifer;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          CalendarBody(
            cells: cells,
            listDifer: listDifer,
          )
        ],
      ),
    );
  }
}
