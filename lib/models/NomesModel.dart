import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class NomesModel extends Model {

    List<String> _nomes = ["saulo", "henrique", "andrioli"];
    int _count = 0;
    int get count => _count;

    List<String> get nomes => _nomes;

    void addNome() {
        _count++;
        _nomes.add("Nome: $_count");
        notifyListeners();
    }

    void removeLastNome() {
        _count--;
        _nomes.removeAt(_nomes.length - 1);
        notifyListeners();
    }

    void clear(){
        _count = 0;
        _nomes.clear();
        notifyListeners();
    }

    List<Widget> getListView() => _nomes.map((n) => _getListItem(n)).toList();

    Widget _getListItem(String n) {
        return Card(
            child: Container(
                padding: EdgeInsets.all(8.0),
                margin: EdgeInsets.all(8.0),
                child: Row(
                    children: <Widget>[
                        Icon(Icons.person, color: Colors.teal,),
                        Text("Nome: $n")
                    ],
                ),
            ),
        );
    }
}