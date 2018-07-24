import 'package:flutter/material.dart';
import 'package:marcaii_flutter/Strings.dart';
import 'package:marcaii_flutter/models/MdEmpregos.dart';
import 'package:marcaii_flutter/modules/act_get_empregos/EmpregoState.dart';
import 'package:marcaii_flutter/modules/act_get_empregos/page_emprego_porcentagem/PageEmpregoPorcentagens.dart';
import 'package:marcaii_flutter/modules/act_get_empregos/page_emprego_info/PageEmpregoInfo.dart';
import 'package:scoped_model/scoped_model.dart';

class ActInsertEmpregos extends StatefulWidget {
  final MdEmpregos emprego;

  const ActInsertEmpregos({Key key, this.emprego}) : super(key: key);

  @override
  _ActInsertEmpregosState createState() => _ActInsertEmpregosState();
}

class _ActInsertEmpregosState extends State<ActInsertEmpregos> with TickerProviderStateMixin {
  TabController controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<EmpregoState>(
      model: widget.emprego.toState(),
      child: Scaffold(
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
                      return Navigator.pop(context, model.provideEmprego());
                    }
                  },
                );
              },
            ),
          ],
          bottom: TabBar(
            controller: controller,
            tabs: <Widget>[
              Tab(text: Strings.dadosCargo),
              Tab(text: Strings.porcentagens),
            ],
          ),
        ),
        body: TabBarView(
          controller: controller,
          children: <Widget>[
            PageEmpregoInfo(),
            PageEmpregoPorcentagens(),
          ],
        ),
      ),
    );
  }
}
