import 'package:flutter/material.dart';
import 'package:marcaii_flutter/modules/main_act/pages/page_calendario_item/PageCalendarioItem.dart';
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

  ///gerar lista com meses exibidos e aplicar a cada página do calendário

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainState>(
      builder: (a, c, st) {
        return DefaultTabController(
          length: st.empregos.length,
          child: Scaffold(
            //body: PageCalendarItem(),
            appBar: AppBar(
              title: Text(title),
              actions: <Widget>[
                DropDownAction<int>(
                  onChanged: (i) {
                    st.setYear(i);
                  },
                  currentValue: st.currentYear,
                  children: listAnos,
                ),
              ],
              bottom: TabBar(
                  unselectedLabelColor: Colors.white70,
                  labelColor: Colors.white,
                  tabs: st.empregos
                      .map((e) => Tab(child: Text(e.nomeEmprego, maxLines: 1)))
                      .toList()),
            ),
            body: TabBarView(
              children:
                  st.empregos.map((e) => PageCalendarioItem(cells: e.currentPage.cells)).toList(),
            ),
          ),
        );
      },
    );
  }
}
