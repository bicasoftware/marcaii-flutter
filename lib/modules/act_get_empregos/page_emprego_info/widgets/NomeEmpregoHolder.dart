import 'package:flutter/material.dart';
import 'package:marcaii_flutter/Strings.dart';
import 'package:marcaii_flutter/modules/act_get_empregos/page_emprego_info/widgets/ValidatableListItem.dart';

class NomeEmpregoHolder extends StatelessWidget {
  const NomeEmpregoHolder({
    Key key,
    @required this.nomeEmprego,
    @required this.title,
    @required this.formKey,
    @required this.onSave,
  }) : super(key: key);

  final GlobalKey<FormState> formKey;
  final String nomeEmprego;
  final String title;
  final Function(String) onSave;

  @override
  Widget build(BuildContext context) {
    return ValidatableListItem(
      formKey: formKey,
      hint: Strings.hintEmprego,
      icon: Icons.layers,
      initValue: nomeEmprego,
      title: title,
      onValidate: _onValidate,
      onSave: _onSave,
    );
  }

  String _onValidate(String e) {
    if(e.isEmpty) return Warn.warNomeEmprego;
    return null;
  }

  void _onSave(String e){
    onSave(e);
  }
}