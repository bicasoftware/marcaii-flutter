import 'package:flutter/material.dart';
import 'package:marcaii_flutter/modules/main_act/pages/page_calendario/widgets/CalendarHeader.dart';
import 'package:marcaii_flutter/modules/main_act/pages/page_calendario_item/PageCalendarioItem.dart';
import 'package:marcaii_flutter/state/EmpregoDto.dart';
import 'package:marcaii_flutter/state/MainState.dart';
import 'package:marcaii_flutter/utils/DropDownAction.dart';
import 'package:marcaii_flutter/utils/Range.dart';
import 'package:scoped_model/scoped_model.dart';

class PresenterPageCalendario {
  PresenterPageCalendario(this.title);

  final String title;

  Widget getTitle() => Text(title);

  List<DropdownMenuItem> getAnosChild() {
    final l = List<DropdownMenuItem>();
    for (final i in Range.range(2013, 2022)) {
      l.add(DropdownMenuItem(child: Text(i.toString()), value: i));
    }

    return l;
  }

  Widget getDropdownAnos() {
    return ScopedModelDescendant<MainState>(
      rebuildOnChange: true,
      builder: (context, child, model) {
        return DropDownAction<int>(
          onChanged: (i) {
            model.setYear(i);
          },
          currentValue: model.currentYear,
          children: getAnosChild(),
        );
      },
    );
  }

  TabBar getTabBar(List<EmpregoDto> empregos) {
    return TabBar(
      unselectedLabelColor: Colors.white70,
      labelColor: Colors.white,
      tabs: _provideTabs(empregos),
    );
  }

  List<Tab> _provideTabs(List<EmpregoDto> empregos) {
    return empregos.map((e) => Tab(child: Text(e.nomeEmprego, maxLines: 1))).toList();
  }

  Widget _calendarHeader() {
    return CalendarHeader();
  }

  Widget _tabBarView(List<EmpregoDto> empregos) {
    return Expanded(
      child: TabBarView(
        children: empregos.map((e) {
          return PageCalendarioItem(
            cells: e.currentPage.cells,
            listDifer: e.listDiferenciais,
          );
        }).toList(),
      ),
    );
  }

  Widget provideBody(List<EmpregoDto> empregos) {
    return Container(
      child: Column(
        children: <Widget>[
          _calendarHeader(),
          _tabBarView(empregos),
        ],
      ),
    );
  }
}
