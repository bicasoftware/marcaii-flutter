import 'package:marcaii_flutter/state/CalendarCellDto.dart';
import 'package:marcaii_flutter/state/HoraDto.dart';

class CalendarBuilder {
  ///todo - gerar state em StateBuilder e gerar calendário!
  static List<CalendarCellDto> buildCalendarByMonth(int year, int month) {
    DateTime date = DateTime.utc(year, month, 1);
    final days = List<CalendarCellDto>();

    //adiciona itens vazios no começo do calendário
    if (date.weekday <= 6) {
      for (var i = 0; i < date.weekday; i++) {
        days.add(null);
      }
    }

    while (date.month == month) {
      days.add(CalendarCellDto(date: date, hora: HoraDto()));
      date = date.add(Duration(days: 1));
    }

    //adiciona itens vazios no fim do calendário até ficar uma matriz NxN
    while (days.length % 7 != 0) {
      days.add(null);
    }

    return days;
  }
}
