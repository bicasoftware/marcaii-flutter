import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:marcaii_flutter/Strings.dart';
import 'package:marcaii_flutter/utils/Formatting.dart';

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
  final key = GlobalKey<FormState>();

  void initState() {
    super.initState();
    controller = Formatting.defaultMoneyMask(widget.initValue);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.alterarSalario),
      ),
      body: Card(
        elevation: 2.0,
        child: Form(
          key: key,
          child: ListTile(
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
                prefix: Text("R\$"),
              ),
              validator: (s) {
                return s.isEmpty || controller.numberValue <= 0 ? Warn.warSalarioInvalido : null;
              },
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.save),
        onPressed: () {
          final state = key.currentState;
          if(state.validate()) {
            Navigator.of(context).pop(controller.numberValue);
          }          
        },
      ),
    );
  }
}
