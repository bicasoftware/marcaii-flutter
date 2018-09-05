import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:marcaii_flutter/Strings.dart';

class DateUtils {
  static int getCurrentWeekday(DateTime date) {
    switch (date.weekday) {
      case DateTime.sunday:
        return 0;
        break;
      case DateTime.monday:
        return 1;
        break;
      case DateTime.tuesday:
        return 2;
        break;
      case DateTime.wednesday:
        return 3;
        break;
      case DateTime.thursday:
        return 4;
        break;
      case DateTime.friday:
        return 5;
        break;
      case DateTime.saturday:
        return 6;
        break;
      default:
        return 0;
    }
  }

  static TimeOfDay hourStrToTimeOfDay(String hour) {
    List<int> splitHour = hour.split(":").map((f) => int.parse(f)).toList();
    return TimeOfDay(hour: splitHour[0], minute: splitHour[1]);
  }

  static DateTime timeOfDayToDateTime(TimeOfDay time) {
    final now = DateTime.now();
    return DateTime.utc(now.year, now.month, now.day, time.hour, time.minute);
  }

  static bool isValidTimeRange(TimeOfDay init, TimeOfDay end) {
    final initDate = timeOfDayToDateTime(init);
    final endDate = timeOfDayToDateTime(end);

    return initDate.isBefore(endDate);
  }

  static int minutesBetween({TimeOfDay init, TimeOfDay end}) {
    final initDate = DateUtils.timeOfDayToDateTime(init);
    final endDate = DateUtils.timeOfDayToDateTime(end);
    final dif = endDate.difference(initDate);
    return dif.inMinutes;
  }

  static String dateTimeToString(DateTime date) {
    final formater = DateFormat("yyyy-MM-dd");
    return formater.format(date);
  }

  static String dateTimeToBrString(DateTime date) {
    return DateFormat("dd/MM/yyyy").format(date);
  }

  static DateTime parseString(String dateString){
    return DateFormat("yyyy-MM-dd").parse(dateString);
  }

  static String timeOfDayToStr(TimeOfDay time) {
    return "${time.hour.toString().padLeft(2, "0")}:${time.minute.toString().padLeft(2, "0")}";
  }

  static String getVigencia(DateTime date) {
    return DateFormat("yyyy-MM").format(date);
  }

  static DateTime vigenciaToDate(String vigencia) {
    if (!RegExp(r"^\d{4}-\d{2}$").hasMatch(vigencia)) throw Exception(Warn.warVigenciaInvalida);
    return DateFormat("yyyy-MM").parse(vigencia);
  }

  static Map<String, DateTime> prepareVigencia(int ano, int mes, int fechamento) {
    DateTime inicio = DateTime.utc(ano, mes == 0 ? 11 : mes - 1, fechamento + 1);
    DateTime termino = DateTime.utc(ano, mes, fechamento);

    return {"inicio": inicio, "termino": termino};
  }
}
