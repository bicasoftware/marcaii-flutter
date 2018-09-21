import 'package:scoped_model/scoped_model.dart';

class PresentationModel extends Model {
  double salario;

  void setSalario(double newSal) {
    salario = newSal;
    notifyListeners();
  }

  int cargaHoraria = 220;

  void setCargaHoraria(int newCargaHoraria) {
    cargaHoraria = newCargaHoraria;
    notifyListeners();
  }

  int pNormal = 50;
  int pCompleta = 100;

  void setPorcNormal(int newPorc) {
    pNormal = newPorc;
    notifyListeners();
  }
  void setPorcCompleta(int newPorc) {
    pCompleta = newPorc;
    notifyListeners();
  }

  String nomeEmprego = "Meu Cargo";

  void setNome(String newNome) {
    nomeEmprego = newNome;
    notifyListeners();
  }

  // static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // GlobalKey<FormState> get formKey {
  //   return _formKey;
  // }

  // bool isValidated() {
  //   final form = formKey.currentState;
  //   if (form.validate() == true) {
  //     form.save();
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }
}
