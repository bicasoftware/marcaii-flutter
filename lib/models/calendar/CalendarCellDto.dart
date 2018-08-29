import 'package:marcaii_flutter/models/state/DiferenciaisDto.dart';
import 'package:marcaii_flutter/models/state/HoraDto.dart';
import 'package:marcaii_flutter/modules/act_get_horas/ModelHora.dart';

class CalendarCellDto {
  final DateTime date;
  final HoraDto hora;

  const CalendarCellDto({this.date, this.hora});

  ModelHora toState(List<DiferenciaisDto> list) {
    return ModelHora(
      date: date,
      horaDto: hora,
      listDif: list,
    );
  }

  void clear(){
    hora.clear(date);
  }

  @override
  String toString() {
    return """date: ${date.toIso8601String()} - hora: ${hora.toString()}""";
  }
}
