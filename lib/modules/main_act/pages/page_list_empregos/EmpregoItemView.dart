import 'package:flutter/material.dart';
import 'package:marcaii_flutter/Strings.dart';
import 'package:marcaii_flutter/models/state/EmpregoDto.dart';
import 'package:marcaii_flutter/utils/CurrencyUtils.dart';
import 'package:marcaii_flutter/utils/Themes.dart';

class PageListEmpregoItem extends StatelessWidget {
  final EmpregoDto emprego;

  PageListEmpregoItem({Key key, this.emprego}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(width: 0.0, color: Theme.of(context).dividerColor),
      ),
      elevation: 0.0,
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
                  child: Text(
                    emprego.nomeEmprego,
                    style: Themes.getContentTextStyle(context),
                  ),
                )
              ],
            ),
            Container(
              padding: EdgeInsets.only(left: 32.0),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(bottom: 8.0, top: 8.0),
                    child: Divider(height: 1.0, color: Colors.grey),
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          Strings.valorSalario,
                          style: Themes.getTitleTextStyle(context),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          Strings.cargaHoraria,
                          style: Themes.getTitleTextStyle(context),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          CurrencyUtils.doubleToCurrency(1200.0),
                          style: Themes.getContentTextStyle(context),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          emprego.cargaHoraria.toString(),
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
                    child: Divider(height: 1.0, color: Colors.grey),
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          Strings.horarioSaida,
                          style: Themes.getTitleTextStyle(context),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          Strings.diaFechamento,
                          style: Themes.getTitleTextStyle(context),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          emprego.horarioSaida,
                          style: Themes.getContentTextStyle(context),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          emprego.diaFechamento.toString(),
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
