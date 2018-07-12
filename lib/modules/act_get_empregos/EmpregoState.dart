import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marcaii_flutter/models/MdEmpregos.dart';
import 'package:marcaii_flutter/models/PorcDiferDto.dart';
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
    this.valorSalario
  });

  int id, bancoHoras;
  String nomeEmprego;
  String diaFechamento;
  String porcNormal;
  String porcFeriados;
  String cargaHoraria;
  String horarioSaida;
  double valorSalario = 1200.0;

  List<PorcDiferDto> porcList = [
    PorcDiferDto(diaSemana: 0, porcent: 0, valor: 0.0),
    PorcDiferDto(diaSemana: 1, porcent: 0, valor: 0.0),
    PorcDiferDto(diaSemana: 2, porcent: 0, valor: 0.0),
    PorcDiferDto(diaSemana: 3, porcent: 0, valor: 0.0),
    PorcDiferDto(diaSemana: 4, porcent: 0, valor: 0.0),
    PorcDiferDto(diaSemana: 5, porcent: 0, valor: 0.0),
    PorcDiferDto(diaSemana: 6, porcent: 0, valor: 0.0),
  ];

  String get valorSalarioParsed => CurrencyUtils.doubleToCurrency(valorSalario);

  void setNomeEmprego(String nome) {
    nomeEmprego = nome;
    notifyListeners();
  }

  void setDiaFechamento(String dia) {
    diaFechamento = dia;
    notifyListeners();
  }

  void setPorcNormal(String porcNormal) {
    this.porcNormal = porcNormal;
    notifyListeners();
  }

  void setPorcFeriados(String porcFeriados) {
    this.porcFeriados = porcFeriados;
    notifyListeners();
  }

  void setCargaHoraria(String cargaHoraria) {
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

  void setPorcDifer(int weekday, int porc) {
    porcList[weekday].porcent = porc;
    notifyListeners();
  }

  void setBancoHoras(bool selected) {
    this.bancoHoras = selected ? 1 : 0;
    notifyListeners();
  }

  bool isBancoHoras() {
    return this.bancoHoras == 1 ? true : false;
  }

  void clearPorcDifer(int weekDay) {
    porcList[weekDay].clear();
    notifyListeners();
  }

  void toggleBancoHoras() {
    bancoHoras = bancoHoras == 0 ? 1 : 0;
    notifyListeners();
  }

  MdEmpregos provideEmprego() {
    return MdEmpregos(
      id: id,
      nomeEmprego: nomeEmprego,
      bancoHoras: bancoHoras,
      cargaHoraria: cargaHoraria,
      diaFechamento: diaFechamento,
      horarioSaida: horarioSaida,
      porcFeriados: porcFeriados,
      porcNormal: porcNormal,
    );
  }

  ///o formkey deve ser sempre final static
  ///caso não seja, irá gerar uma nova key ao clicar em cada TextInput
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  GlobalKey<FormState> get formKey {
    return _formKey;
  }

  bool isValidated() {
    var form = _formKey.currentState;
    if (form.validate() == true) {
      form.save();
      return true;
    } else {
      return false;
    }
  }
}