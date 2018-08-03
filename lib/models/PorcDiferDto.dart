class PorcDiferDto {
  PorcDiferDto({this.id, this.diaSemana, this.porcent, this.valor});

  int id, diaSemana, porcent;
  double valor;

  void clear() {
    id = 0;
    porcent = 0;
    valor = 0.0;
  }
}