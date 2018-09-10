import 'package:flutter/material.dart';
import 'package:marcaii_flutter/Strings.dart';
import 'package:marcaii_flutter/models/calendar/CalendarPageDto.dart';
import 'package:marcaii_flutter/models/state/DiferenciaisDto.dart';
import 'package:marcaii_flutter/models/state/HoraDto.dart';
import 'package:marcaii_flutter/models/state/RelatorioItemDto.dart';
import 'package:marcaii_flutter/models/state/SalariosDto.dart';
import 'package:marcaii_flutter/modules/act_get_empregos/ModelEmprego.dart';
import 'package:marcaii_flutter/modules/act_relacao/ModelRelacao.dart';
import 'package:marcaii_flutter/utils/CurrencyUtils.dart';
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
    listHoras.removeWhere((HoraDto h) => h.id == idHora);

    currentPage.cells
        .where((c) => c != null)
        .where((c) => c.hora.id != null)
        .firstWhere((it) => it.hora.id == idHora, orElse: null)
        ?.clear();

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

    for (int i = 0; i < 7; i++) {
      final DiferenciaisDto f = listDiferenciais.firstWhere((d) {
        return d.diaSemana == i;
      }, orElse: () {
        return DiferenciaisDto(diaSemana: i, porcAdicional: 0);
      });

      state.appendPorcDifer(f.diaSemana, f.porcAdicional);
    }
    return state;
  }

  ModelRelacao toModelRelacao({mes: int, ano: int}) {
    final vigencia = DateUtils.prepareVigencia(ano, mes + 1, diaFechamento);
    final inicio = vigencia["inicio"];
    final termino = vigencia["termino"];
    List<RelatorioItemDto> items = [];

    final s = listSalarios
        .lastWhere((s) => DateUtils.vigenciaToDate(s.vigencia).isBefore(termino))
        .valorSalario;


    final horasBetween = listHoras.where((h) {
      final dt = h.dta;
      return dt.isAfter(inicio) && dt.isBefore(termino);
    }).toList();

    horasBetween.sort((a, b) => a.dta.compareTo(b.dta));

    horasBetween.forEach((h) {
      items.add(
        RelatorioItemDto(
          inicio: DateUtils.timeOfDayToStr(h.horaInicial),
          termino: DateUtils.timeOfDayToStr(h.horaTermino),
          minutos: DateUtils.minutesBetween(
            init: h.horaInicial,
            end: h.horaTermino,
          ),
          date: h.dta,
          valor: CurrencyUtils.calcPorcentExtra(
            salario,
            cargaHoraria,
            _getPorcentagem(h.tipoHora, h.dta),
          ),
          color: _getColor(h.tipoHora),
        ),
      );
    });

    return ModelRelacao()
      ..mes = mes
      ..inicio = inicio
      ..termino = termino
      ..items = items
      ..salario = s;
  }

  int _getPorcentagem(String tipoHora, DateTime data) {
    if (tipoHora == Consts.horaNormal) {
      return porcNormal;
    } else if (tipoHora == Consts.horaFeriados) {
      return porcFeriados;
    } else if (tipoHora == Consts.horaDiferencial) {
      int d = DateUtils.getCurrentWeekday(data);
      return listDiferenciais.firstWhere((difer) => difer.diaSemana == d).porcAdicional;
    }

    return 1;
  }

  Color _getColor(String tipoHora) {
    if (tipoHora == Consts.horaNormal) {
      return Colors.green;
    } else if (tipoHora == Consts.horaFeriados) {
      return Colors.orange;
    } else if (tipoHora == Consts.horaDiferencial) {
      return Colors.red;
    }

    return Colors.black;
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
      map["id"] = id;
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
