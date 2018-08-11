import 'package:flutter/material.dart';
import 'package:marcaii_flutter/state/CalendarDayDto.dart';

class CalendarBuilder {
  ///todo - gerar state em StateBuilder e gerar calendário!
  static List<CalendarDayDto> buildCalendarByMonth(int year, int month){
    DateTime date = DateTime.utc(year, month, 1);
    final days = List<CalendarDayDto>();
    
    while(date.month == month){
      days.add(
        CalendarDayDto(date.day, Colors.green, 0, date)
      );
      date = date.add(Duration(days: 1));
    }

    return days;
  }
}