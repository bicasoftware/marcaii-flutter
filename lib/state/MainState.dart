import 'package:marcaii_flutter/models/calendar/CalendarBuilder.dart';
import 'package:marcaii_flutter/models/calendar/CalendarPageDto.dart';
import 'package:marcaii_flutter/models/state/EmpregoDto.dart';
import 'package:marcaii_flutter/models/state/HoraDto.dart';
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

  void setCurrentEmprego(int pos) {
    this._currentEmprego = empregos[pos].id;
    notifyListeners();
  }

  int get currentMonth => currentDate.month - 1;

  void addMonth() {
    if (currentMonth == 11) {
      currentDate = DateTime.utc(currentDate.year + 1, 1, currentDate.day);
    } else {
      currentDate = DateTime.utc(currentDate.year, currentDate.month + 1, currentDate.day);
    }

    refreshCalendar();

    notifyListeners();
  }

  void decMonth() {
    if (currentMonth == 0) {
      currentDate = DateTime.utc(currentDate.year - 1, 12, currentDate.day);
    } else {
      currentDate = DateTime.utc(currentDate.year, currentDate.month - 1, currentDate.day);
    }
    refreshCalendar();
    notifyListeners();
  }

  int get currentYear => currentDate.year;

  void setYear(int year) {
    currentDate = DateTime.utc(year, currentDate.month, currentDate.day);
    refreshCalendar();
    notifyListeners();
  }

  void refreshCalendar() {
    final mes = currentDate.month;
    final ano = currentDate.year;

    //se já existir uma página salva, retorna, senão gera uma nova pra cada emprego;
    for (EmpregoDto e in empregos) {
      final index = e.listCalendarPages.indexWhere((it) => it.year == ano && it.month == mes);
      if (index >= 0) {
        e.setCurrentPage(e.listCalendarPages[index]);
      } else {
        final newPage = CalendarBuilder.buildPageAndBind(
          year: ano,
          month: mes,
          idEmprego: e.id,
          horas: e.listHoras,          
        );
        e.listCalendarPages.add(newPage);
        e.setCurrentPage(newPage);
      }
    }
  }

  void appendEmprego(EmpregoDto emprego) {
    manager.insertEmprego(emprego).then((EmpregoDto e) {
      final cells = CalendarBuilder.buildCalendarByMonth(currentYear, currentMonth + 1, e.id);
      final newPage = CalendarPageDto(year: currentYear, month: currentMonth, cells: cells);
      e.listCalendarPages.add(newPage);
      empregos.add(e);
    }).whenComplete(() {
      notifyListeners();
    });
  }

  void updateEmprego(EmpregoDto emprego) {
    manager.updateEmprego(emprego).then((e) async {
      final int pos = empregos.indexWhere((it) => it.id == e.id);
      final horas = await manager.fetchHorasByEmprego(emprego.id);
      final horasDto = horas.map((h) => h.toDto()).toList();
      final newPage = CalendarBuilder.buildPageAndBind(
        year: currentYear,
        month: currentMonth + 1,
        idEmprego: e.id,
        horas: horasDto,
      );
      e.listCalendarPages.add(newPage);
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

  void deleteHora({int idEmprego, int id}) {
    manager.deleteHora(idEmprego, id).then((sucess) {
      if (sucess) {
        empregos.firstWhere((e) => e.id == idEmprego).deleteHora(id);
      }
    }).whenComplete(() => notifyListeners());
  }

  void insertHora(int idEmprego, HoraDto hora) {
    manager.upsertHora(hora).then((newHora) {
      final index = empregos.indexWhere((e) => e.id == idEmprego);
      if (index > -1) {
        empregos[index].appendHora(newHora);
      }
    }).whenComplete(() => notifyListeners());
  }

  void updateHora(int idEmprego, HoraDto hora) {
    manager.upsertHora(hora).then((newHora) {
      final index = empregos.indexWhere((e) => e.id == idEmprego);
      if (index > -1) {
        empregos[index].updateHora(newHora);
      }
    }).whenComplete(() => notifyListeners());
  }

  int _currentPageViewPosition = 0;
  
  void setCurrentPagePosition(int pos) => _currentPageViewPosition = pos;

  int get currentPageViewPosition => _currentPageViewPosition;
}
