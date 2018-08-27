import 'package:flutter/material.dart';
import 'package:marcaii_flutter/Strings.dart';
import 'package:marcaii_flutter/state/SalariosDto.dart';
import 'package:marcaii_flutter/utils/CurrencyUtils.dart';

class ActListSalarios extends StatelessWidget {
  const ActListSalarios({Key key, @required this.salarios}) : super(key: key);

  final List<SalariosDto> salarios;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Salários anteriores"),
        elevation: 0.0,
      ),
      body: _ListSalariosBody(salarios: salarios),
    );
  }
}

class _ListSalariosBody extends StatelessWidget {
  const _ListSalariosBody({Key key, @required this.salarios}) : super(key: key);

  final List<SalariosDto> salarios;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _header(context),
        _content(context),
      ],
    );
  }

  Widget _header(BuildContext context) {
    return Row(
      children: <Widget>[
        Cell(
          title: Strings.valorSalario,
          color: Theme.of(context).primaryColor,
          textColor: Colors.white,
        ),
        Cell(
          title: Strings.vigencia,
          color: Theme.of(context).primaryColor,
          textColor: Colors.white,
        ),
      ],
    );
  }

  Widget _content(BuildContext context) {
    return Expanded(
      child: ListView(
        children: salarios.map((sal) => _ListRow(s: sal)).toList(),
      ),
    );
  }
}

class Cell extends StatelessWidget {
  const Cell({
    Key key,
    this.title: "PLACEHOLDER",
    this.color: Colors.white,
    this.textColor: Colors.black87,
  }) : super(key: key);

  final String title;
  final Color color, textColor;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(.1),
        padding: EdgeInsets.all(12.0),
        color: color,
        child: Column(
          children: <Widget>[
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.0,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ListRow extends StatelessWidget {
  final SalariosDto s;

  const _ListRow({Key key, this.s}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Cell(
          title: "R\$ ${CurrencyUtils.doubleToCurrency(s.valorSalario)}",
          textColor: Colors.black,
        ),
        Cell(
          title: s.vigencia,
          textColor: Colors.black,
        ),
      ],
    );
  }
}
