import 'dart:async';

import 'package:flutter/material.dart';
import 'package:marcaii_flutter/models/CalendarPageDto.dart';
import 'package:marcaii_flutter/models/MdHoras.dart';
import 'package:marcaii_flutter/models/MdPorcDifer.dart';
import 'package:marcaii_flutter/models/MdSalarios.dart';
import 'package:marcaii_flutter/state/CalendarBuilder.dart';
import 'package:marcaii_flutter/state/CalendarCellDto.dart';
import 'package:marcaii_flutter/state/DiferenciaisDto.dart';
import 'package:marcaii_flutter/state/EmpregoDto.dart';
import 'package:marcaii_flutter/state/HoraDto.dart';
import 'package:marcaii_flutter/state/MainState.dart';
import 'package:marcaii_flutter/state/SalariosDto.dart';
import 'package:marcaii_flutter/utils/DBManager.dart';
import 'package:marcaii_flutter/utils/DateUtils.dart';

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

      final empregos = await db.fetchAllEmpregos();
      if (empregos.length > 0) {
        for (final emprego in empregos) {
          var empregoDto = EmpregoDto(
            id: emprego.id,
            diaFechamento: emprego.diaFechamento,
            porcNormal: emprego.porcNormal,
            porcFeriados: emprego.porcFeriados,
            bancoHoras: emprego.bancoHoras == 0 ? false : true,
            nomeEmprego: emprego.nomeEmprego,
            horarioSaida: emprego.horarioSaida,
            cargaHoraria: emprego.cargaHoraria,
          );

          List<MdSalarios> salarios = await db.fetchSalariosByEmprego(emprego.id);
          for (MdSalarios salario in salarios) {
            if (salario.status == 1) {
              empregoDto.salario = salario.valorSalario;
            }

            var salarioDto = SalariosDto(
              id: salario.id,
              idEmprego: emprego.id,
              valorSalario: salario.valorSalario,
              status: salario.status == 0 ? false : true,
              vigencia: salario.vigencia,
            );

            empregoDto.listSalarios.add(salarioDto);
          }

          List<MdPorcDifer> porcentagens = await db.fetchPorcentagensDiferByEmprego(emprego.id);
          for (MdPorcDifer porc in porcentagens) {
            final diferenciaDto = DiferenciaisDto(
              id: porc.id,
              idEmprego: emprego.id,
              diaSemana: porc.diaSemana,
              porcAdicional: porc.porcAdicional,
            );

            empregoDto.listDiferenciais.add(diferenciaDto);
          }

          ///Linka horas salvas no banco com os respectivos itens do calendário
          List<MdHoras> horas = await db.fetchHorasByEmprego(emprego.id);
          final cells = CalendarBuilder.buildCalendarByMonth(year, month, emprego.id);
          cells.where((it) => it != null).forEach((CalendarCellDto c) {
            String parsedDate = DateUtils.dateTimeToString(c.date);
            MdHoras hora = horas.firstWhere((h) => h.dta == parsedDate, orElse: () => null);
            if (hora != null) {
              c.hora.copyFrom(hora);
            }
          });

          final currentPage = CalendarPageDto(year: year, month: month, cells: cells);
          empregoDto.listCalendarPages.add(currentPage);
          empregoDto.setCurrentPage(currentPage);

          for (MdHoras hora in horas) {
            var horaDto = HoraDto(
                id: hora.id,
                idEmprego: emprego.id,
                dta: hora.dta,
                horaInicial: DateUtils.hourStrToTimeOfDay(hora.horaInicial),
                horaTermino: DateUtils.hourStrToTimeOfDay(hora.horaTermino),
                quantidade: hora.quantidade,
                tipoHora: hora.tipoHora);

            empregoDto.listHoras.add(horaDto);
          }

          listEmpregos.add(empregoDto);
        }
      }
    } catch (e) {
      print(e);
    }

    return MainState(DateTime.now(), empregos: listEmpregos);
  }
}
