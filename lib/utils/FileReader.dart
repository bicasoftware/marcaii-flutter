import 'dart:async';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class FileReader {
  ///retorna diretorio do Marcaii
  static Future<String> getMarcaiiPath() async {
    final externalDir = await getExternalStorageDirectory();
    return "${externalDir.path}/Marcaii";
  }

  ///força criação da pasta caso inexistente
  static prepareMarcaiiFolder(String marcaiiPath) async {
    await Directory(marcaiiPath).create();
  }

  ///cria arquivo dentro da pasta do app
  static createFile(String fileName, String content, String extension) async {
    final marcaiiPath = await getMarcaiiPath();
    await prepareMarcaiiFolder(marcaiiPath);
    final file = File("$marcaiiPath/$fileName.$extension");
    await file.create();
    await file.writeAsString(content);
  }
}
