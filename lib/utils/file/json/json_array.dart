import '../../utils.dart';

class JsonArray {
  List<dynamic> _array = [];
  int _indent = 0;
  bool _after = false, writable, readable;

  JsonArray(this._array, {this.writable = true, this.readable = true});

  factory JsonArray.fromText(String arrayText) {
    return JsonArray(
        arrayText.trim().startsWith('[') && arrayText.trim().endsWith(']')
            ? json.decode(arrayText)
            : []);
  }

  bool add(dynamic value) {
    if (!containsValue(value) && writable) _array.add(value);
    return containsValue(value) && indexOf(value) > -1 && writable;
  }

  bool insert(dynamic value, int index) {
    if (containsIndex(index) && writable) _array.insert(index, value);
    return containsIndex(index) &&
        containsValue(value) &&
        get(index) == value &&
        writable;
  }

  bool removeValue(dynamic value) {
    return writable ? _array.remove(value) : false;
  }

  bool removeIndex(int index) {
    return writable ? _array.removeAt(index) != null : false;
  }

  int indexOf(dynamic value) => _array.indexOf(value);

  bool containsValue(dynamic value) =>
      readable ? _array.contains(value) : false;

  bool containsIndex(int index) =>
      readable ? index >= 0 && index < size : false;

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

  int get size => readable ? _array.length : 0;

  Iterable<dynamic> get values => readable ? _array : null;

  dynamic get(int index) =>
      (containsIndex(index) && readable ? _array[index] : null);

  String getString(int index) =>
      (containsIndex(index) && isString(get(index)) && readable
          ? get(index)
          : null);

  JsonArray getArray(int index) =>
      (containsIndex(index) && readable && isArray(get(index))
          ? JsonArray(get(index))
          : null);

  JsonObject getObject(int index) =>
      (containsIndex(index) && isObject(get(index)) && readable
          ? JsonObject(get(index))
          : null);

  int getInt(int index, int defaultValue) =>
      (containsIndex(index) && isInt(get(index)) && readable
          ? get(index)
          : defaultValue);

  double getDouble(int index, double defaultValue) =>
      (containsIndex(index) && isDouble(get(index)) && readable
          ? get(index)
          : defaultValue);

  bool getBool(int index, bool defaultValue) =>
      (containsIndex(index) && isBool(get(index)) && readable
          ? get(index)
          : defaultValue);

  JsonArray setIndent(int indent) {
    _indent = indent;
    return this;
  }

  JsonArray setAfter(bool after) {
    _after = after;
    return this;
  }

  @override
  String toString() {
    var format = (!_after ? tabs(_indent) : '') + '[\n';
    var index = 0;

    for (var value in values) {
      if (isArray(value)) {
        format +=
            JsonArray(value).setIndent(_indent + 1).setAfter(true).toString();
      } else if (isObject(value)) {
        format +=
            JsonObject(value).setIndent(_indent + 1).setAfter(true).toString();
      } else if (isString(value)) {
        format += tabs(_indent + 1) + '"' + value + '"';
      } else {
        format += tabs(_indent + 1) + value.toString();
      }
      format += (index < size - 1 ? ',' : '') + '\n';
      index++;
    }

    return readable ? format + tabs(_indent) + ']' : null;
  }
}
