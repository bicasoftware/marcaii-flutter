import 'package:flutter/material.dart';
import 'package:marcaii_flutter/models/EmpregoItem.dart';
import 'package:marcaii_flutter/src/stateful/ContentText.dart';
import 'package:marcaii_flutter/src/stateless/AccentText.dart';
import 'package:marcaii_flutter/res/Strings.dart';
import 'package:marcaii_flutter/res/CurrencyUtils.dart';

class EmpregoItemView extends StatefulWidget {

    const EmpregoItemView({Key key, this.emprego}) : super(key: key);
    final EmpregoItemDto emprego;

    @override
    State createState() => _ItemState();
}

class _ItemState extends State<EmpregoItemView> {
    EmpregoItemDto _emprego;

    @override
    void initState() {
        _emprego = widget.emprego;
        super.initState();
    }

    @override
    Widget build(BuildContext context) {
        return Card(
            margin: EdgeInsets.only(left: 4.0, right: 4.0, top: 2.0, bottom: 2.0),
            child: Container(
                padding: EdgeInsets.all(8.0),
                child: Column(
                    mainAxisSize: MainAxisSize.min, //wrap_content
                    children: <Widget>[
                        Row(
                            children: <Widget>[
                                Icon(Icons.work),
                                Container(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(_emprego.nomeEmprego, style: TextStyle(fontSize: 26.0),),
                                )
                            ],
                        ),

                        Container(
                            padding: EdgeInsets.only(left: 32.0),
                            child: Column(
                                children: <Widget>[
                                    Padding(
                                        padding: EdgeInsets.only(bottom: 8.0, top: 8.0),
                                        child: Divider(
                                            height: 1.0,
                                            color: Colors.grey
                                        ),
                                    ),
                                    Row(
                                        children: <Widget>[
                                            Expanded(child: AccentText(caption: Strings.valorSalario)),
                                            Expanded(child: AccentText(caption: Strings.cargaHoraria)),
                                        ],
                                    ),
                                    Row(
                                        children: <Widget>[
                                            Expanded(child: ContentText(value: CurrencyUtils.doubleToCurrency(_emprego.valorSalario))),
                                            Expanded(child: ContentText(value: _emprego.cargaHoraria.toString())),
                                        ],
                                    )
                                ],
                            ),
                        ),
                        Container(
                            padding: EdgeInsets.only(left: 32.0),
                            child: Column(
                                children: <Widget>[
                                    Padding(
                                        padding: const EdgeInsets.only(bottom: 8.0, top: 8.0),
                                        child: Divider(
                                            height: 1.0,
                                            color: Colors.grey
                                        ),
                                    ),
                                    Row(
                                        children: <Widget>[
                                            Expanded(child: AccentText(caption: Strings.horarioSaida)),
                                            Expanded(child: AccentText(caption: Strings.diaFechamento)),
                                        ],
                                    ),
                                    Row(
                                        children: <Widget>[
                                            Expanded(child: ContentText(value: _emprego.horarioSaida)),
                                            Expanded(child: ContentText(value: _emprego.diaFechamento.toString())),
                                        ],
                                    )
                                ],
                            ),
                        ),

                    ],
                ),
            ),
        );
    }
}