import 'package:marcaii_flutter/state/CalendarCellDto.dart';

class CalendarPageDto {
  final int year, month;
  final List<CalendarCellDto> cells;

  CalendarPageDto({this.year, this.month, this.cells});
}