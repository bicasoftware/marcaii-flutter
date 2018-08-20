import 'package:marcaii_flutter/models/CalendarPageDto.dart';
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

  CalendarPageDto _currentPage;
  final listSalarios = List<SalariosDto>();
  final listHoras = List<HoraDto>();
  final listDiferenciais = List<DiferenciaisDto>();
  final listCalendarPages = List<CalendarPageDto>();

  CalendarPageDto get currentPage {
    if (_currentPage == null) {
      _currentPage = listCalendarPages[0];
    }

    return _currentPage;
  }

  void setCurrentPage(CalendarPageDto cpage) {
    this._currentPage = cpage;
  }

  void appendSalario(SalariosDto salario) {
    //atualiza o valor do salário no model
    this.salario = salario.valorSalario;

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

  void deleteHora(int idHora) {
    currentPage.cells
        .where((c) => c != null)
        .where((c) => c.hora.id != null)
        .firstWhere((it) => it.hora.id == idHora, orElse: null)?.clear();

    listHoras.removeWhere((h) => h.id == idHora);
  }

  void updateHora(HoraDto hora) {
    final index = listHoras.indexWhere((h) => h.id == hora.id);
    if (index > -1) {
      listHoras[index] = hora;
    }
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
