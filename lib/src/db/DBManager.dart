import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:marcaii_flutter/models/MdEmpregos.dart';
import 'package:marcaii_flutter/models/MdHoras.dart';
import 'package:marcaii_flutter/models/MdSalarios.dart';
import 'package:marcaii_flutter/models/MdPorcDifer.dart';

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

    Future create() async {
        var path = await getApplicationDocumentsDirectory();
        var dbPath = join(path.path, _DBNAME);

        _db = await openDatabase(dbPath,version: _VERSION, onCreate: this._createTables);
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

    Future upsertPorcDifer(MdPorcDifer pd) async {
        if (pd.id == null) {
            pd.id = await _db.insert("porcentagemdifer", pd.toMap());
        } else {
            var map = pd.toMap();
            await _db.update("porcentagemdifer", map, where: "id = ?", whereArgs: [pd.id]);
        }

        return pd;
    }

    Future<MdHoras> upsertHora(MdHoras hora) async {
        if (hora.id == null) {
            hora.id = await _db.insert("horas", hora.toMap());
        } else {
            await _db.update("horas", hora.toMap(), where: "id = ?", whereArgs: [hora.id]);
        }

        return hora;
    }

    Future fetchAllHoras() async {
        List<Map> result = await _db.query("horas", columns: MdHoras.cols);
        return result.map((it) => MdHoras.fromMap(it)).toList();
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
