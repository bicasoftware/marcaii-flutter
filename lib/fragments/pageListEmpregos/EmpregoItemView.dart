import 'package:flutter/material.dart';
import 'package:marcaii_flutter/models/EmpregoItemDto.dart';
import 'package:marcaii_flutter/res/Strings.dart';
import 'package:marcaii_flutter/res/CurrencyUtils.dart';
import 'package:marcaii_flutter/res/Themes.dart';

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
                  child: Text(_emprego.nomeEmprego, style: Themes.getContentTextStyle(context),),
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
                      Expanded(
                        child: Text(
                          Strings.valorSalario,
                          style: Themes.getTitleTextStyle(context),
                        ),),
                      Expanded(
                        child: Text(
                          Strings.cargaHoraria,
                          style: Themes.getTitleTextStyle(context),
                        )
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          CurrencyUtils.doubleToCurrency(_emprego.valorSalario),
                          style: Themes.getContentTextStyle(context),
                        ),
                      ), Expanded(
                        child: Text(
                          _emprego.cargaHoraria.toString(),
                          style: Themes.getContentTextStyle(context),
                        ),
                      ),
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
                      Expanded(
                        child: Text(
                          Strings.horarioSaida,
                          style: Themes.getTitleTextStyle(context),
                        )
                      ),
                      Expanded(
                        child:
                        Text(
                          Strings.diaFechamento,
                          style: Themes.getTitleTextStyle(context),
                        )
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          _emprego.horarioSaida,
                          style: Themes.getContentTextStyle(context),
                        )
                      ),
                      Expanded(
                        child: Text(
                          _emprego.diaFechamento.toString(),
                          style: Themes.getContentTextStyle(context),
                        ),
                      ),
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