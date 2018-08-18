class SalariosDto {
  SalariosDto({
    this.id,
    this.idEmprego,
    this.valorSalario,
    this.status,
    this.vigencia,
  });

  int id, idEmprego;
  double valorSalario;
  bool status;
  String vigencia;

  Map toMap() {
    Map<String, dynamic> map = {
      "idEmprego": idEmprego,
      "valorSalario": valorSalario,
      "status": status,
      "vigencia": vigencia,
    };

    if(id != null){
      map["id"] = id;
    }

    return map;
  }
}