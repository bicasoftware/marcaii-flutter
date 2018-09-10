import 'package:flutter/material.dart';
import 'package:marcaii_flutter/Strings.dart';
import 'package:marcaii_flutter/modules/page_calendario/PresenterPageCalendario.dart';
import 'package:marcaii_flutter/state/MainState.dart';
import 'package:marcaii_flutter/utils/NavigationTabBar.dart';
import 'package:scoped_model/scoped_model.dart';

class ViewPageCalendario extends StatefulWidget {
  const ViewPageCalendario({Key key}) : super(key: key);

  @override
  ViewPageCalendarioState createState() {
    return new ViewPageCalendarioState();
  }
}

class ViewPageCalendarioState extends State<ViewPageCalendario> with TickerProviderStateMixin {
  final presenter = const PresenterPageCalendario(Strings.calendario);

  TabController tabController;

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainState>(
      rebuildOnChange: true,
      builder: (context, child, model) {
        tabController = TabController(
          vsync: this,
          length: model.empregos.length,
          initialIndex: model.currentPageViewPosition,
        );
        tabController.addListener(() {
          model.setCurrentPagePosition(tabController.index);
        });

        return Scaffold(
          body: presenter.provideBody(model.empregos, controller: tabController),
          appBar: AppBar(
            title: presenter.getTitle(),
            actions: <Widget>[
              presenter.getDropdownAnos(),
            ],
            bottom: NavigationTabBar(
              onNext: () => model.addMonth(),
              onPrev: () => model.decMonth(),
              onLabelTap: null,
              position: model.currentMonth,
              tabBar: presenter.getTabBar(model.empregos, tabController),
            ),
          ),
        );
      },
    );
  }
}
