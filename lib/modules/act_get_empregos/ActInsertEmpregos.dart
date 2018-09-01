import 'package:flutter/material.dart';
import 'package:marcaii_flutter/Strings.dart';
import 'package:marcaii_flutter/models/state/EmpregoDto.dart';
import 'package:marcaii_flutter/modules/act_get_empregos/ModelEmprego.dart';
import 'package:marcaii_flutter/modules/act_get_empregos/ViewEmprego.dart';
import 'package:scoped_model/scoped_model.dart';

class ActInsertEmpregos extends StatefulWidget {
  final EmpregoDto emprego;

  const ActInsertEmpregos({Key key, @required this.emprego}) : super(key: key);

  @override
  ActInsertEmpregosState createState() {
    return new ActInsertEmpregosState();
  }
}

class ActInsertEmpregosState extends State<ActInsertEmpregos> {

  EmpregoState state;

  void initState() { 
    super.initState();
    state = widget.emprego.toState();
  }

  @override
  Widget build(BuildContext context) {

    return ScopedModel<EmpregoState>(
      model: state,
      child: Scaffold(
        resizeToAvoidBottomPadding: true,
        body: ViewEmprego(),
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
                      Navigator.pop(context, model.provideResult());
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
