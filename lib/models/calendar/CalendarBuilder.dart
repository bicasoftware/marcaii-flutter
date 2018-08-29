import 'package:marcaii_flutter/models/calendar/CalendarCellDto.dart';
import 'package:marcaii_flutter/models/calendar/CalendarPageDto.dart';
import 'package:marcaii_flutter/models/state/HoraDto.dart';
import 'package:marcaii_flutter/utils/DateUtils.dart';

class CalendarBuilder {
  static List<CalendarCellDto> buildCalendarByMonth(int year, int month, int idEmprego) {
    DateTime date = DateTime.utc(year, month, 1);
    final days = List<CalendarCellDto>();

    //adiciona itens vazios no começo do calendário
    if (date.weekday <= 6) {
      for (var i = 0; i < date.weekday; i++) {
        days.add(null);
      }
    }

    while (date.month == month) {
      days.add(
        CalendarCellDto(
          date: date,
          hora: HoraDto(
            idEmprego: idEmprego,
            dta: DateUtils.dateTimeToString(date),
          ),
        ),
      );
      date = date.add(Duration(days: 1));
    }

    //adiciona itens vazios no fim do calendário até ficar uma matriz NxN
    while (days.length % 7 != 0) {
      days.add(null);
    }

    return days;
  }

  static CalendarPageDto buildPageAndBind({
    idEmprego: int,
    year: int,
    month: int,
    List<HoraDto> horas,
  }) {
    final cells = CalendarBuilder.buildCalendarByMonth(year, month, idEmprego);
    cells.where((it) => it != null).forEach((CalendarCellDto c) {
      String parsedDate = DateUtils.dateTimeToString(c.date);
      HoraDto hora = horas.firstWhere((h) => h.dta == parsedDate, orElse: () => null);
      if (hora != null) {
        c.hora.copyFrom(hora);
      }
    });

    return CalendarPageDto(year: year, month: month, cells: cells);
  }
}
