class DateUtils{
  static int getCurrentWeekday(DateTime date){
    switch(date.weekday){
      case DateTime.sunday: return 0; break;
      case DateTime.monday: return 1; break;
      case DateTime.tuesday: return 2; break;
      case DateTime.wednesday: return 3; break;
      case DateTime.thursday: return 4; break;
      case DateTime.friday: return 5; break;
      case DateTime.saturday: return 6; break;
      default: return 0;
    }

  }
}