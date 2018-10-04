import 'package:flutter/material.dart';
import 'package:marcaii_flutter/models/calendar/CalendarCellDto.dart';
import 'package:marcaii_flutter/models/state/DiferenciaisDto.dart';
import 'package:marcaii_flutter/modules/act_get_horas/ModelHora.dart';
import 'package:marcaii_flutter/modules/act_get_horas/ViewHoras.dart';
import 'package:scoped_model/scoped_model.dart';

class ActGetHoras extends StatefulWidget {
  final CalendarCellDto cell;
  final List<DiferenciaisDto> listDifer;
  final bool isBancoHoras;

  const ActGetHoras({
    Key key,
    @required this.cell,
    @required this.listDifer,
    @required this.isBancoHoras,
  }) : super(key: key);

  @override
  ActGetHorasState createState() {
    return new ActGetHorasState();
  }
}

class ActGetHorasState extends State<ActGetHoras> {
  ModelHora model;

  @override
  void initState() {
    model = widget.cell.toState(widget.listDifer);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel(
      model: model,
      child: ViewHoras(
        isBancoHoras: widget.isBancoHoras,
      ),
    );
  }
}
