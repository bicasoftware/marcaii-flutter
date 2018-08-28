import 'package:flutter/material.dart';
import 'package:marcaii_flutter/state/EmpregoDto.dart';
import 'package:marcaii_flutter/utils/CurrencyUtils.dart';

class EmpregoTile extends StatelessWidget {
  final EmpregoDto emprego;
  final VoidCallback onLongTap, onTap;

  EmpregoTile({
    Key key,
    @required this.emprego,
    @required this.onLongTap,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onLongPress: onLongTap,
        onTap: onTap,
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).accentColor,
          child: Icon(Icons.work),
        ),
        title: Text(emprego.nomeEmprego),
        subtitle: Text(
          """R\$ ${CurrencyUtils.doubleToCurrency(emprego.salario)} | Carga: ${emprego.cargaHoraria} | Fechamento: ${emprego.diaFechamento}""",
        ),
      ),
    );

    // return Card(
    //   shape: RoundedRectangleBorder(
    //     side: BorderSide(width: 0.0, color: Theme.of(context).dividerColor),
    //   ),
    //   elevation: 0.0,
    //   margin: EdgeInsets.only(left: 4.0, right: 4.0, top: 2.0, bottom: 2.0),
    //   child: Container(
    //     padding: EdgeInsets.all(8.0),
    //     child: Column(
    //       mainAxisSize: MainAxisSize.min, //wrap_content
    //       children: <Widget>[
    //         Row(
    //           children: <Widget>[
    //             CircleAvatar(
    //               backgroundColor: Theme.of(context).accentColor,
    //               child: Icon(Icons.work),
    //             ),
    //             Expanded(
    //               child: Padding(
    //                 padding: const EdgeInsets.all(8.0),
    //                 child: Column(
    //                   children: <Widget>[
    //                     Row(
    //                       children: <Widget>[
    //                         TitleText(
    //                           text: emprego.nomeEmprego,
    //                           size: 16.0,
    //                         ),
    //                       ],
    //                     ),
    //                     Row(
    //                       children: <Widget>[
    //                         Text(
    //                           """R\$ ${CurrencyUtils.doubleToCurrency(emprego.salario)} | Carga: ${emprego.cargaHoraria} | Fechamento: ${emprego.diaFechamento}""",
    //                           style: TextStyle(
    //                               color: Theme.of(context).textTheme.caption.color, fontSize: 14.0),
    //                         ),
    //                       ],
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //             )
    //           ],
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
