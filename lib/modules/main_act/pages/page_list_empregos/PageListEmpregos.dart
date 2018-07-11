import 'package:flutter/material.dart';
import 'package:marcaii_flutter/MarcaiiState.dart';
import 'package:marcaii_flutter/modules/act_get_empregos/ActInsertEmpregos.dart';
import 'package:marcaii_flutter/modules/main_act/pages/page_list_empregos/EmpregoItemView.dart';
import 'package:scoped_model/scoped_model.dart';

class PageListEmpregos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MarcaiiState>(
      builder: (context, child, model) {
        return Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemCount: model.empregos.length,
                itemBuilder: (context, i) {
                  var emprego = model.empregoAt(i);
                  return GestureDetector(
                    child: PageListEmpregoItem(emprego: emprego,),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ActInsertEmpregos(emprego: emprego)
                        )
                      );
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
}
