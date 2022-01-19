import 'dart:async';
import 'dart:io';

import '../utils.dart';

Future<bool> fileExists(String file) async {
  final f = await getFile(file);
  return f.exists();
}

Future<int> getLineCount(String file) async {
  final lines = await read(file);
  return lines.length;
}

Future<File> getFile(String file) async => File(file);

Future<String> getPath(String file) async {
  final f = await getFile(file);
  return f.path;
}

Future<Directory> getParent(String file) async {
  final f = await getFile(file);
  return f.parent;
}

Future<bool> write(String file, dynamic what) async {
  final f = await getFile(file);
  f.openWrite().write(what);
  final read = await readAsString(file);
  return read == (isString(what) ? what : what.toString());
}

Future<List<String>> read(String file) async {
  final f = await getFile(file);
  return f.readAsLines();
}

Future<String> readAsString(String file) async {
  final f = await getFile(file);
  return f.readAsString();
}

Future<bool> copyFile(String from, String to) async {
  final what = await readAsString(from);
  return write(to, what);
}

Future<bool> deleteFile(String file) async {
  final f = await getFile(file);
  try {
    final result = await f.delete();
    return result != null;
  } on FileSystemException {
    return false;
  }
}
