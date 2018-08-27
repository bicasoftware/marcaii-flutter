import 'package:marcaii_flutter/models/CalendarPageDto.dart';
import 'package:marcaii_flutter/modules/act_get_empregos/ModelEmprego.dart';
import 'package:marcaii_flutter/state/DiferenciaisDto.dart';
import 'package:marcaii_flutter/state/HoraDto.dart';
import 'package:marcaii_flutter/state/SalariosDto.dart';
import 'package:marcaii_flutter/utils/DateUtils.dart';

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
  });

  int id, diaFechamento, porcNormal, porcFeriados, cargaHoraria;
  bool bancoHoras;
  String nomeEmprego, horarioSaida;
  double get salario {
    return listSalarios
        .lastWhere((s) => DateUtils.vigenciaToDate(s.vigencia).isBefore(DateTime.now()))
        .valorSalario;
  }

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
        .firstWhere((it) => it.hora.id == idHora, orElse: null)
        ?.clear();

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
    );

    state.salarios.addAll(listSalarios);

    state.clearAllPorcs();
    for (final dif in listDiferenciais) {
      state.appendPorcDifer(dif.diaSemana, dif.porcAdicional);
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
    )..listSalarios.add(SalariosDto(status: true, valorSalario: 912.77, vigencia: "2010-01"));
  }

  @override
  String toString() {
    return """nomeEmprego $nomeEmprego diaFechamento $diaFechamento porcNormal $porcNormal
    porcFeriados $porcFeriados cargaHoraria $cargaHoraria horarioSaida $horarioSaida bancoHoras""";
  }
}
