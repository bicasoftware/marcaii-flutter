import 'package:intl/intl.dart';

class CurrencyUtils {
  static final f = NumberFormat("0.00", "pt_BR");

  static String doubleToCurrency(double value) => f.format(value);

  static double calcPorcentExtra(double salario, int cargaHoraria, int porc) {
    final rounded = ((salario / cargaHoraria) * (1 + (porc / 100))).toStringAsFixed(2);
    return double.parse(rounded);
  }
}
