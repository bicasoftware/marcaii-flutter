import 'package:flutter/material.dart';
import 'package:marcaii_flutter/Strings.dart';
import 'package:marcaii_flutter/modules/act_get_horas/ActGetHoras.dart';
import 'package:marcaii_flutter/modules/bts_info_horas/BottomSheetInfoHoras.dart';
import 'package:marcaii_flutter/modules/bts_info_horas/BtsAction.dart';
import 'package:marcaii_flutter/modules/main_act/pages/page_calendario/widgets/CalendarBodyItem.dart';
import 'package:marcaii_flutter/state/CalendarCellDto.dart';
import 'package:marcaii_flutter/state/DiferenciaisDto.dart';
import 'package:marcaii_flutter/state/MainState.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:marcaii_flutter/utils/YesNoDialog.dart';

class CalendarBody extends StatelessWidget {
  const CalendarBody({
    Key key,
    @required this.cells,
    @required this.listDifer,
  }) : super(key: key);

  final List<CalendarCellDto> cells;
  final List<DiferenciaisDto> listDifer;

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainState>(
      builder: (_, __, state) {
        return Expanded(
          child: GridView.count(
            childAspectRatio: 1.0,
            crossAxisCount: 7,
            crossAxisSpacing: 0.0,
            mainAxisSpacing: 0.0,
            padding: EdgeInsets.all(1.0),
            children: _preparedList(
                context: context,
                onSave: (CalendarCellDto item) {
                  state.insertHora(item.hora.idEmprego, item.hora);
                },
                onDelete: (item) {
                  state.deleteHora(
                    id: item.hora.id,
                    idEmprego: item.hora.idEmprego,
                  );
                }),
          ),
        );
      },
    );
  }

  //todo - revisar rotina, melhorar performance
  List<CalendarBodyItem> _preparedList({
    BuildContext context,
    Function(CalendarCellDto) onSave,
    Function(CalendarCellDto) onDelete,
  }) {
    return cells.map((cell) {
      return CalendarBodyItem(
        cell: cell,
        onCellTap: (data, hora) async {
          if (hora.id == null) {
            _callActGetHora(context, cell, onSave);
          } else {
            _callBtsInfoHora(context, cell, onSave, onDelete);
          }
        },
      );
    }).toList();
  }

  void _callActGetHora(
    BuildContext context,
    CalendarCellDto cell,
    Function(CalendarCellDto) onSave,
  ) async {
    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return ActGetHoras(
            cell: cell,
            listDifer: listDifer,
          );
        },
      ),
    );

    if (result != null && result is CalendarCellDto) {
      onSave(result);
    }
  }

  void _callBtsInfoHora(
    BuildContext context,
    CalendarCellDto cell,
    Function(CalendarCellDto) onSave,
    Function(CalendarCellDto) onDelete,
  ) async {
    final result = await showModalBottomSheet(
      context: context,
      builder: (context) => BottomSheetInfoHoras(cell: cell),
    );

    if (result != null && result is BtsResult) {
      if (result.action == BtsAction.DELETE) {
        final confirmation = await showConfirmationDialog(
          context: context,
          message: Strings.confirmar_remocao_hora,
        );

        if (confirmation) onDelete(cell);
      }
    }
  }
}
