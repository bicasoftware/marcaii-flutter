import 'package:flutter/material.dart';
import 'package:marcaii_flutter/res/Strings.dart';
import 'package:marcaii_flutter/res/ActivityManager.dart';
import 'package:marcaii_flutter/models/EmpregoItemDto.dart';
import 'package:marcaii_flutter/src/stateful/EmpregoItemView.dart';
import 'package:marcaii_flutter/src/db/DBManager.dart';
import 'package:marcaii_flutter/models/MdHoras.dart';
import 'package:marcaii_flutter/models/MdPorcDifer.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return MaterialApp(
            title: Strings.appName,
            theme: ActivityManager.customTheme,
            home: Scaffold(
                appBar: ActivityManager.baseAppBar,
                body: Row(
                    children: <Widget>[
                        new Expanded(
                            flex: 1,
                            child: FlatButton(
                                child: Text("Criar db"),
                                onPressed: () => _lerHoras()),
                        ),

                        Expanded(
                            flex: 1,
                            child: MaterialButton(
                                child: Text("Inserir"),
                                color: Theme
                                    .of(context)
                                    .primaryColor,
                                onPressed: () => _insertHora()),
                        ),

                        Expanded(
                            flex: 1,
                            child: MaterialButton(
                                child: Text("Porc Difer"),
                                color: Theme
                                    .of(context)
                                    .primaryColor,
                                onPressed: () => _insertPorcDifer()),
                        ),
                        /*ListView(children: getEmpregoList(),),*/
                    ],
                ),

                floatingActionButton: FloatingActionButton(
                    child: Icon(Icons.add),
                    elevation: 2.0,
                    onPressed: null,
                ),
            ),
        );
    }

    _lerHoras() async {
        try {} catch (e) {
            print(e);
        }
    }

    _insertHora() async {
        var h = MdHoras(
            idEmprego: 1,
            horaInicial: "18:00",
            horaTermino: "19:00",
            dta: "2018-06-20",
            quantidade: 60,
            tipoHora: 1,
        );

        try {
            var manager = DBManager();
            await manager.create();

            h = await manager.upsertHora(h);
            print("inserido: ${h.id}");
        } catch (e) {
            print(e);
        }
    }

    _insertPorcDifer() async {
        var pd = MdPorcDifer(diaSemana: 1, porcAdicional: 200, idEmprego: 1);
        try {
            var manager = DBManager();
            await manager.create();
            pd = await manager.upsertPorcDifer(pd);
            print("id Difer: ${pd.id}");
        } catch (e) {
            print(e);
        }
    }
}

final empregos = [
    EmpregoItemDto(
        nomeEmprego: "Analista",
        cargaHoraria: 220,
        diaFechamento: 25,
        horarioSaida: "18:00",
        valorSalario: 4000.0
    ),
    EmpregoItemDto(
        nomeEmprego: "Programador",
        cargaHoraria: 220,
        diaFechamento: 25,
        horarioSaida: "18:00",
        valorSalario: 2000.0
    ),
    EmpregoItemDto(
        nomeEmprego: "Suporte Técnico",
        cargaHoraria: 220,
        diaFechamento: 25,
        horarioSaida: "18:00",
        valorSalario: 1200.0
    ),
];

List<EmpregoItemView> getEmpregoList() {
    return empregos.map((e) => EmpregoItemView(emprego: e,)).toList();
}