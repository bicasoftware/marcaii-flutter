import 'package:flutter/material.dart';
import 'package:marcaii_flutter/models/state/EmpregoDto.dart';
import 'package:marcaii_flutter/utils/Formatting.dart';

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
      elevation: 1.0,      
      child: ListTile(
        onLongPress: onLongTap,
        onTap: onTap,
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).accentColor,
          child: Icon(Icons.work),
        ),
        title: Text(emprego.nomeEmprego),
        subtitle: Text(
          """R\$ ${Formatting.doubleToCurrency(emprego.salario)} | Carga: ${emprego.cargaHoraria} | Fechamento: ${emprego.diaFechamento}""",
        ),
      ),
    );
  }
}
