import 'package:flutter/material.dart';
import 'package:marcaii_flutter/modules/bts_info_horas/PresenterBtsInfoHora.dart';
import 'package:marcaii_flutter/state/CalendarCellDto.dart';

class BottomSheetInfoHoras extends StatelessWidget {
  final CalendarCellDto cell;

  const BottomSheetInfoHoras({Key key, this.cell}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final presenter = PresenterBtsInfoHora(cell);

    return Container(
      padding: EdgeInsets.only(
        top: 16.0,
        left: 36.0,
        bottom: 16.0,
        right: 16.0,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              presenter.getDateLabel(),
              presenter.getUpdateBtn(context),
              presenter.getDeleteBtn(context),
            ],
          ),
          Divider(),
          presenter.getMinutesLabel(context),
          Divider(),
          presenter.getTipoHora(),
          presenter.getValorHora(),
        ],
      ),
    );
  }
}
