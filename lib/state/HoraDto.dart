class HoraDto {
  HoraDto({
    this.id,
    this.idEmprego,
    this.quantidade,
    this.horaInicial,
    this.horaTermino,
    this.dta,
    this.tipoHora,
  });

  int id, idEmprego, quantidade;
  String horaInicial, horaTermino;
  String dta, tipoHora;
}