import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marcaii_flutter/models/MdEmpregos.dart';
import 'package:marcaii_flutter/models/PorcDiferDto.dart';
import 'package:marcaii_flutter/models/state/DiferenciaisDto.dart';
import 'package:marcaii_flutter/models/state/EmpregoDto.dart';
import 'package:marcaii_flutter/utils/CurrencyUtils.dart';
import 'package:scoped_model/scoped_model.dart';

class EmpregoState extends Model {
  EmpregoState({
    this.id,
    this.nomeEmprego,
    this.bancoHoras,
    this.cargaHoraria,
    this.diaFechamento,
    this.horarioSaida,
    this.porcNormal,
    this.porcFeriados,
    this.valorSalario,
  });

  int id;
  bool bancoHoras;
  String nomeEmprego, horarioSaida;
  int porcNormal, porcFeriados, diaFechamento, cargaHoraria;
  double valorSalario = 1200.0;

  bool needUdpate = false;

  final List<PorcDiferDto> porcList = [
    PorcDiferDto(id: 0, diaSemana: 0, porcent: 0, valor: 0.0),
    PorcDiferDto(id: 0, diaSemana: 1, porcent: 0, valor: 0.0),
    PorcDiferDto(id: 0, diaSemana: 2, porcent: 0, valor: 0.0),
    PorcDiferDto(id: 0, diaSemana: 3, porcent: 0, valor: 0.0),
    PorcDiferDto(id: 0, diaSemana: 4, porcent: 0, valor: 0.0),
    PorcDiferDto(id: 0, diaSemana: 5, porcent: 0, valor: 0.0),
    PorcDiferDto(id: 0, diaSemana: 6, porcent: 0, valor: 0.0),
  ];

  PorcDiferDto getPorcDiferAt(int weekDay) => porcList[weekDay];

  String get valorSalarioParsed => CurrencyUtils.doubleToCurrency(valorSalario);

  void setNomeEmprego(String nome) {
    nomeEmprego = nome;
    notifyListeners();
  }

  void setDiaFechamento(int dia) {
    diaFechamento = dia;
    notifyListeners();
  }

  void setPorcNormal(int porc) {
    this.porcNormal = porc;
    notifyListeners();
  }

  void setPorcFeriados(int porc) {
    this.porcFeriados = porc;
    notifyListeners();
  }

  void setCargaHoraria(int cargaHoraria) {
    this.cargaHoraria = cargaHoraria;
    notifyListeners();
  }

  void setHorarioSaida(String horarioSaida) {
    this.horarioSaida = horarioSaida;
    notifyListeners();
  }

  void setValorSalario(double valorSalario) {
    this.valorSalario = valorSalario;
    notifyListeners();
  }

  void setPorcDifer(int weekday, int porc, {int id: 0}) {
    porcList[weekday]
      ..porcent = porc
      ..valor = CurrencyUtils.calcPorcentExtra(valorSalario, cargaHoraria, porc)
      ..id = id;

    notifyListeners();
  }

  void clearAllPorcs(){
    porcList.forEach((it) => it.clear());
  }

  void clearPorcDifer(int weekDay) {
    porcList[weekDay].clear();
    notifyListeners();
  }

  void setBancoHoras(bool selected) {
    this.bancoHoras = selected;
    notifyListeners();
  }

  bool isBancoHoras() {
    return this.bancoHoras;
  }

  void toggleBancoHoras() {
    bancoHoras = bancoHoras;
    notifyListeners();
  }

  int get getPorcNormal => porcNormal;

  int get getPorcFeriados => porcFeriados;

  EmpregoDto provideResult() {
    final empregoDto = EmpregoDto(
      id: id,
      nomeEmprego: nomeEmprego,
      bancoHoras: bancoHoras,
      cargaHoraria: cargaHoraria,
      diaFechamento: diaFechamento,
      horarioSaida: horarioSaida,
      porcFeriados: porcFeriados,
      porcNormal: porcNormal,
    );

    try {
      porcList
          .where((it) => it.porcent != 0)
          .map((it) =>
              DiferenciaisDto(idEmprego: id, diaSemana: it.diaSemana, porcAdicional: it.porcent))
          .forEach((f) => empregoDto.appendPorcDifer(f));
    } catch (e) {
      print(e);
    }

    return empregoDto;
    //todo - gerenciar salários aqui
  }

  MdEmpregos provideEmprego() {
    return MdEmpregos(
      id: id,
      nomeEmprego: nomeEmprego,
      bancoHoras: bancoHoras == true ? 1 : 0,
      cargaHoraria: cargaHoraria,
      diaFechamento: diaFechamento,
      horarioSaida: horarioSaida,
      porcFeriados: porcFeriados,
      porcNormal: porcNormal,
    );
  }

  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  GlobalKey<FormState> get formKey {
    return _formKey;
  }

  bool isValidated() {
    final form = formKey.currentState;
    if (form.validate() == true) {
      form.save();
      return true;
    } else {
      return false;
    }
  }
}
