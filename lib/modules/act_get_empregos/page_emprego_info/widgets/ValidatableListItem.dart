import 'package:flutter/material.dart';
import 'package:marcaii_flutter/modules/act_get_empregos/page_emprego_info/widgets/BaseDivider.dart';

class ValidatableListItem extends StatelessWidget {
  const ValidatableListItem({
    Key key,
    @required this.title,
    @required this.hint,
    @required this.initValue,
    @required this.icon,
    @required this.formKey,
    @required this.onValidate,
    @required this.onSave,
  }) : super(key: key);

  final String title, hint, initValue;
  final Icon icon;
  final GlobalKey<FormState> formKey;
  final Function(String) onSave;
  final String Function(String) onValidate;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: TextFormField(
            initialValue: initValue,
            decoration: InputDecoration(
              hintText: hint,
              labelText: title,
            ),
            validator: (t) {
              return onValidate(t);
            },
            onSaved: (e) {
              onSave(e);
            },
          ),
          leading: icon,
        ),
        BaseDivider(),
      ],
    );
  }
}
