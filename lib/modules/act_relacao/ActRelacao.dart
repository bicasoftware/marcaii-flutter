import 'package:flutter/material.dart';
import 'package:marcaii_flutter/modules/act_relacao/ModelRelacao.dart';
import 'package:marcaii_flutter/modules/act_relacao/ViewRelacao.dart';
import 'package:scoped_model/scoped_model.dart';

class ActRelacao extends StatelessWidget {
  ActRelacao({Key key, @required this.model}) : super(key: key);

  final ModelRelacao model;

  @override
  Widget build(BuildContext context) {
    return ScopedModel<ModelRelacao>(
      model: model,
      child: ViewRelacao(),
    );
  }
}
