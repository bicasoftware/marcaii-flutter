//criar classe que exibe dialog para pegar integers

import 'package:flutter/material.dart';
import 'package:marcaii_flutter/Strings.dart';
import 'package:marcaii_flutter/dialogs/IntPicker.dart';
import 'package:marcaii_flutter/modules/act_get_empregos/Styles.dart';
import 'package:marcaii_flutter/widgets/BaseDivider.dart';

class IntPickerTile extends FormField<int> {
  IntPickerTile({
    int initialValue = 0,
    int min = 0,
    int max = 100,
    @required BuildContext context,
    @required String hintText,
    @required String labelText,
    @required Function(num) onNumberSelected,
    @required FormFieldSetter<int> onSaved,
    @required FormFieldValidator<int> validator,
    IconData icon: Icons.calendar_today,
    bool autoValidate = false,
    bool showDivider = false,
  }) : super(
          onSaved: onSaved,
          validator: validator,
          autovalidate: autoValidate,
          initialValue: initialValue,
          builder: (FormFieldState<int> state) {
            return Column(
              children: <Widget>[
                GestureDetector(
                  onTap: () async {
                    final newValue = await IntPicker.showIntPicker(
                      min: min,
                      max: max,
                      context: context,
                      initValue: initialValue,
                    );

                    if (newValue != null && newValue != initialValue) {
                      state.didChange(newValue);
                      onNumberSelected(newValue);
                    }
                  },
                  child: ListTile(
                    leading: Icon(
                      icon,
                      color: Colors.black54,
                    ),
                    title: Text(
                      hintText,
                      style: Styles.getListTitleStyle(context),
                    ),
                    trailing: Text(
                      state.value.toString(),
                      style: Styles.getListSubtitleStyle(context),
                    ),
                    subtitle: state.hasError
                        ? Row(
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  Warn.warDiaInvalido,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      color: Theme.of(context).errorColor, fontSize: 12.0),
                                ),
                              )
                            ],
                          )
                        : null,
                  ),
                ),
                showDivider ? BaseDivider() : Container(),
              ],
            );
          },
        );
}
