import 'package:marcaii_flutter/models/state/DiferenciaisDto.dart';
import 'package:marcaii_flutter/models/state/HoraDto.dart';
import 'package:marcaii_flutter/models/state/SalariosDto.dart';
import 'package:marcaii_flutter/modules/act_get_empregos/EmpregoState.dart';

class EmpregoDto {
  EmpregoDto({
    this.id,
    this.diaFechamento,
    this.porcNormal,
    this.porcFeriados,
    this.bancoHoras,
    this.nomeEmprego,
    this.horarioSaida,
    this.cargaHoraria,
    this.salario,
  });

  int id, diaFechamento, porcNormal, porcFeriados, cargaHoraria;
  bool bancoHoras;
  String nomeEmprego, horarioSaida;
  double salario; //todo - carregar salário atual separadamente

  final listSalarios = List<SalariosDto>();
  final listHoras = List<HoraDto>();
  final listDiferenciais = List<DiferenciaisDto>();

  void appendSalario(SalariosDto salario) {
    //atualiza o valor do salário no model
    this.salario = salario.salario;

    //mapeia todos os salários e seta status como false
    listSalarios.forEach((s) => s.status = false);

    //força status do salário inserido como true
    if (salario.status == false) salario.status = true;

    //adiciona salario na lista
    listSalarios.add(salario);
  }

  void appendPorcDifer(DiferenciaisDto difer) {
    listDiferenciais.add(difer);
  }

  void appendHora(HoraDto hora) {
    listHoras.add(hora);
  }

  EmpregoState toState() {
    return EmpregoState(
      id: id,
      nomeEmprego: nomeEmprego,
      bancoHoras: bancoHoras,
      cargaHoraria: cargaHoraria,
      diaFechamento: diaFechamento,
      horarioSaida: horarioSaida,
      porcFeriados: porcFeriados,
      porcNormal: porcNormal,
      valorSalario: 1200.0, //todo - selecionar salário junto com a query no sqlite
    );
  }

  static EmpregoDto newInstance() {    
    return EmpregoDto(
      nomeEmprego: "Novo Emprego",
      bancoHoras: false,
      cargaHoraria: 220,
      horarioSaida: "18:00",
      porcNormal: 50,
      porcFeriados: 100,
      diaFechamento: 25,
    );
  }
}
