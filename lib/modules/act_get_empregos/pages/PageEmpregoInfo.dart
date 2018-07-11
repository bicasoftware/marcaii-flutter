import 'package:flutter/material.dart';
import 'package:marcaii_flutter/Strings.dart';
import 'package:marcaii_flutter/modules/act_get_empregos/EmpregoState.dart';
import 'package:scoped_model/scoped_model.dart';

class PageEmpregoInfo extends StatelessWidget {
  ///criar mask para salários, validar melhor os valores, criar dialog para pegar horário de saída
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<EmpregoState>(
      builder: (context, ch, md) {
        return Container(
          margin: EdgeInsets.all(8.0),
          child: Form(
            key: md.formKey,
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                ListTile(
                  title: TextFormField(
                    initialValue: md.nomeEmprego,
                    decoration: InputDecoration(
                      hintText: Strings.hintEmprego,
                      labelText: Strings.nomeEmprego
                    ),

                    validator: (t) {
                      if (t.isEmpty) {
                        return Warn.warNomeEmprego;
                      }
                    },

                    onSaved: (e) {
                      md.setNomeEmprego(e);
                    },
                  ),
                  leading: Icon(Icons.layers, color: Colors.red,),
                ),
                ListTile(
                  title: TextFormField(
                    initialValue: md.valorSalarioParsed,
                    decoration: InputDecoration(
                      prefixText: Strings.cashReal,
                      hintText: Strings.hintSalario,
                      labelText: Strings.valorSalario
                    ),

                    keyboardType: TextInputType.numberWithOptions(
                      decimal: true,
                      signed: false,
                    ),
                    validator: (e) {
                      if (e == null) return Warn.warSalarioInvalido;
                      if (e.isEmpty) return Warn.warSalarioInvalido;
                      if (double.parse(e.replaceAll(",", ".")) < 0) return Warn.warSalarioInvalido;
                    },

                    onSaved: (e) {
                      md.setValorSalario(double.parse(e.replaceAll(",", ".")));
                    },
                  ),
                  leading: Icon(Icons.monetization_on, color: Colors.green,),
                ),
                ListTile(
                  leading: Icon(Icons.calendar_today, color: Colors.orange,),
                  title: TextFormField(
                    initialValue: md.diaFechamento,
                    decoration: InputDecoration(
                      hintText: Warn.warFechamento,
                      labelText: Strings.diaFechamento
                    ),
                    onSaved: (e) => md.setDiaFechamento(e),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    var seltime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );

                    if (seltime != null) {
                      md.setHorarioSaida(
                        MaterialLocalizations.of(context).formatTimeOfDay(
                          seltime,
                          alwaysUse24HourFormat: true
                        )
                      );
                    }
                  },
                  child: ListTile(
                    leading: Icon(Icons.exit_to_app, color: Colors.blueAccent,),
                    title: Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            Strings.horarioSaida,
                            style: TextStyle(
                              color: Theme
                                .of(context)
                                .primaryColor,
                              fontSize: 14.0
                            ),
                          )
                        ),

                        Container(
                          margin: EdgeInsets.only(right: 8.0),
                          child: Text(
                            md.horarioSaida,
                            style: TextStyle(
                              fontSize: 16.0
                            ),
                          )
                        ),
                      ],
                    ),
                  ),
                ),

                ListTile(
                  leading: Icon(Icons.timelapse, color: Colors.teal,),
                  title: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          Strings.cargaHoraria,
                          style: TextStyle(
                            color: Theme
                              .of(context)
                              .primaryColor,
                            fontSize: 14.0
                          ),
                        )
                      ),

                      DropdownButton(
                        value: md.cargaHoraria,
                        onChanged: (c) => md.setCargaHoraria(c),
                        items: Arrays.cargas.map((c) =>
                          DropdownMenuItem(
                            child: Text(c,),
                            value: c,)
                        ).toList(),
                      ),
                    ],
                  ),
                ),

                ListTile(
                  leading: Icon(Icons.local_activity, color: Colors.cyan,),
                  title: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          Strings.bancoHoras,
                          style: TextStyle(
                            color: Theme
                              .of(context)
                              .primaryColor,
                            fontSize: 14.0
                          ),
                        ),
                      ),
                      Switch(
                        value: md.bancoHoras == 1 ? true : false,
                        onChanged: (st) => md.bancoHoras = st == true ? 1 : false
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}