import 'package:flutter/material.dart';
import 'package:marcaii_flutter/Strings.dart';
import 'package:marcaii_flutter/modules/page_calendario/PresenterPageCalendario.dart';
import 'package:marcaii_flutter/state/MainState.dart';
import 'package:marcaii_flutter/widgets/NavigationTabBar.dart';
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

  static TabController tabController;

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainState>(
      rebuildOnChange: false,
      builder: (context, child, model) {
        tabController = TabController(
          vsync: this,
          length: model.empregos.length,
          initialIndex: model.currentPageViewPosition,
        )..addListener(() {
            if (model.currentPageViewPosition > 0 && !tabController.indexIsChanging) {
              model.setCurrentPagePosition(tabController.index);
            }
          },);

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
