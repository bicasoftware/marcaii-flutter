import 'package:marcaii_flutter/modules/act_get_empregos/EmpregoState.dart';
import 'package:marcaii_flutter/state/DiferenciaisDto.dart';
import 'package:marcaii_flutter/state/HoraDto.dart';
import 'package:marcaii_flutter/state/SalariosDto.dart';

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
  double salario;

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
    final state = EmpregoState(
      id: id,
      nomeEmprego: nomeEmprego,
      bancoHoras: bancoHoras,
      cargaHoraria: cargaHoraria,
      diaFechamento: diaFechamento,
      horarioSaida: horarioSaida,
      porcFeriados: porcFeriados,
      porcNormal: porcNormal,
      valorSalario: salario ?? 1200.0,
    );

    for (final dif in listDiferenciais) {
      state.setPorcDifer(dif.diaSemana, dif.porcAdicional);
    }

    return state;
  }

  Map toMap() {
    Map<String, dynamic> map = {
      "nomeEmprego": nomeEmprego,
      "diaFechamento": diaFechamento,
      "porcNormal": porcNormal,
      "porcFeriados": porcFeriados,
      "cargaHoraria": cargaHoraria,
      "horarioSaida": horarioSaida,
      "bancoHoras": bancoHoras,
    };

    if (id != null) {
      map["id"] == id;
    }

    return map;
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

  @override
  String toString() {
    return """nomeEmprego $nomeEmprego diaFechamento $diaFechamento porcNormal $porcNormal
    porcFeriados $porcFeriados cargaHoraria $cargaHoraria horarioSaida $horarioSaida bancoHoras""";
  }
}
