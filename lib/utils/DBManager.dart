import 'dart:async';

import 'package:marcaii_flutter/Strings.dart';
import 'package:marcaii_flutter/models/MdEmpregos.dart';
import 'package:marcaii_flutter/models/MdHoras.dart';
import 'package:marcaii_flutter/models/MdPorcDifer.dart';
import 'package:marcaii_flutter/models/MdSalarios.dart';
import 'package:marcaii_flutter/state/EmpregoDto.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBManager {
  static const String _DBNAME = "marcaii_flutter";
  static const int _VERSION = 1;
  Database _db;

  Future<Database> getInstance() async {
    if (_db == null) {
      print("db is null");
      create();
    }

    return _db;
  }

  Future<Database> create() async {
    var path = await getApplicationDocumentsDirectory();
    var dbPath = join(path.path, _DBNAME);

    _db = await openDatabase(dbPath, version: _VERSION, onCreate: this._createTables);
    return _db;
  }

  Future _createTables(Database db, int version) async {
    await _createEmprego(db);
    await _createHoras(db);
    await _createSalarios(db);
    await _createPorcentagemDifer(db);
  }

  Future closeDb() => _db.close();

  Future _createEmprego(Database db) async {
    return await db.execute(MdEmpregos.createSql());
  }

  Future _createSalarios(Database db) async {
    return await db.execute(MdSalarios.createSql());
  }

  Future _createHoras(Database db) async {
    return await db.execute(MdHoras.createSql());
  }

  Future _createPorcentagemDifer(Database db) async {
    return await db.execute(MdPorcDifer.createSql());
  }

  ///insere emprego e porcentagens diferenciais
  Future insertEmprego(EmpregoDto emprego) async {
    if (emprego.id == null) {
      emprego.id = await _db.insert(MdEmpregos.tableName, emprego.toMap());

      for (final d in emprego.listDiferenciais) {
        d.idEmprego = emprego.id;
        d.id = await _db.insert(MdPorcDifer.tableName, d.toMap());
      }

      emprego.listDiferenciais.forEach((it) => print(it.toString()));

      return emprego;
    }
  }

  ///atualiza emprego, dropa todas as diferencias do emprego e recria
  Future updateEmprego(EmpregoDto emprego) async {
    if (emprego.id != null) {
      await _db.update(
        MdEmpregos.tableName,
        emprego.toMap(),
        where: "id = ?",
        whereArgs: [emprego.id],
      );
      await dropPorcDiferByIdEmprego(emprego.id);

      for (final d in emprego.listDiferenciais) {
        d.idEmprego = emprego.id;
        d.id = await _db.insert(MdPorcDifer.tableName, d.toMap());
      }

      return emprego;
    }
  }

  Future deleteEmprego(int idEmprego) async {
    final modified = await _db.delete(
      MdEmpregos.tableName,
      where: "id = ?",
      whereArgs: [idEmprego],
    );
    
    return modified > 0;
  }

  ///deleta todas as porcentagens diferenciais do emprego
  Future dropPorcDiferByIdEmprego(int idEmprego) async {
    _db.delete(MdPorcDifer.tableName, where: "idemprego = ?", whereArgs: [idEmprego]);
  }

  ///todo - remover após remover o método doOnFirstRun
  Future upsertPorcDifer(MdPorcDifer pd) async {
    if (pd.id == null) {
      pd.id = await _db.insert(MdPorcDifer.tableName, pd.toMap());
      return pd;
    } else {
      var map = pd.toMap();
      await _db.update("porcentagemdifer", map, where: "id = ?", whereArgs: [pd.id]);
    }

    return pd;
  }

  Future upsertSalario(MdSalarios salario) async {
    if (salario.idEmprego == null) {
      throw Exception(Exceptions.recordWithoutOwner);
    }

    if (salario.id == null) {
      //atualiza todos os salários do emprego como inativos

      // await _db.execute(
      //   "update salarios(ativo) values (0) where idemprego = ?",
      //   [salario.idEmprego],
      // );

      await _db.update(
        MdSalarios.tableName,
        salario.toMap(),
        where: "idemprego = ?",
        whereArgs: [salario.idEmprego],
      );

      // await _db.execute(
      //   "update salarios(status) values (0) where idemprego = ${salario.idEmprego}",
      // );
      //e insere o novo salário como ativo
      salario.id = await _db.insert(MdSalarios.tableName, salario.toMap());
      return salario;
    } else {
      _db.update(MdSalarios.tableName, salario.toMap());
    }
  }

  Future<MdHoras> upsertHora(MdHoras hora) async {
    if (hora.id == null) {
      hora.id = await _db.insert(MdHoras.tableName, hora.toMap());
    } else {
      await _db.update("horas", hora.toMap(), where: "id = ?", whereArgs: [hora.id]);
    }

    return hora;
  }

  fetchAllEmpregos() async {
    List<Map> result = await _db.query(MdEmpregos.tableName, columns: MdEmpregos.cols);
    return result.map((emprego) => MdEmpregos.fromMap(emprego)).toList();
  }

  fetchHorasByEmprego(int idEmprego) async {
    List<Map> result = await _db.query(
      MdHoras.tableName,
      columns: MdHoras.cols,
      where: "idemprego = ?",
      whereArgs: [idEmprego],
    );
    return result.map((it) => MdHoras.fromMap(it)).toList();
  }

  fetchPorcentagensDiferByEmprego(int idEmprego) async {
    List<Map> result = await _db.query(
      MdPorcDifer.tableName,
      columns: MdPorcDifer.cols,
      where: "idemprego = ?",
      whereArgs: [idEmprego],
    );
    return result.map((porc) => MdPorcDifer.fromMap(porc)).toList();
  }

  fetchSalariosByEmprego(int idEmprego) async {
    final result = await _db.query(
      MdSalarios.tableName,
      columns: MdSalarios.cols,
      where: "idemprego = ?",
      whereArgs: [idEmprego],
    );
    return result.map((salario) => MdSalarios.fromMap(salario)).toList();
  }
}

/**
 * _lerHoras() async {
  var man = DBManager();
  await man.create();
  var horas = await man.fetchAllHoras();
  horas.forEach((hora) => print(hora.horaTermino));
  }

  _insertHora() async {
  var h = MdHoras(
  idEmprego: 1,
  horaInicial: "18:00",
  horaTermino: "19:00",
  dta: "2018-06-20",
  quantidade: 60,
  tipoHora: 1,
  );

  try {
  var man = DBManager();
  await man.create();
  h = await man.upsertHora(h);
  man.closeDb();
  print("inserido: ${h.id}");
  } catch (e) {
  print(e);
  }
  }

  _insertPorcDifer() async {
  var pd = MdPorcDifer(diaSemana: 1, porcAdicional: 200, idEmprego: 1);
  try {
  var man = DBManager();
  await man.create();
  pd = await man.upsertPorcDifer(pd);
  man.closeDb();
  print("added ${pd.id}");
  } catch (e) {
  print(e);
  }
  }
 * */
