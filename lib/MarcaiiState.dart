import 'package:marcaii_flutter/models/MdEmpregos.dart';
import 'package:scoped_model/scoped_model.dart';

//todo - marcado para remoção
class MarcaiiState extends Model {

  final List<MdEmpregos> _empregos = [
    MdEmpregos(
      id: 1,
      nomeEmprego: "Exemplo 1",
      diaFechamento: 25,
      bancoHoras: 0,
      porcNormal: 50,
      porcFeriados: 100,
      cargaHoraria: 220,
      horarioSaida: "18:00",
    ),
  ];

  List<MdEmpregos> get empregos => _empregos;

  MdEmpregos empregoAt(int pos) => _empregos[pos];

  void appendEmprego(MdEmpregos emprego) {
    _empregos.add(emprego);
    notifyListeners();
  }

/**
 * TODO
 * implementar rotina pedindo acesso ao cartão de memória
 * mostrando dialog com opções de TXT e CSV
 * gerar arquivo no cartão de memória
 * */
}
