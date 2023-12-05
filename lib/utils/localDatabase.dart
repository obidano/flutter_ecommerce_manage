import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:sembast_web/sembast_web.dart';

class LocalDatabase {
  static Future<Database> createDatabase(String filename) async {
    if (!kIsWeb) {
      final appDir = await getApplicationDocumentsDirectory();
      return databaseFactoryIo.openDatabase('${appDir.path}/$filename');
    }
    return databaseFactoryWeb.openDatabase(filename);
  }
}
