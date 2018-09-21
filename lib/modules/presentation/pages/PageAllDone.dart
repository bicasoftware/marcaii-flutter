import 'package:flutter/material.dart';
import 'package:marcaii_flutter/Strings.dart';
import 'package:marcaii_flutter/models/state/EmpregoDto.dart';
import 'package:marcaii_flutter/models/state/SalariosDto.dart';
import 'package:marcaii_flutter/modules/presentation/PresentationModel.dart';
import 'package:scoped_model/scoped_model.dart';

class PageAllDone extends StatelessWidget {
  final Function(EmpregoDto) onFinish;

  const PageAllDone({Key key, @required this.onFinish}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Text("Tudo Pronto"),
            ScopedModelDescendant<PresentationModel>(
              builder: (context, child, model) {
                return MaterialButton(
                  child: Text(Strings.finalizar),
                  onPressed: () {
                    final empregoDto = EmpregoDto(
                      cargaHoraria: model.cargaHoraria,
                      nomeEmprego: model.nomeEmprego,
                      bancoHoras: false,
                      diaFechamento: 25,
                      horarioSaida: "18:00",
                      porcNormal: model.pNormal,
                      porcFeriados: model.pCompleta,
                    );

                    empregoDto.listSalarios.add(
                      SalariosDto(
                        status: true,
                        valorSalario: model.salario,
                      ),
                    );

                    onFinish(empregoDto);
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
