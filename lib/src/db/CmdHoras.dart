import 'dart:async';
import 'package:marcaii_flutter/models/MdHoras.dart';
import 'package:sqflite/sqflite.dart';

class CmdHoras {

    static Future<MdHoras> upsertHora(Database db, MdHoras hora) async {
        if (hora.id == null) {
            hora.id = await db.insert("horas", hora.toMap());
        } else {
            await db.update("horas", hora.toMap(), where: "id = ?", whereArgs: [hora.id]);
        }

        return hora;
    }

    static Future<List<MdHoras>> fetchAllHoras(Database db, ) async {
        List<Map> result = await db.query("horas", columns: MdHoras.cols);
        return result.map((it) => MdHoras.fromMap(it)).toList();
    }
}