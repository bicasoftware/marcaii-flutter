import 'package:flutter/material.dart';
import 'package:marcaii_flutter/Strings.dart';
import 'package:marcaii_flutter/models/state/RelatorioItemDto.dart';
import 'package:marcaii_flutter/utils/DateUtils.dart';
import 'package:scoped_model/scoped_model.dart';

class ModelRelacao extends Model {
  ModelRelacao({
    @required this.mes,
    @required this.inicio,
    @required this.termino,
    @required this.items,
    @required this.salario,
    @required this.isBancoHoras,
  });

  int mes;
  DateTime inicio, termino;
  bool isBancoHoras;
  List<RelatorioItemDto> items;
  double salario;

  String get mesString => Arrays.months[mes];

  String get periodo {
    return DateUtils.dateTimeToBrString(inicio) + " até " + DateUtils.dateTimeToBrString(termino);
  }

  int get minutosNormais {
    return items.where((h) => h.color == Colors.green).fold(0, (t, n) => t += n.minutos) ?? 0;
  }

  int get minutosCompletos {
    return items.where((h) => h.color == Colors.orange).fold(0, (t, n) => t += n.minutos) ?? 0;
  }

  int get minutosDifer {
    return items.where((h) => h.color == Colors.red).fold(0, (t, n) => t += n.minutos) ?? 0;
  }

  double get valorNormal {
    return items.where((h) => h.color == Colors.green).fold(0.0, (t, n) => t += n.valor) ?? 0.0;
  }

  double get valorCompletos {
    return items.where((h) => h.color == Colors.orange).fold(0.0, (t, n) => t += n.valor) ?? 0.0;
  }

  double get valorDiferencial {
    return items.where((h) => h.color == Colors.red).fold(0.0, (t, n) => t += n.valor) ?? 0.0;
  }

  int get totalMinutos => items.fold(0, (t, n) => t += n.minutos);

  double get totalValor => items.fold(0.0, (t, n) => t += n.valor);
}
