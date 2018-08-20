import 'package:flutter/material.dart';
import 'package:marcaii_flutter/Strings.dart';
import 'package:marcaii_flutter/modules/page_calendario/PresenterPageCalendario.dart';
import 'package:marcaii_flutter/state/MainState.dart';
import 'package:marcaii_flutter/utils/NavigationTabBar.dart';
import 'package:scoped_model/scoped_model.dart';

class ViewPageCalendario extends StatelessWidget {
  final presenter = PresenterPageCalendario(Strings.calendario);

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainState>(
      rebuildOnChange: true,
      builder: (context, child, model) {
        return DefaultTabController(
          length: model.empregos.length,
          child: Scaffold(
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
                tabBar: presenter.getTabBar(model.empregos),
              ),
            ),
            body: presenter.provideBody(model.empregos),
          ),
        );
      },
    );
  }
}
