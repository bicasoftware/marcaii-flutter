class MdPorcDifer {
  int id;
  int idEmprego;
  int diaSemana;
  int porcAdicional;

  MdPorcDifer({this.id, this.idEmprego, this.diaSemana, this.porcAdicional});

  static const tableName = "porcentagemdifer";
  static const cols = [
    "id",
    "idEmprego",
    "diaSemana",
    "porcAdicional",
  ];

  Map toMap() {
    Map<String, dynamic> map = {
      "idEmprego": idEmprego,
      "diaSemana": diaSemana,
      "porcAdicional": porcAdicional
    };

    if (id != null) {
      map["id"] = id;
    }

    return map;
  }

  static fromMap(Map map) {
    return MdPorcDifer(
      id: map["id"],
      idEmprego: map["idEmprego"],
      diaSemana: map["diaSemana"],
      porcAdicional: map["porcAdicional"],
    );
  }

  static String createSql() {
    return """
            create table if not exists porcentagemdifer(
                id integer not null primary key autoincrement,
                idEmprego int not null,
                diaSemana int not null default 0,
                porcAdicional int not null default 0
            )
            """;
  }
}
