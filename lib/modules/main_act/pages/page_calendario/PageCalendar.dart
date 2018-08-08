import 'package:flutter/material.dart';
import 'package:marcaii_flutter/MainState.dart';
import 'package:marcaii_flutter/modules/main_act/pages/page_calendario/widgets/CalendarHeader.dart';
import 'package:marcaii_flutter/modules/main_act/pages/page_calendario/widgets/CalendarNavigator.dart';
import 'package:scoped_model/scoped_model.dart';

class PageCalendar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          ScopedModelDescendant<MainState>(
            builder: (_, __, st) {
              return CalendarNavigator(
                currentMonth: st.currentMonth,
                onPrevMonth: () => st.decMonth(),
                onNextMonth: () => st.addMonth(),
                onMonthClicked: (month) {
                  print(month);
                  print(st.currentMonth);
                },
              );
            },
          ),
          CalendarHeader(),
        ],
      ),
    );
  }
}
