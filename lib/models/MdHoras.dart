import 'package:marcaii_flutter/state/HoraDto.dart';
import 'package:marcaii_flutter/utils/DateUtils.dart';

class MdHoras {
  MdHoras({
    this.id,
    this.idEmprego,
    this.quantidade,
    this.horaInicial,
    this.horaTermino,
    this.dta,
    this.tipoHora,
  });

  int id;
  int idEmprego;
  int quantidade;
  String horaInicial;
  String horaTermino;
  String dta;
  String tipoHora;

  static const tableName = "horas";

  static final cols = [
    "id",
    "idEmprego",
    "quantidade",
    "horaInicial",
    "horaTermino",
    "dta",
    "tipoHora",
  ];

  Map toMap() {
    Map<String, dynamic> map = {
      "idEmprego": idEmprego,
      "quantidade": quantidade,
      "horaInicial": horaInicial,
      "horaTermino": horaTermino,
      "dta": dta,
      "tipoHora": tipoHora,
    };

    if (id != null) {
      map["id"] = id;
    }

    return map;
  }

  HoraDto toDto() {
    return HoraDto(
      id: id,
      horaInicial: DateUtils.hourStrToTimeOfDay(horaInicial),
      horaTermino: DateUtils.hourStrToTimeOfDay(horaTermino),
      dta: dta,
      idEmprego: idEmprego,
      quantidade: quantidade,
      tipoHora: tipoHora,
    );
  }

  static fromMap(Map map) {
    final h = MdHoras();
    h.id = map["id"];
    h.idEmprego = map["idEmprego"];
    h.quantidade = map["quantidade"];
    h.horaInicial = map["horaInicial"];
    h.horaTermino = map["horaTermino"];
    h.dta = map["dta"];
    h.tipoHora = map["tipoHora"];

    return h;
  }

  static String createSql() {
    return """
            create table if not exists $tableName(
                id integer not null primary key autoincrement,
                idEmprego int not null,
                quantidade int not null default 0,
                horaInicial varchar(5) not null default "18:00",
                horaTermino varchar(5) not null default "19:00",
                dta varchar(10) not null default "2010-01-01",
                tipoHora int not null default 0
            )
            """;
  }
}
