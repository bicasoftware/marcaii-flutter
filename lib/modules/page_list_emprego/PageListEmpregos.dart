import 'package:flutter/material.dart';
import 'package:marcaii_flutter/Strings.dart';
import 'package:marcaii_flutter/modules/act_get_empregos/ActInsertEmpregos.dart';
import 'package:marcaii_flutter/modules/page_list_emprego/EmpregoItemView.dart';
import 'package:marcaii_flutter/state/EmpregoDto.dart';
import 'package:marcaii_flutter/state/MainState.dart';
import 'package:marcaii_flutter/utils/YesNoDialog.dart';
import 'package:scoped_model/scoped_model.dart';

class PageListEmpregos extends StatelessWidget {
  const PageListEmpregos({Key key, @required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: _ListEmpregosBody(),
    );
  }
}

class _ListEmpregosBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainState>(
      builder: (context, child, model) {
        return Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemCount: model.empregos.length,
                itemBuilder: (context, i) {
                  var emprego = model.getEmpregoAt(i);
                  return InkWell(
                    onTap: () async {
                      final updatableEmprego =
                          await Navigator.of(context).push(_actInsertRoute(emprego));

                      if (updatableEmprego != null && updatableEmprego is EmpregoDto) {
                        model.updateEmprego(updatableEmprego);
                      }
                    },
                    onLongPress: () async {
                      final result = await showConfirmationDialog(
                        context: context,
                        message: Strings.confirmar_remocao_difer,
                      );

                      if (result) {
                        if (emprego.id != null) {
                          model.deleteEmprego(emprego.id);
                        }
                      }
                    },
                    child: PageListEmpregoItem(emprego: emprego),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  MaterialPageRoute<EmpregoDto> _actInsertRoute(EmpregoDto emprego) =>
      MaterialPageRoute(builder: (context) => ActInsertEmpregos(emprego: emprego));
}
