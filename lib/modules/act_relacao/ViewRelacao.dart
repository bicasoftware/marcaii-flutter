import 'dart:async';

import 'package:flutter/material.dart';
import 'package:marcaii_flutter/Strings.dart';
import 'package:marcaii_flutter/modules/act_relacao/ModelRelacao.dart';
import 'package:marcaii_flutter/modules/act_relacao/PresenterRelacao.dart';
import 'package:marcaii_flutter/utils/DualLineAppBar.dart';
import 'package:marcaii_flutter/utils/FileReader.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:simple_permissions/simple_permissions.dart';

class ViewRelacao extends StatelessWidget {
  final _presenter = PresenterRelacao();

  Future<bool> checkPermission() async {
    return await SimplePermissions.checkPermission(Permission.ReadExternalStorage);
  }

  Future<bool> requestPermission() async {
    return await SimplePermissions.requestPermission(Permission.ReadExternalStorage);
  }

  void _checkPermissionAndGenerate(BuildContext context) async {
    bool status = await checkPermission();
    if (status == false) {
      final permissionResult = await requestPermission();
      if (permissionResult == true) {
        _generateFile();
      } else {
        Scaffold.of(context).showSnackBar(SnackBar(content: Text(Warn.warErroGerarPermissao)));
      }
    } else {
      _generateFile();
    }
  }

  void _generateFile() {
    //todo - passar ModelRelacao como parametro e gerar o arquivo em outra class
    final content = "Ano: 2018 \n mes: maio \n dia: 17";
    FileReader.createFile("Marcaii_teste", content, "txt");
  }

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
            onPressed: () => _checkPermissionAndGenerate(context),
          ),
          bottomNavigationBar: _presenter.provideBottomBar(),
        );
      },
    );
  }
}
