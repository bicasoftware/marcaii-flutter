import 'package:flutter/material.dart';
import 'package:marcaii_flutter/Strings.dart';
import 'package:marcaii_flutter/modules/act_get_empregos/page_emprego_info/widgets/ValidatableListItem.dart';
import 'package:marcaii_flutter/utils/CurrencyUtils.dart';
import 'package:marcaii_flutter/utils/Validation.dart';

class ValorSalarioHolder extends StatelessWidget {
  const ValorSalarioHolder({
    Key key,
    @required this.valorSalario,
    @required this.title,
    @required this.formKey,
    @required this.onSave,
  }) : super(key: key);

  final double valorSalario;
  final String title;
  final GlobalKey formKey;
  final Function(double) onSave;

  @override
  Widget build(BuildContext context) {
    return ValidatableListItem(
      formKey: formKey,
      title: title,
      icon: Icons.monetization_on,
      initValue: CurrencyUtils.doubleToCurrency(valorSalario),
      hint: Strings.hintSalario,
      onSave: _onSave,
      onValidate: _validate,
    );
  }

  String _validate(String e) {
    if (!Validation.isCash(e)) return Warn.warSalarioInvalido;
    return null;
  }

  _onSave(e) {
    onSave(double.parse(e.replaceAll(",", ".")));
  }
}
