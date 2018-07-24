import 'package:flutter/material.dart';
import 'package:marcaii_flutter/Strings.dart';
import 'package:marcaii_flutter/modules/act_get_empregos/page_emprego_info/widgets/ValidatableListItem.dart';
import 'package:marcaii_flutter/utils/Validation.dart';

class PorcentagemHolder extends StatelessWidget {
  const PorcentagemHolder({
    Key key,
    @required this.porcent,
    @required this.title,
    @required this.iconColor,
    @required this.formKey,
    @required this.onSave,
  }) : super(key: key);

  final GlobalKey<FormState> formKey;
  final int porcent;
  final Color iconColor;
  final String title;
  final Function(int) onSave;

  @override
  Widget build(BuildContext context) {
    return ValidatableListItem(
      formKey: formKey,
      hint: Strings.hintPorc,
      icon: Icon(Icons.move_to_inbox, color: iconColor),
      initValue: porcent.toString(),
      title: title,
      onValidate: _onValidate,
      onSave: _onSave,
    );
  }

  String _onValidate(String e) {
    if (!Validation.isValidPercent(e)) {
      return Warn.warPorcInvalida;
    }

    return null;
  }

  _onSave(String e){
    onSave(int.parse(e));
  }
}