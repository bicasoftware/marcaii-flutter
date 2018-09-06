import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:marcaii_flutter/Strings.dart';
import 'package:marcaii_flutter/utils/Validation.dart';

class ActGetSalario extends StatefulWidget {
  ActGetSalario({Key key, this.initValue}) : super(key: key);

  final double initValue;

  @override
  ActGetSalarioState createState() {
    return new ActGetSalarioState();
  }
}

class ActGetSalarioState extends State<ActGetSalario> {
  MoneyMaskedTextController controller;

  void initState() {
    super.initState();
    controller = Validation.defaultMoneyMask(widget.initValue);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.alterarSalario),
      ),
      body: Card(
        elevation: 2.0,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.green,
                child: Icon(Icons.monetization_on),
              ),
              title: TextFormField(
                autofocus: true,
                controller: controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: Strings.hintSalario,
                  labelText: Strings.valorSalario,
                ),
                validator: (s) {
                  if (s == "" || controller.numberValue <= 0) {
                    return Warn.warSalarioInvalido;
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.save),
        onPressed: () {
          if (controller.numberValue > 0) {
            Navigator.of(context).pop(controller.numberValue);
          }
        },
      ),
    );
  }
}
