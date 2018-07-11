class PorcDiferDto {
  PorcDiferDto({this.diaSemana, this.porcent, this.valor});

  int diaSemana, porcent;
  double valor;

  void clear() {
    porcent = 0;
    valor = 0.0;
  }
}