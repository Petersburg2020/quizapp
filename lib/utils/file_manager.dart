import 'dart:io';
import 'package:path_provider/path_provider.dart';

class FileManager {
  final String file;

  FileManager(this.file);


  Future<String> localPath() async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

}