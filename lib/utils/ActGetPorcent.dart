import 'package:flutter/material.dart';
import 'package:marcaii_flutter/Strings.dart';
import 'package:marcaii_flutter/utils/DualLineAppBar.dart';
import 'package:marcaii_flutter/utils/Validation.dart';

class ActGetPorcentagem extends StatefulWidget {
  const ActGetPorcentagem({
    Key key,
    this.porc: 30,
    @required this.diaSemana,
  }) : super(key: key);

  final int porc, diaSemana;

  @override
  ActGetPorcentagemState createState() {
    return new ActGetPorcentagemState();
  }
}

class ActGetPorcentagemState extends State<ActGetPorcentagem> {
  GlobalKey<FormState> key;

  @override
  void initState() {
    super.initState();
    key = GlobalKey<FormState>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DualLineAppBar(
        bigText: Strings.diferenciais,
        smallText: "${Arrays.weekDays[widget.diaSemana]}",
      ),
      body: Card(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(
              child: Form(
                key: key,
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Theme.of(context).accentColor,
                    child: Icon(Icons.account_balance_wallet),
                  ),
                  title: TextFormField(
                    initialValue: widget.porc.toString(),
                    autofocus: true,
                    keyboardType: TextInputType.numberWithOptions(
                      decimal: false,
                      signed: false,
                    ),
                    decoration: InputDecoration(
                      labelText: Strings.digiteValor,
                      hintText: Strings.hintPorc,
                      suffixText: "%",
                    ),
                    validator: (e) {
                      if (!Validation.isValidPercent(e.trim())) {
                        return Warn.warPorcInvalida;
                      }

                      return null;
                    },
                    onSaved: (e) {
                      Navigator.of(context).pop(int.parse(e));
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.save),
        onPressed: () {
          final state = key.currentState;
          if (state.validate() == true) {
            state.save();
          }
        },
      ),
    );
  }
}
