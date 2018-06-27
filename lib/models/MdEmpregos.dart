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

    int id;
    String nomeEmprego;
    int diaFechamento;
    int porcNormal;
    int porcFeriados;
    int cargaHoraria;
    String horarioSaida;
    int bancoHoras;

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

    static fromMap(Map emp) {
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

    static String createSql() {
        return """
            create table if not exists empregos(
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