import 'package:flutter/material.dart';
import 'package:marcaii_flutter/Strings.dart';
import 'package:marcaii_flutter/modules/act_get_empregos/EmpregoState.dart';
import 'package:marcaii_flutter/modules/act_get_empregos/page_emprego_info/PageEmpregoInfo.dart';
import 'package:marcaii_flutter/state/EmpregoDto.dart';
import 'package:scoped_model/scoped_model.dart';

class ActInsertEmpregos extends StatelessWidget {
  final EmpregoDto emprego;

  const ActInsertEmpregos({Key key, this.emprego}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScopedModel<EmpregoState>(
      model: emprego.toState(),
      child: Scaffold(
        body: PageEmpregoInfo(),
        appBar: AppBar(
          title: Text(Strings.actGetEmprego),
          actions: <Widget>[
            ScopedModelDescendant<EmpregoState>(
              rebuildOnChange: false,
              builder: (context, child, model) {
                return IconButton(
                  icon: Icon(Icons.save),
                  onPressed: () {
                    if (model.isValidated()) {
                      return Navigator.pop(context, model.provideResult());
                    }
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
