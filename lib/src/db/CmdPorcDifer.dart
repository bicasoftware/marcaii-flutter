import 'dart:async';
import 'package:marcaii_flutter/models/MdPorcDifer.dart';
import 'package:sqflite/sqflite.dart';

class CmdPorcDifer {

    static Future upsertPorcDifer(Database db, MdPorcDifer pd) async {
        if (pd.id == null) {
            pd.id = await db.insert("porcentagemdifer", pd.toMap());
        } else {
            var map = pd.toMap();
            await db.update("porcentagemdifer", map, where: "id = ?", whereArgs: [pd.id]);
        }

        return pd;
    }
}