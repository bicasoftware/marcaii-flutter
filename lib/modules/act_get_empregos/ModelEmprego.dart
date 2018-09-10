import 'dart:async';

import 'package:flutter/material.dart';
import 'package:marcaii_flutter/models/PorcDiferDto.dart';
import 'package:marcaii_flutter/models/sql/MdEmpregos.dart';
import 'package:marcaii_flutter/models/state/DiferenciaisDto.dart';
import 'package:marcaii_flutter/models/state/EmpregoDto.dart';
import 'package:marcaii_flutter/models/state/SalariosDto.dart';
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
  });

  int id;
  bool bancoHoras;
  String nomeEmprego, horarioSaida;
  int porcNormal, porcFeriados, diaFechamento, cargaHoraria;

  static final List<PorcDiferDto> porcList = [
    PorcDiferDto(id: 0, diaSemana: 0, porcent: 0, valor: 0.0),
    PorcDiferDto(id: 0, diaSemana: 1, porcent: 0, valor: 0.0),
    PorcDiferDto(id: 0, diaSemana: 2, porcent: 0, valor: 0.0),
    PorcDiferDto(id: 0, diaSemana: 3, porcent: 0, valor: 0.0),
    PorcDiferDto(id: 0, diaSemana: 4, porcent: 0, valor: 0.0),
    PorcDiferDto(id: 0, diaSemana: 5, porcent: 0, valor: 0.0),
    PorcDiferDto(id: 0, diaSemana: 6, porcent: 0, valor: 0.0),
  ];

  List<PorcDiferDto> get getPorcList => porcList;
  PorcDiferDto getPorcDiferAt(int weekDay) => porcList[weekDay];

  List<SalariosDto> salarios = [];
  double get valorSalario {
    return salarios.firstWhere((s) => s.status == true, orElse: null).valorSalario ?? 9999.0;
  }

  void updateSalario(double newSalario) {
    salarios.firstWhere((s) => s.status == true).valorSalario = newSalario;
    notifyListeners();
  }

  void appendSalario(String vigencia, double valor) {
    salarios.forEach((s) => s.status = false);
    salarios.add(SalariosDto(
      idEmprego: id,
      vigencia: vigencia,
      valorSalario: valor,
      status: true,
    ));
    notifyListeners();
  }

  void resetSalarios(List<SalariosDto> s) {
    salarios = s;
    notifyListeners();
  }

  void deleteSalario(int pos) {
    salarios.removeAt(pos);
    notifyListeners();
  }

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

  Future appendPorcDifer(int weekday, int porc, {int id: 0}) async {
    porcList[weekday] = PorcDiferDto(
      id: id,
      diaSemana: weekday,
      valor: CurrencyUtils.calcPorcentExtra(valorSalario, cargaHoraria, porc),
      porcent: porc,
    );
  }

  void setPorcDifer(int weekday, int porc, {int id: 0}) {
    porcList[weekday] = PorcDiferDto(
      id: id,
      diaSemana: weekday,
      valor: CurrencyUtils.calcPorcentExtra(valorSalario, cargaHoraria, porc),
      porcent: porc,
    );
    notifyListeners();
  }

  void clearAllPorcs() {
    for (int i = 0; i < 7; i++) {
      porcList[i] = PorcDiferDto(diaSemana: i, porcent: 0, valor: 0.0);
    }
  }

  void clearPorcDifer(int diaSemana) {
    porcList[diaSemana] = PorcDiferDto(id: null, diaSemana: diaSemana, valor: 0.0, porcent: 0);
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

    porcList
        .where((it) => it.porcent != 0)
        .map((it) =>
            DiferenciaisDto(idEmprego: id, diaSemana: it.diaSemana, porcAdicional: it.porcent))
        .forEach((f) => empregoDto.appendPorcDifer(f));

    empregoDto.listSalarios.addAll(salarios);

    return empregoDto;
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
