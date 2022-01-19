export 'json/json_array.dart';
export 'json/json_object.dart';
export 'json/json_base.dart';
export 'json/json_reader.dart';
export 'json/json_writer.dart';

import '../utils.dart';

bool isArray(dynamic value) =>
    value != null && value.runtimeType.toString().startsWith('List');

bool isObject(dynamic value) =>
    value != null &&
    (value.runtimeType.toString().startsWith('_InternalLinkedHashMap') ||
        value.runtimeType.toString().startsWith('_HashMap') ||
        value.runtimeType.toString().startsWith('SplayTreeMap'));

bool isString(dynamic value) =>
    value != null && value.runtimeType == ''.runtimeType;

bool isInt(dynamic value) =>
    value != null && value.runtimeType == 0.runtimeType;

bool isDouble(dynamic value) =>
    value != null && value.runtimeType == 0.0.runtimeType;

bool isBool(dynamic value) =>
    value != null && value.runtimeType == false.runtimeType;

Future<JsonArray> arrayFromFile(String fileName) async {
  final lines = await readAsString(fileName);
  return JsonArray.fromText(lines);
}

Future<JsonObject> objectFromFile(String fileName) async {
  final lines = await readAsString(fileName);
  return JsonObject.fromText(lines);
}

Future<JsonBase> jsonFromFile(String fileName) async {
  final lines = await readAsString(fileName);
  return jsonFromText(lines);
}


JsonBase jsonFromText(String texts) {
  if (texts.trim().startsWith('{') && texts.trim().endsWith('}')) {
    return JsonBase().setObj(JsonObject.fromText(texts));
  } else if (texts.trim().startsWith('[') && texts.trim().endsWith(']')) {
    return JsonBase().setArr(JsonArray.fromText(texts));
  }
  return JsonBase();
}