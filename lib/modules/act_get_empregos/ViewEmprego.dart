import 'package:flutter/material.dart';
import 'package:marcaii_flutter/modules/act_get_empregos/ModelEmprego.dart';
import 'package:marcaii_flutter/modules/act_get_empregos/PresenterEmprego.dart';
import 'package:scoped_model/scoped_model.dart';

class ViewEmprego extends StatelessWidget {
  final presenter = PresenterEmprego();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      child: Container(
        padding: EdgeInsets.all(8.0),
        child: ScopedModelDescendant<EmpregoState>(
          rebuildOnChange: true,
          builder: (ct, ch, model) {
            return Form(
              key: model.formKey,
              child: ListView(
                shrinkWrap: false,
                addAutomaticKeepAlives: true,
                children: [
                  presenter.getTextFieldNomeEmprego(),
                  presenter.getTextFieldSalario(),
                  presenter.getPickerTileFechamento(),
                  presenter.getHoraSaidaTile(),
                  presenter.getCargaHorariaTile(),
                  presenter.getBancoHorasTile(),
                  presenter.getHeaderPorcentagem(),
                  presenter.getPorcNormalTile(),
                  presenter.getPorcFeriadosTile(),
                  presenter.getHeaderDiferenciais(),
                ]..addAll(
                    presenter.provideListDifer(
                      context: context,
                      diferDto: model.getPorcList,
                      onClear: (dia) => model.clearPorcDifer(dia),
                      onUpdate: (dia, newPorc) => model.setPorcDifer(dia, newPorc),
                      salarioHora: (model.valorSalario / model.cargaHoraria),
                    ),
                  ),
              ),
            );
          },
        ),
      ),
    );
  }
}
