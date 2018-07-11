import 'package:flutter/material.dart';
import 'package:marcaii_flutter/MarcaiiState.dart';
import 'package:marcaii_flutter/Strings.dart';
import 'package:scoped_model/scoped_model.dart';

class ActRelacao extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.titleRelatorioHoras),
      ),
      body: Container(
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Relações"),
            Text("Listar"),
          ],
        ),
      ),

      floatingActionButton: ScopedModelDescendant<MarcaiiState>(
        builder: (context, child, model) {
          return FloatingActionButton(
            child: Icon(Icons.local_printshop),
            onPressed: (){
              Scaffold.of(context).showSnackBar(
                SnackBar(content: Text("Implementar Impressão"))
              );
            },
          );
        },
      ),
    );
  }
}
