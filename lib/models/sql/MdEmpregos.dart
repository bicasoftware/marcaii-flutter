import 'package:marcaii_flutter/models/state/EmpregoDto.dart';
import 'package:marcaii_flutter/modules/act_get_empregos/ModelEmprego.dart';

class MdEmpregos {
  MdEmpregos({
    this.id,
    this.nomeEmprego,
    this.diaFechamento,
    this.porcNormal,
    this.porcFeriados,
    this.cargaHoraria,
    this.horarioSaida,
    this.bancoHoras,
  });

  int id, bancoHoras, porcNormal, porcFeriados, diaFechamento, cargaHoraria;
  String nomeEmprego, horarioSaida;

  static const tableName = "empregos";
  static final cols = [
    "id",
    "nomeEmprego",
    "diaFechamento",
    "porcNormal",
    "porcFeriados",
    "cargaHoraria",
    "horarioSaida",
    "bancoHoras",
  ];

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

  static MdEmpregos fromMap(Map emp) {
    return MdEmpregos(
      id: emp["id"],
      nomeEmprego: emp["nomeEmprego"],
      diaFechamento: emp["diaFechamento"],
      porcNormal: emp["porcNormal"],
      porcFeriados: emp["porcFeriados"],
      cargaHoraria: emp["cargaHoraria"],
      horarioSaida: emp["horarioSaida"],
      bancoHoras: emp["bancoHoras"],
    );
  }

  static MdEmpregos getNewInstance() {
    return MdEmpregos(
      nomeEmprego: "Novo Emprego",
      cargaHoraria: 220,
      horarioSaida: "18:00",
      porcNormal: 50,
      porcFeriados: 100,
      diaFechamento: 25,
    );
  }

  EmpregoState toState() {
    print(bancoHoras);
    return EmpregoState(
      id: id,
      nomeEmprego: nomeEmprego,
      bancoHoras: bancoHoras == 0 ? false : true,
      cargaHoraria: cargaHoraria,
      diaFechamento: diaFechamento,
      horarioSaida: horarioSaida,
      porcFeriados: porcFeriados,
      porcNormal: porcNormal,
    );
  }

  EmpregoDto toDto() {
    return EmpregoDto(
      id: this.id,
      diaFechamento: this.diaFechamento,
      porcNormal: this.porcNormal,
      porcFeriados: this.porcFeriados,
      bancoHoras: this.bancoHoras == 0 ? false : true,
      nomeEmprego: this.nomeEmprego,
      horarioSaida: this.horarioSaida,
      cargaHoraria: this.cargaHoraria,
    );
  }

  static String createSql() {
    return """
            create table if not exists $tableName(
                id integer not null primary key autoincrement,
                nomeEmprego varchar(30) not null default "",
                diaFechamento int not null default 25,
                porcNormal int not null default 50,
                porcFeriados int not null default 100,
                cargaHoraria int not null default 220,
                horarioSaida varchar(5) not null default "18:00",
                bancoHoras int not null default 0
            )
            """;
  }
}
