export 'file/file_manager.dart';
export 'file/json_manager.dart';
export 'models/models.dart';
export 'dart:convert';
export 'math.dart';
export 'thread.dart';
export 'random.dart';
export 'timer.dart';
export 'exceptions/exceptions.dart';



String getString(List<String> list) {
  var lines = '';
  var count = 0;
  for (var line in list) {
    lines += line + (count < list.length ? '\n' : '');
    count++;
  }
  return lines;
}

String tabs(int count) => '\t' * count;

const String NUMBERS = '0123456789';

int toInt(String num) {
  if (num == null) return null;
  switch (num) {
    case '0': return 0;
    case '1': return 1;
    case '2': return 2;
    case '3': return 3;
    case '4': return 4;
    case '5': return 5;
    case '6': return 6;
    case '7': return 7;
    case '8': return 8;
    case '9': return 9;
    default: return null;
  }
}

int currentTimeMillis() => DateTime.now().millisecond;

int currentTimeInSec() => DateTime.now().second;

int letterCount(String literal, String letter) => literal.contains(letter) ? literal.split(letter).length - 1 : 0;
