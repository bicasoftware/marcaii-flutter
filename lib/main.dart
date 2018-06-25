import 'package:flutter/material.dart';
import 'package:marcaii_flutter/res/Strings.dart';
import 'package:marcaii_flutter/res/ActivityManager.dart';
import 'package:marcaii_flutter/models/EmpregoItem.dart';
import 'src/stateful/EmpregoItemView.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return MaterialApp(
            title: Strings.appName,
            theme: ActivityManager.customTheme,
            home: Scaffold(
                appBar: ActivityManager.baseAppBar,
                body: ListView(children: getEmpregoList(),),

                floatingActionButton: FloatingActionButton(
                    child: Icon(Icons.add),
                    elevation: 2.0,
                    onPressed: null,
                ),
            ),
        );
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