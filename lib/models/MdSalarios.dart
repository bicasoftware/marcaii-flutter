class MdSalarios {

    MdSalarios({
        this.id,
        this.idEmprego,
        this.salario,
        this.status,
        this.vigencia
    });

    int id;
    int idEmprego;
    num salario;
    int status;
    String vigencia;

    Map toMap() {
        Map<String, dynamic> map = {
            "idEmprego": idEmprego,
            "salario": salario,
            "status": status,
            "vigencia": vigencia,
        };

        if (id != null) {
            map["id"] = id;
        }

        return map;
    }

    static fromMap(Map sal) {
        return MdSalarios(
            id: sal["id"],
            idEmprego: sal["idEmprego"],
            salario: sal["salario"],
            status: sal["status"],
            vigencia: sal["vigencia"]
        );
    }

    static String createSql() {
        return """
            create table if not exists salarios(
                id integer not null primary key autoincrement,
                idEmprego int not null,
                valorSalario real not null default 0.0,
                status int not null default 0,
                vigencia varchar(10) not null default "2010-01-01"
            )
            """;
    }

}