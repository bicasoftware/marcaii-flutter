import 'package:intl/intl.dart';

class CurrencyUtils {
  static final f = NumberFormat("0.00", "pt_BR");

  static String doubleToCurrency(double value) => f.format(value);
}
