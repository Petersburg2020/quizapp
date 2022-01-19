import '../../utils.dart';

class JsonObject {
  Map<String, dynamic> _object = {};
  int _indent = 0;
  bool _after = false, readable, writable;

  JsonObject(this._object, {this.readable = true, this.writable = true});

  factory JsonObject.fromText(String arrayText) => JsonObject(
      arrayText.trim().startsWith('{') && arrayText.trim().endsWith('}')
          ? json.decode(arrayText)
          : {});

  bool add(String name, dynamic value) {
    if (name != null && writable) _object[name] = value;
    return containsName(name) && containsValue(value) && get(name) == value && writable;
  }

  bool removeName(String name) =>
      containsName(name) && readable && _object.remove(name) != null;

  bool removeValue(dynamic value) =>
      containsValue(value) && readable ? removeName(nameOf(value)) : false;

  bool replaceValue(dynamic oldValue, dynamic newValue) {
    final oldReadable = readable;
    readable = true;
    if (containsValue(oldValue) && writable) {
      for (dynamic value in values) {
        if(value == oldValue) {
          final name = nameOf(value);
          if (name != null) add(name, newValue);
        }
      }
    }
    readable = oldReadable;
    return containsValue(newValue) && !containsValue(oldValue) && writable;
  }

  String nameOf(dynamic value) {
    for (var name in names) {
      if (get(name) == value && readable) return name;
    }
    return null;
  }

  Iterable<String> get names => readable ? _object.keys : null;

  Iterable<dynamic> get values => readable ? _object.values : null;

  Map<String, dynamic> get object => readable ? _object : null;

  int get size => readable ? _object.length : 0;

  List<JsonObject> get allObjects {
    final objects = <JsonObject>[];
    for (dynamic value in values) {
      if (isObject(value)) objects.add(JsonObject(value));
    }
    return readable ? objects : null;
  }

  List<JsonArray> get allArrays {
    final array = <JsonArray>[];
    for (dynamic value in values) {
      if (isArray(value)) array.add(JsonArray(value));
    }
    return readable ? array : null;
  }

  bool containsName(String name) =>
      name != null && readable && names.contains(name);

  bool containsValue(dynamic value) => values.contains(value) && readable;

  dynamic get(String name) =>
      containsName(name) && readable ? _object[name] : null;

  String getString(String name) => (containsName(name) &&
          readable &&
          (get(name).runtimeType == ''.runtimeType)
      ? get(name)
      : null);

  JsonArray getArray(String name) => (containsName(name) &&
          readable &&
          (get(name).runtimeType == [].runtimeType)
      ? JsonArray(get(name))
      : null);

  JsonObject getObject(String name) => (containsName(name) &&
          readable &&
          (get(name).runtimeType == {}.runtimeType)
      ? JsonObject(get(name))
      : null);

  int getInt(String name, int defaultValue) => (containsName(name) &&
          readable &&
          (get(name).runtimeType == 0.runtimeType)
      ? get(name)
      : defaultValue);

  double getDouble(String name, double defaultValue) => (containsName(name) &&
          readable &&
          (get(name).runtimeType == 0.0.runtimeType)
      ? get(name)
      : defaultValue);

  bool getBool(String name, bool defaultValue) => (containsName(name) &&
          readable &&
          (get(name).runtimeType == false.runtimeType)
      ? get(name)
      : defaultValue);

  JsonObject setIndent(int indent) {
    _indent = indent;
    return this;
  }

  JsonObject setAfter(bool after) {
    _after = after;
    return this;
  }

  @override
  String toString() {
    var format = (!_after ? tabs(_indent) : '') + '{\n';
    var index = 0;

    for (var name in names) {
      format += tabs(_indent + 1) + '"' + name + '": ';
      var value = get(name);

      if (isArray(value)) {
        format +=
            JsonArray(value).setIndent(_indent + 1).setAfter(true).toString();
      } else if (isObject(value)) {
        format +=
            JsonObject(value).setIndent(_indent + 1).setAfter(true).toString();
      } else if (isString(value)) {
        format += '"' + value + '"';
      } else {
        format += value.toString();
      }
      format += (index < size - 1 ? ',' : '') + '\n';
      index++;
    }

    return readable ? format + tabs(_indent) + '}' : null;
  }
}
