import 'package:marcaii_flutter/models/CalendarPageDto.dart';
import 'package:marcaii_flutter/state/CalendarBuilder.dart';
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
  
  int get currentMonth => currentDate.month-1;
  void addMonth() {
    if(currentMonth == 11){
      currentDate = DateTime.utc(currentDate.year + 1, 1, currentDate.day);
    } else {
      currentDate = DateTime.utc(currentDate.year, currentDate.month + 1, currentDate.day);
    }

    refreshCalendar();

    notifyListeners();
  }

  void decMonth() {
    if(currentMonth == 0){
      currentDate = DateTime.utc(currentDate.year -1, 12, currentDate.day);
    } else {
      currentDate = DateTime.utc(currentDate.year, currentDate.month - 1, currentDate.day);
    }
    refreshCalendar();
    notifyListeners();
  }
  
  int get currentYear => currentDate.year;
  void setYear(int year){
    currentDate = DateTime.utc(year, currentDate.month, currentDate.day);
    refreshCalendar();
    notifyListeners();
  }

  void refreshCalendar(){
    final mes = currentDate.month;
    final ano = currentDate.year;
    
    //se já existir uma página salva, retorna, senão gera uma nova pra cada ano;
    for(EmpregoDto e in empregos){      
      final index = e.listCalendarPages.indexWhere((it) => it.year == ano && it.month == mes);
      if(index >= 0){
        e.currentPage = e.listCalendarPages[index];
      } else {
        final cells = CalendarBuilder.buildCalendarByMonth(ano, mes);
        final newPage = CalendarPageDto(year: ano, month: mes, cells: cells);
        e.listCalendarPages.add(newPage);
        e.currentPage = newPage;
      }
    }
  }


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
