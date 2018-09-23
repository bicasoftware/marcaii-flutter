import 'dart:async';

import 'package:flutter/material.dart';
import 'package:marcaii_flutter/Strings.dart';
import 'package:marcaii_flutter/models/state/EmpregoDto.dart';
import 'package:marcaii_flutter/modules/presentation/PresentationModel.dart';
import 'package:marcaii_flutter/modules/presentation/pages/PageStepper.dart';
import 'package:marcaii_flutter/modules/presentation/pages/PageWelcome.dart';
import 'package:marcaii_flutter/utils/YesNoDialog.dart';
import 'package:scoped_model/scoped_model.dart';

class ActWelcome extends StatefulWidget {
  final Function(EmpregoDto) onFinished;

  const ActWelcome({Key key, @required this.onFinished}) : super(key: key);

  @override
  ActWelcomeState createState() {
    return new ActWelcomeState();
  }
}

class ActWelcomeState extends State<ActWelcome> with TickerProviderStateMixin {
  PresentationModel model;
  List<Widget> pages = [];
  int _pos;

  Stack stack;

  void initState() {
    super.initState();
    _pos = 0;
    model = PresentationModel();
    pages = <Widget>[
      PageWelcome(onComecar: onComecar),
      PageStepper(onFinish: widget.onFinished),
    ];
  }

  void onComecar() {
    setState(() {
      _pos = 1;
    });
  }

  Future<bool> _willPop() async {
    if (_pos > 0) {
      setState(() => _pos -= 1);
      return false;
    } else {
      return await Dialogs.showConfirmationDialog(
        context: context,
        message: Strings.cancelarConfig,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<PresentationModel>(
      model: model,
      child: WillPopScope(
        onWillPop: _willPop,
        child: Scaffold(
          body: pages[_pos],
        ),
      ),
    );
  }
}
