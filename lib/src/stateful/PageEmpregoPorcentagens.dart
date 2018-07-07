import 'package:flutter/material.dart';
import 'package:marcaii_flutter/res/CurrencyUtils.dart';
import 'package:marcaii_flutter/res/Strings.dart';

class ItensDifer {
  ItensDifer({this.diaSemana, this.porcent, this.valor});

  int diaSemana, porcent;
  double valor;
}

class PageEmpregoPorcentagens extends StatefulWidget {
  @override
  _PageEmpregoPorcentagensState createState() => _PageEmpregoPorcentagensState();
}

class _PageEmpregoPorcentagensState extends State<PageEmpregoPorcentagens> {
  final _weekDays = ["Domingo", "Segunda", "Terça", "Quarta", "Quinta", "Sexta", "Sábado"];
  double valor;

  List<ItensDifer> _itensDifer = [];

  @override
  void initState() {
    valor = 0.0;
    _itensDifer.add(ItensDifer(diaSemana: 0, porcent: 150, valor: 12.0));
    _itensDifer.add(ItensDifer(diaSemana: 1, porcent: 12, valor: 0.0));
    _itensDifer.add(ItensDifer(diaSemana: 2, porcent: 0, valor: 0.0));
    _itensDifer.add(ItensDifer(diaSemana: 3, porcent: 0, valor: 0.0));
    _itensDifer.add(ItensDifer(diaSemana: 4, porcent: 0, valor: 0.0));
    _itensDifer.add(ItensDifer(diaSemana: 5, porcent: 0, valor: 0.0));
    _itensDifer.add(ItensDifer(diaSemana: 6, porcent: 110, valor: 12.0));
    super.initState();
  }

  void _inc() {
    setState(() {
      valor += 2;
      _itensDifer[1].valor = valor;
    });
  }

  void _dec() {
    setState(() {
      valor -= 2;
      _itensDifer[1].valor = valor;
    });

    print(_itensDifer[1].valor);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: ListTile(
                title: TextFormField(
                  decoration: InputDecoration(
                      labelText: Strings.porcNormal,
                      hintText: Strings.hintPorc,
                      labelStyle: TextStyle(color: Colors.lightGreen)),
                ),
              ),
            ),
            Expanded(
              child: ListTile(
                title: TextFormField(
                  decoration: InputDecoration(
                      labelText: Strings.porcFeriados,
                      hintText: Strings.hintPorc,
                      labelStyle: TextStyle(color: Colors.orange)),
                ),
              ),
            ),
          ],
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _itensDifer.length,
            itemBuilder: (c, i) {
              var item = _itensDifer[i];
              return _getPorcDifWidget(item);
            },
          ),
        )
      ],
    );
  }

  Widget _getPorcDifWidget(ItensDifer item) {
    return Card(
      margin: EdgeInsets.all(2.0),
      elevation: 1.0,
      child: Container(
        child: ListTile(
          leading: Icon(
            Icons.av_timer,
            color: Colors.black87,
          ),
          trailing: Icon(
            Icons.delete_sweep,
            color: Theme.of(context).dividerColor,
          ),
          title: Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      _weekDays[item.diaSemana],
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                    Text(
                      "${item.porcent} %",
                      style: TextStyle(color: Colors.black87, fontSize: 16.0),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      Strings.valor,
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                    Text(
                      CurrencyUtils.doubleToCurrency(item.valor),
                      style: TextStyle(color: Colors.black87, fontSize: 16.0),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
