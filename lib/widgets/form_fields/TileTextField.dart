import 'package:flutter/material.dart';
import 'package:marcaii_flutter/widgets/BaseDivider.dart';

class TileTextField extends FormField<String> {
  TileTextField({
    String hintText,
    String labelText,
    FormFieldSetter<String> onSaved,
    FormFieldValidator validator,
    String initialValue = "",
    bool autoValidate = false,
    bool showDivider = false,
  }): super(
    onSaved: onSaved,
    validator: validator,
    initialValue: initialValue,
    autovalidate: autoValidate,
    builder: (FormFieldState<String> state){
      return Column(
      children: <Widget>[
        ListTile(
          title: TextFormField(
            initialValue: initialValue,
            decoration: InputDecoration(
              hintText: hintText,
              labelText: labelText,
            ),
            validator: validator,
            onSaved: onSaved,
          ),
          leading: Icon(Icons.edit, color: Colors.black54,),
        ),
        showDivider == false ? BaseDivider() : Container(),
      ],
    );
    }
  );
}