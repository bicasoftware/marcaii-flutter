import 'package:intl/intl.dart';

class CurrencyUtils {

    static final f = NumberFormat("R\$ ###.00##", "pt_BR");

    static String doubleToCurrency(double value) => f.format(value);
}