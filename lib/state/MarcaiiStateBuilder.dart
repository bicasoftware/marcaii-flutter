import 'dart:async';

import 'package:marcaii_flutter/models/calendar/CalendarBuilder.dart';
import 'package:marcaii_flutter/models/sql/MdEmpregos.dart';
import 'package:marcaii_flutter/models/sql/MdHoras.dart';
import 'package:marcaii_flutter/models/sql/MdPorcDifer.dart';
import 'package:marcaii_flutter/models/sql/MdSalarios.dart';
import 'package:marcaii_flutter/models/state/DiferenciaisDto.dart';
import 'package:marcaii_flutter/models/state/EmpregoDto.dart';
import 'package:marcaii_flutter/models/state/HoraDto.dart';
import 'package:marcaii_flutter/models/state/SalariosDto.dart';
import 'package:marcaii_flutter/state/MainState.dart';
import 'package:marcaii_flutter/utils/DBManager.dart';

class MarcaiiStateBuilder {
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
          final List<HoraDto> horasDto = horas.map((h) => h.toDto()).toList();
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

    await Future.delayed(Duration(milliseconds: 500));
    return MainState(DateTime.now(), empregos: listEmpregos);
  }
}
