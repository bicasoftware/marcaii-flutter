import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:marcaii_flutter/Strings.dart';
import 'package:marcaii_flutter/models/state/EmpregoDto.dart';
import 'package:marcaii_flutter/models/state/SalariosDto.dart';
import 'package:marcaii_flutter/modules/presentation/PresentationModel.dart';
import 'package:marcaii_flutter/utils/Formatting.dart';
import 'package:scoped_model/scoped_model.dart';

class PageStepper extends StatefulWidget {
  final Function(EmpregoDto) onFinish;

  const PageStepper({Key key, @required this.onFinish}) : super(key: key);

  @override
  PageStepperState createState() {
    return new PageStepperState();
  }
}

class PageStepperState extends State<PageStepper> {
  int _currentStep, _prevStep;
  int stepsLength = 4;
  MoneyMaskedTextController controller;
  static final salFormKey = GlobalKey<FormState>();
  static final porcFormKey = GlobalKey<FormState>();
  static final nomeFormKey = GlobalKey<FormState>();

  void doFinish(PresentationModel model) {
    final empregoDto = EmpregoDto(
      cargaHoraria: model.cargaHoraria,
      nomeEmprego: model.nomeEmprego,
      bancoHoras: false,
      diaFechamento: 25,
      horarioSaida: "18:00",
      porcNormal: model.pNormal,
      porcFeriados: model.pCompleta,
    );

    empregoDto.listSalarios.add(
      SalariosDto(
        vigencia: Consts.defaultVigencia,
        status: true,
        valorSalario: model.salario,
      ),
    );

    widget.onFinish(empregoDto);
  }

  void initState() {
    _currentStep = 0;
    _prevStep = 0;
    super.initState();
  }

  void _cancelStepper() {
    setState(() => _currentStep = _currentStep > 0 ? _currentStep - 1 : 0);
  }

  void _continueStepper(BuildContext context, PresentationModel model) {
    switch (_currentStep) {
      case 0:
        _validateSalario() ? _gotoNextStep() : _showSnack(context, Warn.warSalarioInvalido);
        break;
      case 1:
        _gotoNextStep();
        break;
      case 2:
        _validatePorcentagem() ? _gotoNextStep() : _showSnack(context, Warn.warPorcInvalida);
        break;
      case 3:
        if (_validateNome()) {
          doFinish(model);
        }
        break;
      default:
    }
  }

  void _gotoNextStep() {
    setState(() {
      _currentStep = _currentStep < stepsLength - 1 ? _currentStep + 1 : _currentStep = 0;
    });
  }

  void _showSnack(BuildContext context, String message) {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void _stepTapped(int step) {
    switch (_prevStep) {
      case 0:
        final state = salFormKey.currentState;
        if (state.validate()) {
          state.save();
          _prevStep = step;
          setState(() => _currentStep = step);
        }
        break;
      case 1:
        _prevStep = step;
        setState(() => _currentStep = step);
        break;
      case 2:
        final state = porcFormKey.currentState;
        if (state.validate()) {
          state.save();
          _prevStep = step;
          setState(() => _currentStep = step);
        }
        break;
      case 3:
        final state = nomeFormKey.currentState;
        if (state.validate()) {
          state.save();
          _prevStep = step;
          setState(() => _currentStep = step);
        }
        break;
      default:
    }
  }

  bool _validateAndSave(FormState currentState) {
    if (currentState.validate()) {
      currentState.save();
      return true;
    }

    return false;
  }

  bool _validateSalario() => _validateAndSave(salFormKey.currentState);

  bool _validatePorcentagem() => _validateAndSave(porcFormKey.currentState);

  bool _validateNome() => _validateAndSave(nomeFormKey.currentState);

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<PresentationModel>(
      rebuildOnChange: true,
      builder: (context, child, model) {
        return Container(
          margin: EdgeInsets.all(8.0),
          child: Stepper(
            type: StepperType.vertical,
            currentStep: _currentStep,
            onStepCancel: _cancelStepper,
            onStepContinue: () => _continueStepper(context, model),
            onStepTapped: _stepTapped,
            steps: <Step>[
              Step(
                title: Text(Strings.salario),
                subtitle: Text(Strings.welcomeSalario),
                isActive: true,
                content: _salarioStep(model),
              ),
              Step(
                title: Text(Strings.cargaHoraria),
                subtitle: Text(Strings.welcomeCargaHoraria),
                isActive: true,
                content: _cargaHorariaStepper(model),
              ),
              Step(
                title: Text(Strings.porcentagens),
                subtitle: Text(Strings.welcomePorcentagens),
                isActive: true,
                content: _porcentagensStepper(model),
              ),
              Step(
                title: Text(Strings.nomeEmprego),
                subtitle: Text(Strings.welcomeNomeEmprego),
                isActive: true,
                content: _cargoStepper(model),
              )
            ],
          ),
        );
      },
    );
  }

  Widget _salarioStep(PresentationModel model) {
    controller = Formatting.defaultMoneyMask(model.salario ?? 1200.0);
    return Form(
      key: salFormKey,
      child: ListTile(
        title: TextFormField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: Strings.valorSalario,
            labelText: Strings.valorSalario,
          ),
          validator: (s) => controller.numberValue <= 0 ? Warn.warSalarioInvalido : null,
          onSaved: (s) => model.setSalario(controller.numberValue),
        ),
      ),
    );
  }

  Widget _cargaHorariaStepper(PresentationModel model) {
    return Row(
      children: <Widget>[
        Expanded(
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
              value: model.cargaHoraria,
              onChanged: (int c) {
                model.setCargaHoraria(c);
              },
              items: Arrays.cargas
                  .map((c) => int.parse(c))
                  .map((c) => DropdownMenuItem(child: Text("$c"), value: c))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _porcentagensStepper(PresentationModel model) {
    return Form(
      key: porcFormKey,
      child: Column(
        children: <Widget>[
          Text(
            Strings.welcomePorcentagensHint,
            textAlign: TextAlign.justify,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 11.0,
            ),
          ),
          TextFormField(
            initialValue: model.pNormal.toString(),
            autofocus: true,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: Strings.porcNormal,
              hintText: Strings.porcNormal,
            ),
            validator: (v) => !Formatting.isValidPercent(v) ? Warn.warPorcInvalida : null,
            onSaved: (s) => model.setPorcNormal(int.parse(s)),
          ),
          Divider(),
          TextFormField(
            initialValue: model.pCompleta.toString(),
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: Strings.porcFeriados,
              hintText: Strings.porcFeriados,
            ),
            validator: (v) => !Formatting.isValidPercent(v) ? Warn.warPorcInvalida : null,
            onSaved: (s) => model.setPorcCompleta(int.parse(s)),
          ),
        ],
      ),
    );
  }

  Widget _cargoStepper(PresentationModel model) {
    return Form(
      key: nomeFormKey,
      child: TextFormField(
        initialValue: model.nomeEmprego,
        textCapitalization: TextCapitalization.words,
        decoration: InputDecoration(labelText: "Descrição"),
        validator: (s) => s == null || s.isEmpty ? Warn.warNomeEmprego : null,
        onSaved: (s) => model.setNome(s),
      ),
    );
  }
}
