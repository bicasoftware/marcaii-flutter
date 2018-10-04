import 'package:flutter/material.dart';
import 'package:marcaii_flutter/models/state/EmpregoDto.dart';
import 'package:marcaii_flutter/modules/main_act/pages/page_calendario/widgets/CalendarHeader.dart';
import 'package:marcaii_flutter/modules/main_act/pages/page_calendario_item/PageCalendarioItem.dart';
import 'package:marcaii_flutter/state/MainState.dart';
import 'package:marcaii_flutter/utils/ListUtils.dart';
import 'package:marcaii_flutter/widgets/DropDownAction.dart';
import 'package:scoped_model/scoped_model.dart';

class PresenterPageCalendario {
  const PresenterPageCalendario(this.title);

  final String title;

  Widget getTitle() => Text(title);

  List<DropdownMenuItem> getAnosChild() {
    final l = List<DropdownMenuItem>();
    for (final i in ListUtils.range(2013, 2022)) {
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

  TabBar getTabBar(List<EmpregoDto> empregos, TabController controller) {
    return TabBar(
      controller: controller,
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

  Widget _tabBarView(List<EmpregoDto> empregos, {@required TabController controller}) {
    return Expanded(
      child: TabBarView(        
        controller: controller,
        children: empregos.map((e) {
          return PageCalendarioItem(
            salarios: e.listSalarios,
            cells: e.currentPage.cells,
            listDifer: e.listDiferenciais,
            porcNormal: e.porcNormal,
            porcFeriados: e.porcFeriados,
            cargaHoraria: e.cargaHoraria,
            isBancoHoras: e.bancoHoras,
          );
        }).toList(),
      ),
    );
  }

  Widget provideBody(List<EmpregoDto> empregos, {@required TabController controller}) {
    return Column(
      children: <Widget>[
        _calendarHeader(),
        _tabBarView(empregos, controller: controller),
      ],
    );
  }
}
