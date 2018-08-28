import 'package:flutter/material.dart';
import 'package:marcaii_flutter/Strings.dart';
import 'package:marcaii_flutter/state/SalariosDto.dart';
import 'package:marcaii_flutter/utils/CurrencyUtils.dart';
import 'package:marcaii_flutter/widgets/BaseDivider.dart';
import 'package:marcaii_flutter/widgets/ContentText.dart';
import 'package:marcaii_flutter/widgets/TitleText.dart';
import 'package:marcaii_flutter/utils/YesNoDialog.dart';

class ActListSalarios extends StatelessWidget {
  const ActListSalarios({Key key, @required this.salarios}) : super(key: key);

  final List<SalariosDto> salarios;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Salários anteriores"),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(salarios),
          ),
        ),
        body: new ListBody(salarios: salarios));
  }
}

class ListBody extends StatefulWidget {

  const ListBody({
    Key key,
    @required this.salarios,
  }) : super(key: key);

  final List<SalariosDto> salarios;

  @override
  ListBodyState createState() {
    return new ListBodyState();
  }
}

class ListBodyState extends State<ListBody> {
  List<SalariosDto> _salarios;

  @override
  void initState() {
    _salarios = widget.salarios;
    super.initState();
  }

  void _removeAt(int i) {
    setState(() {
      _salarios.removeAt(i);
      _salarios.forEach((s) => s.status = false);
      _salarios.last.status = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: ListView.builder(
            itemCount: _salarios.length,
            itemBuilder: (ct, i) {
              final s = _salarios[i];
              return SalarioTile(
                valor: s.valorSalario,
                vigencia: s.vigencia,
                showDivider: i < _salarios.length - 1,
                onDelete: () {
                  if (i > 0) {
                    showConfirmationDialog(
                      context: context,
                      message: Strings.confirmar_remocao_salario,
                    ).then((result) {
                      if (result == true) _removeAt(i);
                    });
                  }
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

class SalarioTile extends StatelessWidget {
  final double valor;
  final String vigencia;
  final VoidCallback onDelete;
  final bool showDivider;

  const SalarioTile({
    Key key,
    @required this.valor,
    @required this.onDelete,
    @required this.vigencia,
    this.showDivider: true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final splitVig = vigencia.split("-").map((v) => int.parse(v)).toList();
    final vig = " ${Arrays.monthsAbrev[splitVig[1]]}/${splitVig[0]}";
    return Column(
      children: <Widget>[
        ListTile(
          leading: Icon(
            Icons.assessment,
            color: Theme.of(context).accentColor,
          ),
          trailing: IconButton(
            icon: Icon(
              Icons.delete_sweep,
              color: Colors.black45,
            ),
            onPressed: onDelete,
          ),
          title: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  TitleText(text: Strings.valorSalario),
                  TitleText(text: Strings.vigencia),
                ],
              ),
              Row(
                children: <Widget>[
                  ContentText(text: CurrencyUtils.doubleToCurrency(valor)),
                  ContentText(text: vig),
                ],
              ),
            ],
          ),
        ),
        showDivider
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: BaseDivider(),
              )
            : Container(),
      ],
    );
  }
}
