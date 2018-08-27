import 'dart:async';

import 'package:flutter/material.dart';
import 'package:marcaii_flutter/models/MdEmpregos.dart';
import 'package:marcaii_flutter/models/MdHoras.dart';
import 'package:marcaii_flutter/models/MdPorcDifer.dart';
import 'package:marcaii_flutter/models/MdSalarios.dart';
import 'package:marcaii_flutter/state/CalendarBuilder.dart';
import 'package:marcaii_flutter/state/DiferenciaisDto.dart';
import 'package:marcaii_flutter/state/EmpregoDto.dart';
import 'package:marcaii_flutter/state/HoraDto.dart';
import 'package:marcaii_flutter/state/MainState.dart';
import 'package:marcaii_flutter/state/SalariosDto.dart';
import 'package:marcaii_flutter/utils/DBManager.dart';

class MarcaiiStateBuilder {
  static void doOnFirstRun() async {
    final db = DBManager();
    await db.create();

    var emprego = EmpregoDto(
      nomeEmprego: "Analista Show",
      cargaHoraria: 220,
      bancoHoras: false,
      diaFechamento: 25,
      horarioSaida: "18:00",
      porcFeriados: 100,
      porcNormal: 50,
    );

    final porc1 = MdPorcDifer(
      diaSemana: 0,
      porcAdicional: 120,
    );

    final porc2 = MdPorcDifer(
      diaSemana: 6,
      porcAdicional: 110,
    );

    final salario = SalariosDto(
      valorSalario: 1365.0,
      status: true,
      vigencia: "2018-01",
    );

    final hora1 = HoraDto(
      dta: "2018-07-01",
      horaInicial: TimeOfDay(hour: 18, minute: 00),
      horaTermino: TimeOfDay(hour: 18, minute: 00),
      quantidade: 60,
      tipoHora: "CONST_HORANORMAL",
    );

    try {
      emprego = await db.insertEmprego(emprego);
      if (emprego.id != null) {
        salario.idEmprego = emprego.id;
        hora1.idEmprego = emprego.id;
        porc1.idEmprego = emprego.id;
        porc2.idEmprego = emprego.id;
      }

      db.upsertHora(hora1);
      db.upsertPorcDifer(porc1);
      db.upsertPorcDifer(porc2);
      db.upsertSalario(salario);
    } catch (e) {
      print(e);
    }
  }

  static Future<MainState> buildState() async {
    final db = DBManager();
    final listEmpregos = List<EmpregoDto>();
    final date = DateTime.now();
    final year = date.year;
    final month = date.month;

    try {
      await db.create();

      final List<MdEmpregos> empregos = await db.fetchAllEmpregos();
      if (empregos.length > 0) {
        for (final emprego in empregos) {
          var empregoDto = emprego.toDto();

          List<MdSalarios> salarios = await db.fetchSalariosByEmprego(emprego.id);
          final List<SalariosDto> salariosDto = salarios.map((s) => s.toDto()).toList();
          empregoDto.listSalarios.addAll(salariosDto);

          List<MdPorcDifer> porcentagens = await db.fetchPorcentagensDiferByEmprego(emprego.id);
          final List<DiferenciaisDto> diferenciaisDto = porcentagens.map((d) => d.toDto()).toList();
          empregoDto.listDiferenciais.addAll(diferenciaisDto);

          ///Linka horas salvas no banco com os respectivos itens do calendário
          List<MdHoras> horas = await db.fetchHorasByEmprego(emprego.id);
          final List<HoraDto> horasDto = horas.map((h)=> h.toDto()).toList();
          final currentPage = CalendarBuilder.buildPageAndBind(
            horas: horasDto,
            month: month,
            year: year,
            idEmprego: emprego.id,
          );
          empregoDto.listCalendarPages.add(currentPage);
          empregoDto.setCurrentPage(currentPage);

          empregoDto.listHoras.addAll(horasDto);

          listEmpregos.add(empregoDto);
        }
      }
    } catch (e) {
      print(e);
    }

    return MainState(DateTime.now(), empregos: listEmpregos);
  }

  // static CalendarPageDto getCalendarPage({
  //   int idEmprego,
  //   year: int,
  //   month: int,
  //   List<MdHoras> horas,
  // }) {
  //   final cells = CalendarBuilder.buildCalendarByMonth(year, month, idEmprego);
  //   cells.where((it) => it != null).forEach((CalendarCellDto c) {
  //     String parsedDate = DateUtils.dateTimeToString(c.date);
  //     MdHoras hora = horas.firstWhere((h) => h.dta == parsedDate, orElse: () => null);
  //     if (hora != null) {
  //       c.hora.copyFrom(hora);
  //     }
  //   });

  //   return CalendarPageDto(year: year, month: month, cells: cells);
  // }
}
