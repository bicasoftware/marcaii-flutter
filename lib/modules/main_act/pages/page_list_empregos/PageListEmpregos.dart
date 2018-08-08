import 'package:flutter/material.dart';
import 'package:marcaii_flutter/Strings.dart';
import 'package:marcaii_flutter/modules/act_get_empregos/ActInsertEmpregos.dart';
import 'package:marcaii_flutter/modules/main_act/pages/page_list_empregos/EmpregoItemView.dart';
import 'package:marcaii_flutter/state/EmpregoDto.dart';
import 'package:marcaii_flutter/state/MainState.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:marcaii_flutter/utils/YesNoDialog.dart';

class PageListEmpregos extends StatelessWidget {
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
                  return GestureDetector(
                    child: PageListEmpregoItem(emprego: emprego),
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
