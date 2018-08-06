class PorcDiferDto {
  PorcDiferDto({this.id, this.diaSemana, this.porcent, this.valor});

  int id, diaSemana, porcent;
  double valor;

  void clear() {
    this.id = 0;
    this.porcent = 0;
    this.valor = 0.0;
  }
}