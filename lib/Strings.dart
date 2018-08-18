class Strings {
  static const String appName = "Marcaii";
  static const String actGetEmprego = "Empregos";
  static const String actGetHoras = "Hora Extra";
  static const String horaInicial = "Início Extra";
  static const String horaTermino = "Termino Extra";
  static const String horaNormal = "% Normal";
  static const String horaFeriado = "% Completa";
  static const String horaDiferencial = "% Diferencial";
  static const String calendario = "Calendário";
  static const String empregos = "Empregos";
  static const String dadosCargo = "Dados do Cargo";
  static const String diferenciais = "Diferenciais";
  static const String porcentagens = "Porcentagens";
  static const String digiteValor = "Digite o novo valor";
  static const String novaPorcentagem = "Nova porcentagem";
  static const String valorSalario = "Valor Salário";
  static const String valor = "Valor";
  static const String cargaHoraria = "Carga Horária";
  static const String bancoHoras = "Banco de Horas";
  static const String diaFechamento = "Dia Fechamento";
  static const String horarioSaida = "Horário Saída";
  static const String nomeEmprego = "Descrição do cargo";
  static const String hintEmprego = "Ex: Aux. Escritório";
  static const String hintSalario = "1200,00";
  static const String hintHorarioSaida = "18:00";
  static const String hintFechamento = "18:00";
  static const String porcNormal = "Extra Normal";
  static const String hintPorc = "Ex: 30";
  static const String porcFeriados = "Extra Feriados";
  static const String extrasDifer = "Extra Diferencial";
  static const String confirmacao = "Confirmar ação";
  static const String confirmar_remocao_difer = "Deseja remover o valor diferencial?";
  static const String confirmar_remocao_emprego = "Deseja remover o emprego?";
  static const String novo = "Novo";
  static const String verTodos = "Ver totais";
  static const String tipoExtra = "Porcentagem extra: ";

  static const String porcDifer = "% Diferencial";
  static const String titleRelatorioHoras = "Relatórios de Horas";

  static const String cashReal = "R\$";

  static const String salvar = "Salvar";
  static const String cancelar = "Cancelar";
}

class Refs {
  static const String refActGetEmprego = "ACTGETEMPREGO";
  static const String refActRelatorio = "REFACTRELATORIO";
  static const String refActGetHoras = "REFACTGETHORAS";
}

class Warn {
  static const String warNomeEmprego = "Nome requerido";
  static const String warSalarioInvalido = "Salário inválido";
  static const String warPorcInvalida = "Digite um valor maior que 30";
  static const String warFechamento = "O dia deve ser entre 01 e 30";
  static const String warTextApenas = "Apenas letras são permitidas";
  static const String warHorasInvalidas = "Horas inválidas";
}

class Arrays {
  static const cargas = ["220", "200", "180", "150"];
  static const weekDays = ["Domingo", "Segunda", "Terça", "Quarta", "Quinta", "Sexta", "Sábado"];
  static const weekDaysAbrev = ["Dom", "Seg", "Ter", "Qua", "Qui", "Sex", "Sáb"];
  static const opt_salarios = ["Adicionar Aumento", "Ver Todos"];
  static const months = [
    "Janeiro",
    "Fevereiro",
    "Março",
    "Abril",
    "Maio",
    "Junho",
    "Julho",
    "Agosto",
    "Setembro",
    "Outubro",
    "Novembro",
    "Dezembro",
  ];
}

class Exceptions {
  static const recordWithoutOwner = "Record without father ID";
}

class Consts {
  static const horaNormal = "CONST_HORANORMAL";
  static const horaFeriados = "CONST_HORAFERIADOS";
  static const horaDiferencial = "CONST_HORADIFF";
}
