import 'package:flutter/material.dart';
import 'package:marcaii_flutter/Strings.dart';
import 'package:marcaii_flutter/utils/SquaredCard.dart';

class CalendarHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final int weekDay = DateTime.now().weekday;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: _getHeaderDays(context, weekDay),
    );
  }

  List<Widget> _getHeaderDays(BuildContext context, int weekDay) {
    return List.generate(Arrays.weekDaysAbrev.length, (i) {
      return _getDayItem(context, Arrays.weekDaysAbrev[i], i == weekDay);
    });
  }

  Widget _getDayItem(BuildContext context, String day, bool itsDay) {
    final Color accentColor = Theme.of(context).accentColor;
    final style = TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.black,
      fontSize: 12.0,
    );

    final itsDayStyle = style.copyWith(
      color: accentColor,
    );

    return Expanded(
      child: SquaredCard(
        borderColor: itsDay ? accentColor : Colors.grey,
        fillColor: itsDay ? Colors.white10 : Colors.white,
        margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 1.0),
        padding: 2.0,
        child: Text(
          day,
          style: itsDay ? itsDayStyle : style,
          textAlign: TextAlign.center,
          maxLines: 1,
          softWrap: true,
        ),
      ),
    );
  }
}
