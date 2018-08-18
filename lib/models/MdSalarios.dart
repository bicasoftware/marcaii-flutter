class MdSalarios {
  MdSalarios({
    this.id,
    this.idEmprego,
    this.valorSalario,
    this.status,
    this.vigencia,
  });

  int id;
  int idEmprego;
  num valorSalario;
  int status;
  String vigencia;

  static String tableName = "salarios";

  static final cols = ["id", "idEmprego", "valorSalario", "status", "vigencia"];

  Map toMap() {
    Map<String, dynamic> map = {
      "idEmprego": idEmprego,
      "valorSalario": valorSalario,
      "status": status,
      "vigencia": vigencia,
    };

    if (id != null) {
      map["id"] = id;
    }

    return map;
  }

  static MdSalarios fromMap(Map sal) {
    return MdSalarios(
        id: sal["id"],
        idEmprego: sal["idEmprego"],
        valorSalario: sal["valorSalario"],
        status: sal["status"],
        vigencia: sal["vigencia"]);
  }

  static String createSql() {
    return """
      create table if not exists $tableName(
          id integer not null primary key autoincrement,
          idEmprego int not null,
          valorSalario real not null default 0.0,
          status int not null default 0,
          vigencia varchar(10) not null default "2010-01-01"
      )
      """;
  }
}
