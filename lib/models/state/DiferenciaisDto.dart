class DiferenciaisDto {
  DiferenciaisDto({
    this.id,
    this.idEmprego,
    this.diaSemana,
    this.porcAdicional,
  });

  int id, idEmprego, diaSemana, porcAdicional;

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

  @override toString(){
    return "id: $id, idEmprego: $idEmprego, diaSemana: $diaSemana, porcAdicional: $porcAdicional";
  }
}
