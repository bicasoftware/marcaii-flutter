import 'package:flutter/material.dart';
import 'package:marcaii_flutter/models/calendar/CalendarCellDto.dart';
import 'package:marcaii_flutter/models/state/DiferenciaisDto.dart';
import 'package:marcaii_flutter/models/state/HoraDto.dart';
import 'package:marcaii_flutter/utils/DateUtils.dart';
import 'package:scoped_model/scoped_model.dart';

class ModelHora extends Model {
  ModelHora({
    this.date,
    this.listDif,
    this.horaDto,
  });

  final List<DiferenciaisDto> listDif;
  final DateTime date;
  HoraDto horaDto;

  bool hasDiferencial() {
    return listDif.indexWhere((it) => it.diaSemana == DateUtils.getCurrentWeekday(date)) > -1;
  }

  void setHoraInicio(TimeOfDay horaInicio) {
    horaDto.horaInicial = horaInicio;
    _updateQuantidade();
    notifyListeners();
  }

  void setHoraTermino(TimeOfDay horaTermino) {
    horaDto.horaTermino = horaTermino;
    _updateQuantidade();
    notifyListeners();
  }

  void _updateQuantidade() {
    horaDto.quantidade = DateUtils.minutesBetween(init: horaInicial, end: horaTermino);
  }

  void setTipoHora(String tipoHora) {
    horaDto.tipoHora = tipoHora;
    notifyListeners();
  }

  String get tipoHora => horaDto.tipoHora;

  TimeOfDay get horaInicial => horaDto.horaInicial;

  TimeOfDay get horaTermino => horaDto.horaTermino;

  int get minutes => horaDto.quantidade;

  CalendarCellDto popResult() {
    return CalendarCellDto(
      date: date,
      hora: horaDto,
    );
  }
}
