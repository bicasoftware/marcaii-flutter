import 'dart:ui';

class RelatorioItemDto {
  final String inicio, termino;
  final double valor;
  final int minutos;
  final String date;
  final Color color;

  RelatorioItemDto({this.inicio, this.termino, this.valor, this.minutos, this.date, this.color});
}