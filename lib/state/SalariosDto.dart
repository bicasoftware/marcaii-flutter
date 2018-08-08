class SalariosDto {
  SalariosDto({
    this.id,
    this.idEmprego,
    this.salario,
    this.status,
    this.vigencia,
  });

  int id, idEmprego;
  double salario;
  bool status;
  String vigencia;
}