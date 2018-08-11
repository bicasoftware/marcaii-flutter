import 'package:marcaii_flutter/state/DiferenciaisDto.dart';
import 'package:marcaii_flutter/state/EmpregoDto.dart';
import 'package:marcaii_flutter/state/HoraDto.dart';
import 'package:marcaii_flutter/state/SalariosDto.dart';
import 'package:marcaii_flutter/utils/DBManager.dart';
import 'package:scoped_model/scoped_model.dart';

class MainState extends Model {
  MainState(this.currentDate, {this.empregos});

  DateTime currentDate;

  final List<EmpregoDto> empregos;

  DBManager manager = DBManager()..create().then((e) {});

  List<EmpregoDto> get getEmpregos => empregos;

  EmpregoDto getEmpregoAt(int pos) => empregos[pos];
  
  int _currentEmprego;

  int get idEmprego => _currentEmprego;

  void setCurrentEmprego(int pos){
    this._currentEmprego = empregos[pos].id;
    notifyListeners();
  }
  
  void addMonth() {

    if(currentMonth == 11){
      currentDate = DateTime.utc(currentDate.year + 1, 1, currentDate.day);
    } else {
      currentDate = DateTime.utc(currentDate.year, currentDate.month + 1, currentDate.day);
    }

    notifyListeners();
  }

  int get currentMonth => currentDate.month-1;
  
  void decMonth() {
    if(currentMonth == 0){
      currentDate = DateTime.utc(currentDate.year -1, 12, currentDate.day);
    } else {
      currentDate = DateTime.utc(currentDate.year, currentDate.month - 1, currentDate.day);
    }
    notifyListeners();
  }
  
  void setYear(int year){
    currentDate = DateTime.utc(year, currentDate.month, currentDate.day);
    notifyListeners();
  }
  int get currentYear => currentDate.year;

  void appendEmprego(EmpregoDto emprego) {
    manager.insertEmprego(emprego).then((e) => empregos.add(e)).whenComplete(() {
      notifyListeners();
    });
  }

  void updateEmprego(EmpregoDto emprego) {
    manager.updateEmprego(emprego).then((e) {
      final int pos = empregos.indexWhere((it) => it.id == e.id);
      empregos[pos] = e;
    }).whenComplete(() {
      notifyListeners();
    });
  }

  void deleteEmprego(int idEmprego) {
    manager.deleteEmprego(idEmprego).then((success) {
      if (success) empregos.removeWhere((e) => e.id == idEmprego);
    }).whenComplete(() {
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
