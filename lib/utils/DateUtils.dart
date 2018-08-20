import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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

  static String dateTimeToBrString(DateTime date){
    return DateFormat("dd/MM/yyyy").format(date);
  }

  static String timeOfDayToStr(TimeOfDay time) {
    return "${time.hour.toString().padLeft(2, "0")}:${time.minute.toString().padLeft(2, "0")}";
  }
}
