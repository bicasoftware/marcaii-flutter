import 'package:flutter/material.dart';
import 'package:marcaii_flutter/res/Strings.dart';
import 'package:marcaii_flutter/models/MdEmpregos.dart';
import 'package:marcaii_flutter/res/CurrencyUtils.dart';
import 'package:marcaii_flutter/src/stateless/AccentText.dart';

class PageEmpregoInfo extends StatefulWidget {
    @override
    _PageEmpregoInfoState createState() => _PageEmpregoInfoState();
}

class _PageEmpregoInfoState extends State<PageEmpregoInfo> {

    MdEmpregos _emprego;
    final cargas = ["220", "200", "180", "150"];

    final formKey = GlobalKey<FormState>();
    TextEditingController ctNomeEmprego;
    TextEditingController ctFechamento;
    TextEditingController ctHorarioSaida;

    void _setCargaHoraria(String ch) {
        setState(() {
            _emprego.cargaHoraria = ch;
        });
    }

    @override
    void initState() {
        _emprego = MdEmpregos(
            bancoHoras: 0,
            porcFeriados: "100",
            porcNormal: "50",
            horarioSaida: "19:00",
            cargaHoraria: "220",
            diaFechamento: "25",
            nomeEmprego: "Analista Toppster"
        );
        ctNomeEmprego = TextEditingController(text: _emprego.nomeEmprego);
        ctFechamento = TextEditingController(text: _emprego.diaFechamento);
        ctHorarioSaida = TextEditingController(text: _emprego.horarioSaida);
        super.initState();
    }

    @override
    void dispose() {
        ctNomeEmprego.dispose();
        ctFechamento.dispose();
        ctHorarioSaida.dispose();
        super.dispose();
    }

    @override
    Widget build(BuildContext context) {
        return Container(
            margin: EdgeInsets.all(8.0),
            child: Form(
                key: formKey,
                child: ListView(
                    children: <Widget>[
                        ListTile(
                            title: TextFormField(
                                validator: (v) {
                                    if (v.isEmpty) return Warn.warNomeEmprego;

                                    final nameExp = RegExp(r'^[A-Za-z ]+$');

                                    if (!nameExp.hasMatch(v))
                                        return Warn.warTextApenas;

                                    return null;
                                },
                                decoration: InputDecoration(
                                    hintText: Strings.hintEmprego,
                                    labelText: Strings.empregos
                                ),
                                onSaved: (v) {  },
                                controller: ctNomeEmprego,
                            ),
                            leading: Icon(Icons.layers, color: Colors.red,),
                        ),
                        ListTile(
                            title: TextFormField(
                                initialValue: CurrencyUtils.doubleToCurrency(1500.0),
                                validator: (v) {
                                    if (v.isEmpty) {
                                        return Warn.warSalarioInvalido;
                                    }
                                },
                                decoration: InputDecoration(
                                    hintText: Strings.hintSalario,
                                    labelText: Strings.valorSalario
                                ),
                                keyboardType: TextInputType.numberWithOptions(decimal: true, signed: false),
                            ),
                            leading: Icon(Icons.monetization_on, color: Colors.green,),
                        ),
                        ListTile(
                            title: TextFormField(
                                controller: ctHorarioSaida,
                                validator: (v) {
                                    if (v.isEmpty) {
                                        return Warn.warHorarioInvalido;
                                    }
                                },
                                decoration: InputDecoration(
                                    hintText: Strings.hintHorarioSaida,
                                    labelText: Strings.horarioSaida
                                ),
                            ),
                            leading: Icon(Icons.time_to_leave, color: Colors.blueAccent,),
                        ),

                        ListTile(
                            leading: Icon(Icons.timelapse, color: Colors.teal,),
                            //hideunline preenche o
                            title: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                    value: _emprego.cargaHoraria,
                                    onChanged: (c) => _setCargaHoraria(c),
                                    items: cargas.map((c) =>
                                        DropdownMenuItem(child: Text(c,), value: c,))
                                        .toList(),
                                ),
                            ),
                        ),

                        ListTile(
                            leading: Icon(Icons.calendar_today, color: Colors.orange,),
                            title: TextFormField(
                                controller: ctFechamento,
                                validator: (v) {
                                    if (v.isEmpty || int.parse(v) < 0 || int.parse(v) > 29 ) {
                                        return Warn.warHorarioInvalido;
                                    }
                                },
                                decoration: InputDecoration(
                                    hintText: Warn.warFechamento,
                                    labelText: Strings.diaFechamento
                                ),
                            ),
                        )
                    ],
                ),
            ),
        );
    }
}
