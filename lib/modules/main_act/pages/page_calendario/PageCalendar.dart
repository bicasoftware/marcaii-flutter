import 'package:flutter/material.dart';
import 'package:marcaii_flutter/modules/main_act/pages/page_calendario/widgets/CalendarBody.dart';
import 'package:marcaii_flutter/modules/main_act/pages/page_calendario/widgets/CalendarHeader.dart';
import 'package:marcaii_flutter/modules/main_act/pages/page_calendario/widgets/CalendarNavigator.dart';
import 'package:marcaii_flutter/state/MainState.dart';
import 'package:marcaii_flutter/utils/DropDownAction.dart';
import 'package:marcaii_flutter/utils/Range.dart';
import 'package:scoped_model/scoped_model.dart';

class PageCalendar extends StatelessWidget {
  const PageCalendar({Key key, @required this.title}) : super(key: key);
  final String title;
  
  static List<DropdownMenuItem> get listAnos {
    final l = List<DropdownMenuItem>();
    for (final i in Range.range(2013, 2022)) {
      l.add(DropdownMenuItem(child: Text(i.toString()), value: i));
    }

    return l;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _CalendarBody(),
      appBar: AppBar(
        title: Text(title),
        actions: <Widget>[
          ScopedModelDescendant<MainState>(
            builder: (_, __, st) {
              return DropDownAction<int>(
                onChanged: (i) {
                  st.setYear(i);
                },
                currentValue: st.currentYear,
                children: listAnos,
              );
            },
          ),
        ],
      ),
    );
  }
}

class _CalendarBody extends StatelessWidget {
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
                onMonthClicked: (month) => print(st.currentMonth),
              );
            },
          ),
          CalendarHeader(),
          CalendarBody(),
        ],
      ),
    );
  }
}
