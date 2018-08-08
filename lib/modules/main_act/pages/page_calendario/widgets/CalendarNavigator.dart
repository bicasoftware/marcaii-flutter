import 'package:flutter/material.dart';
import 'package:marcaii_flutter/Strings.dart';
import 'package:marcaii_flutter/utils/SquaredCard.dart';

class CalendarNavigator extends StatelessWidget {
  final int currentMonth;
  final VoidCallback onNextMonth;
  final VoidCallback onPrevMonth;
  final Function(int) onMonthClicked;

  const CalendarNavigator({
    Key key,
    @required this.currentMonth,
    @required this.onNextMonth,
    @required this.onPrevMonth,
    @required this.onMonthClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SquaredCard(
      margin: EdgeInsets.all(0.0),
      child: Row(
        children: <Widget>[
          FlatButton(
            child: Icon(
              Icons.navigate_before,
              color: Colors.black87,
            ),
            onPressed: onPrevMonth,
          ),
          Expanded(
            child: FlatButton(
              child: Text(
                Arrays.months[currentMonth],
                style: TextStyle(color: Colors.black87),
              ),
              onPressed: () => onMonthClicked(currentMonth),
            ),
          ),
          FlatButton(
            child: Icon(
              Icons.navigate_next,
              color: Colors.black87,
            ),
            onPressed: onNextMonth,
          ),
        ],
      ),
    );
  }
}
