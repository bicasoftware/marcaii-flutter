import 'package:flutter/material.dart';

class CalendarDayDto {
  final DateTime date;
  final int day;
  final Color color;
  final int idHora;

  const CalendarDayDto(this.day, this.color, this.idHora, this.date);

  @override toString(){
    return "day: $day, color: ${color.value}, idHora: $idHora, date: ${date.toIso8601String()} ";
  }

}