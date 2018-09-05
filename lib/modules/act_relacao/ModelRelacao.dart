import 'package:marcaii_flutter/Strings.dart';
import 'package:marcaii_flutter/models/state/RelatorioItemDto.dart';
import 'package:marcaii_flutter/utils/DateUtils.dart';
import 'package:scoped_model/scoped_model.dart';

class ModelRelacao extends Model {
  ModelRelacao({
    this.mes,
    this.inicio,
    this.termino,
    this.items,
    this.salario,
  });

  int mes;
  DateTime inicio, termino;
  List<RelatorioItemDto> items;
  double salario;

  String get mesString => Arrays.months[mes];

  String get periodo {
    return DateUtils.dateTimeToBrString(inicio) + " até " + DateUtils.dateTimeToBrString(termino);
  }
}
