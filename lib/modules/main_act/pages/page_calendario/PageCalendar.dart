import 'package:flutter/material.dart';
import 'package:marcaii_flutter/modules/main_act/pages/page_calendario/widgets/CalendarHeader.dart';
import 'package:marcaii_flutter/modules/main_act/pages/page_calendario/widgets/CalendarNavigator.dart';

class PageCalendar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          CalendarNavigator(
            currentMonth: 0,
            onPrevMonth: () => print("Prev"),
            onNextMonth: () => print("Next"),
            onMonthClicked: (month) => print(month),
          ),
          CalendarHeader(),
        ],
      ),
    );
  }
}
