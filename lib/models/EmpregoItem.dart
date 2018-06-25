class EmpregoItemDto {
    var nomeEmprego = "";
    var valorSalario = 0.0;
    var cargaHoraria = 220;
    var horarioSaida = "18:00";
    var diaFechamento = 25;

    EmpregoItemDto({
        this.nomeEmprego,
        this.valorSalario,
        this.cargaHoraria,
        this.diaFechamento,
        this.horarioSaida
    });

}