import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:intl/intl.dart';

class Formatting {
  static bool isCash(String value) {
    final regex = RegExp(r"""^\d+\,\d{2}$""");
    final matches = regex.allMatches(value);
    return matches.length == 1;
  }

  static bool isValidPercent(String value) {
    final isValid = RegExp(r"^\d+$").allMatches(value).length == 1;
    return isValid && int.parse(value) >= 30;
  }

  static MoneyMaskedTextController defaultMoneyMask(double initialValue) {
    return MoneyMaskedTextController(
      decimalSeparator: ',',
      thousandSeparator: '.',
      initialValue: initialValue,
    );
  }

  static final f = NumberFormat("0.00", "pt_BR");

  static String doubleToCurrency(double value) => f.format(value);

  static double calcPorcentExtra(double salario, int cargaHoraria, int porc) {
    if (porc == 0) {
      return 0.0;
    } else {
      final rounded = ((salario / cargaHoraria) * (1 + (porc / 100))).toStringAsFixed(2);
      return double.parse(rounded);
    }
  }
}
