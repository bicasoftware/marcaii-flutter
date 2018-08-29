import 'package:flutter/material.dart';
import 'package:marcaii_flutter/models/calendar/CalendarCellDto.dart';
import 'package:marcaii_flutter/models/state/DiferenciaisDto.dart';
import 'package:marcaii_flutter/modules/act_get_horas/ViewHoras.dart';
import 'package:scoped_model/scoped_model.dart';

class ActGetHoras extends StatelessWidget {
  final CalendarCellDto cell;
  final List<DiferenciaisDto> listDifer;

  const ActGetHoras({
    Key key,
    @required this.cell,
    @required this.listDifer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScopedModel(
      model: cell.toState(listDifer),
      child: ViewHoras(),
    );
  }
}
