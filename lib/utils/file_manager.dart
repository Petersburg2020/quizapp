import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class FileManager {
  final String file;

  FileManager(this.file);

  Future<String> readString() async => readAsString(file);
  Future<List<String>> readLines() async => read(file);
  void writeToFile(dynamic what) async => write(file, what);
  Future<File> getFile() async => getFutureFile(file);
  Future<String> getPath() async => getFuturePath(file);
  Future<Directory> getParent() async => getFutureParent(file);
  Future<bool> exists() async => fileExists(file);
  Future<int> lineCount() async => getLineCount(file);

}

Future<bool> fileExists(String file) async {
  final f = await getFutureFile(file);
  return f.exists();
}

Future<int> getLineCount(String file) async {
  final lines = await read(file);
  return lines.length;
}

Future<String> get localPath async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

Future<File> localFile(String fileName) async => getFutureFile('$localPath/$fileName');

Future<File> getFutureFile(String file) async => File(file);

Future<String> getFuturePath(String file) async {
  final f = await getFutureFile(file);
  return f.path;
}

Future<Directory> getFutureParent(String file) async {
  final f = await getFutureFile(file);
  return f.parent;
}

Future<File> getAssetsFile(String file) async {
  final byteData = await rootBundle.load('assets/$file');
  final temp = File('${((await getTemporaryDirectory()).path)}/$file');
  await temp.writeAsBytes(byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
  return temp;
}

Future<String> readAssetsFile(String file) async => readAsString((await getAssetsFile(file)).path);

void write(String file, dynamic what) async {
  final f = await getFutureFile(file);
  f.openWrite().write(what);
}

Future<List<String>> read(String file) async {
  final f = await getFutureFile(file);
  return f.readAsLines();
}

Future<String> readAsString(String file) async {
  final f = await getFutureFile(file);
  print(f.toString());
  return f.readAsString();
}

void copyFile(String from, String to) async {
  final what = await readAsString(from);
  write(to, what);
}
