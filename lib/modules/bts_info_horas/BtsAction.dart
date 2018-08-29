
import 'package:marcaii_flutter/models/calendar/CalendarCellDto.dart';

enum BtsAction {
  DELETE,
  UPDATE,
}

class BtsResult{
  final BtsAction action;
  final CalendarCellDto cellDto;

  const BtsResult({this.action, this.cellDto});
}