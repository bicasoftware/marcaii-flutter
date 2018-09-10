import 'package:flutter/material.dart';
import 'package:marcaii_flutter/Strings.dart';
import 'package:marcaii_flutter/utils/DateUtils.dart';

class HoraDto {
  HoraDto({
    this.id,
    this.idEmprego,
    this.quantidade: 60,
    this.horaInicial: const TimeOfDay(hour: 18, minute: 00),
    this.horaTermino: const TimeOfDay(hour: 19, minute: 00),
    this.dta,
    this.tipoHora: Consts.horaNormal,
  });

  int id, idEmprego, quantidade;
  DateTime dta;
  String tipoHora;
  TimeOfDay horaInicial, horaTermino;

  @override
  String toString() {
    return """
    id: $id,
    idEmprego: $idEmprego,
    quantidade: $quantidade,
    horaInicial: $horaInicial,
    horaTermino: $horaTermino,
    dta: $dta,
    tipoHora: $tipoHora
    """;
  }

  Map toMap() {
    Map<String, dynamic> map = {
      "idEmprego": idEmprego,
      "quantidade": quantidade,
      "horaInicial": DateUtils.timeOfDayToStr(horaInicial),
      "horaTermino": DateUtils.timeOfDayToStr(horaTermino),
      "dta": DateUtils.dateTimeToString(dta),
      "tipoHora": tipoHora,
    };

    if (id != null) {
      map["id"] = id;
    }

    return map;
  }

  void cloneFrom(HoraDto from) {
    this.id = from.id;
    this.idEmprego = from.idEmprego;
    this.horaInicial = from.horaInicial;
    this.quantidade = from.quantidade;
    this.horaTermino = from.horaTermino;
    this.dta = from.dta;
    this.tipoHora = from.tipoHora;
  }

  void copyFrom(HoraDto from) {
    this.id = from.id;
    this.idEmprego = from.idEmprego;
    this.quantidade = from.quantidade;
    this.horaInicial = from.horaInicial;
    this.horaTermino = from.horaTermino;
    this.dta = from.dta;
    this.tipoHora = from.tipoHora;
  }

  void clear(DateTime date) {
    this.id = null;
    this.horaInicial = DateUtils.hourStrToTimeOfDay("18:00");
    this.horaTermino = DateUtils.hourStrToTimeOfDay("19:00");
    this.quantidade = 60;
    this.dta = date;
    this.tipoHora = Consts.horaNormal;
  }
}
