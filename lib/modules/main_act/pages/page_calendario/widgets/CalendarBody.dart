import 'package:flutter/material.dart';
import 'package:marcaii_flutter/modules/act_get_horas/ActGetHoras.dart';
import 'package:marcaii_flutter/modules/main_act/pages/page_calendario/widgets/CalendarBodyItem.dart';
import 'package:marcaii_flutter/state/CalendarCellDto.dart';
import 'package:marcaii_flutter/state/DiferenciaisDto.dart';
import 'package:marcaii_flutter/state/MainState.dart';
import 'package:scoped_model/scoped_model.dart';

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
            shrinkWrap: true,
            childAspectRatio: 1.0,
            crossAxisCount: 7,
            crossAxisSpacing: 0.0,
            mainAxisSpacing: 0.0,
            padding: EdgeInsets.all(1.0),            
            children: _preparedList(context, (CalendarCellDto item) {
              state.insertHora(item.hora.idEmprego, item.hora);
            }),
          ),
        );
      },
    );
  }

  List<CalendarBodyItem> _preparedList(
    BuildContext context,
    Function(CalendarCellDto) onSave,    
  ) {
    return cells.map((cell) {
      return CalendarBodyItem(
        cell: cell,
        onCellTap: (data, hora) async {
          if (hora.id == null) {
            final result = await Navigator.of(context).push(
              MaterialPageRoute(builder: (context) {
                return ActGetHoras(
                  cell: cell,
                  listDifer: listDifer,
                );
              }),
            );

            if (result != null && result is CalendarCellDto) {
              onSave(result);
            }
          } else {
            //todo - mostrar bottomsheet com a hora referente
          }
        },
      );
    }).toList();
  }
}
