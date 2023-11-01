import 'dart:io';

import 'package:path_provider/path_provider.dart';

class FileManager {
  static Future saveFile(String fileName, String fileContent) async {
    File file = await _getFile(fileName);
    await file.writeAsString(fileContent);
  }

  static Future<File> _getFile(String fileName) async {
    var documentDir = await getApplicationDocumentsDirectory();
    return File('${documentDir.path}/$fileName');
  }

  static Future<String> getContents(String fileName) async {
    File file = await _getFile(fileName);
    String fileContent = await file.readAsString();
    return fileContent;
  }
}
