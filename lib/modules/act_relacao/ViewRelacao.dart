import 'package:flutter/material.dart';
import 'package:marcaii_flutter/Strings.dart';
import 'package:marcaii_flutter/modules/act_relacao/ModelRelacao.dart';
import 'package:marcaii_flutter/modules/act_relacao/PresenterRelacao.dart';
import 'package:marcaii_flutter/utils/DualLineAppBar.dart';
import 'package:scoped_model/scoped_model.dart';

class ViewRelacao extends StatelessWidget {
  final _presenter = PresenterRelacao();

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ModelRelacao>(
      builder: (context, child, model) {
        return Scaffold(
          appBar: DualLineAppBar(
            bigText: "${Strings.totais} - ${model.mesString}",
            smallText: model.periodo,
          ),
          body: Column(
            children: <Widget>[
              _presenter.provideList(),
            ],
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.print),
            onPressed: null,
          ),
          bottomNavigationBar: _presenter.provideBottomBar(),
        );
      },
    );
  }
}
