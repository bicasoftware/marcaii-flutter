import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:marcaii_flutter/models/MdEmpregos.dart';
import 'package:marcaii_flutter/models/MdHoras.dart';
import 'package:marcaii_flutter/models/MdSalarios.dart';
import 'package:marcaii_flutter/models/MdPorcDifer.dart';

class DBManager {

    //todo - criar CmdEmpregos e CmdSalarios

    static const String _DBNAME = "marcaii_flutter";
    static const int _VERSION = 1;
    Database _db;

    Future create() async {
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

    Database get getDb => _db;

    Future _createEmprego(Database db) async => await db.execute(MdEmpregos.createSql());

    Future _createSalarios(Database db) async => await db.execute(MdSalarios.createSql());

    Future _createHoras(Database db) async => await db.execute(MdHoras.createSql());

    Future _createPorcentagemDifer(Database db) async => await db.execute(MdPorcDifer.createSql());
}