import 'package:marcaii_flutter/models/state/DiferenciaisDto.dart';
import 'package:marcaii_flutter/models/state/EmpregoDto.dart';
import 'package:marcaii_flutter/models/state/HoraDto.dart';
import 'package:marcaii_flutter/models/state/SalariosDto.dart';
import 'package:marcaii_flutter/utils/DBManager.dart';
import 'package:scoped_model/scoped_model.dart';

class MainState extends Model {
  MainState({this.empregos});

  final List<EmpregoDto> empregos;

  DBManager manager = DBManager()..create().then((e) {});

  List<EmpregoDto> get getEmpregos => empregos;

  EmpregoDto getEmpregoAt(int pos) => empregos[pos];

  void appendEmprego(EmpregoDto emprego) {
    manager.insertEmprego(emprego).then((e) => emprego = e).whenComplete(() {
      empregos.add(emprego);
      notifyListeners();
    });
  }

  void appendHora(int empregoPos, HoraDto hora) {
    empregos[empregoPos].appendHora(hora);
    notifyListeners();
  }

  void appendSalario(int empregoPos, SalariosDto salario) {
    empregos[empregoPos].appendSalario(salario);
    notifyListeners();
  }

  void appendPorcDifer(int empregoPos, DiferenciaisDto difer) {
    empregos[empregoPos].appendPorcDifer(difer);
    notifyListeners();
  }
}
