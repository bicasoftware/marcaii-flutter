import 'package:flutter/material.dart';
import 'package:marcaii_flutter/Strings.dart';
import 'package:marcaii_flutter/state/EmpregoDto.dart';
import 'package:marcaii_flutter/utils/CurrencyUtils.dart';
import 'package:marcaii_flutter/utils/Themes.dart';
import 'package:marcaii_flutter/widgets/ContextText.dart';
import 'package:marcaii_flutter/widgets/TitleText.dart';

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
                      TitleText(text: Strings.valorSalario),
                      TitleText(
                        text: Strings.cargaHoraria,
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      ContextText(text: CurrencyUtils.doubleToCurrency(emprego.salario)),
                      ContextText(text: emprego.cargaHoraria.toString()),
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
                      TitleText(text: Strings.horarioSaida,),
                      TitleText(text: Strings.diaFechamento,),                      
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
