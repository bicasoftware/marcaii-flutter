import 'package:flutter/material.dart';
import 'package:marcaii_flutter/widgets/BaseDivider.dart';

//todo - Migrar

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
    this.isLast: false,
  }) : super(key: key);

  final String title, hint, initValue;
  final IconData icon;
  final GlobalKey<FormState> formKey;
  final Function(String) onSave;
  final String Function(String) onValidate;
  final bool isLast;

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
          leading: Icon(icon, color: Colors.black54,),
        ),
        isLast == false ? BaseDivider() : Container(),
      ],
    );
  }
}
