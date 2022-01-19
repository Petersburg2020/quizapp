import '../../utils.dart';

class JsonReader {
  String _path, _text;
  bool isPath;
  bool _readable, _unlocked;
  String _encryption;
  JsonBase _base = JsonBase();

  JsonReader() {
    _readable = true;
    _path = '';
    _encryption = '';
    _unlocked = true;
  }

  void _format() {
    _base = jsonFromText(_text);
    if (isArrayRoot) {
      _encryption = _getArrayObjectValue('encryption');
    } else if (isObjectRoot) {
      _encryption = _getObjectValue('encryption');
    }
    _base.setWritable(false);
  }

  Future<void> set(String jsonTextOrPath, {bool isPath=true}) async {
    if(isPath) {
      _text = await readAsString(jsonTextOrPath);
      _path = jsonTextOrPath;
      _format();
    } else {
      _text = jsonTextOrPath;
      _format();
    }
  }

  String get path => _path;

  bool get hasPath => _path.isNotEmpty;

  bool get isObjectRoot => _base.isObject;

  bool get isArrayRoot => _base.isArray;

  JsonBase get base => _base;

  JsonObject get object => _unlocked && _readable ? _base.object : null;

  JsonArray get array => _unlocked && _readable ? _base.array : null;

  Root get root => _base.root;

  int get size => _base.size;

  bool get isEmpty => _base.isEmpty;

  int _getArrayObjectIndex(String name) {
    if (isArrayRoot && !isEmpty) {
      for (var index = 0; index < size; index++) {
        if (isObject(array.get(index)) &&
            array.getObject(index).containsName(name)) return index;
      }
    }
    return -1;
  }

  dynamic _getArrayObjectValue(String name) {
    if (isArrayRoot) {
      var index = _getArrayObjectIndex(name);
      return index > -1 ? array.get(index) : null;
    }
    return null;
  }

  dynamic _getObjectValue(String name) => object.get(name);

  void setEncryption(String encryption) {
    _encryption = encryption;
    if (encryption != null) _unlocked = false;
  }

  void setReadable(bool readable) {
    _readable = readable;
    _base.setReadable(readable);
  }

  void setUnlocked(String encryption) {
    if (encryption != null && _encryption != null) {
      _unlocked = encryption == _encryption;
    } else {
      _unlocked = encryption != null && _encryption == null;
    }
  }

  String get encryption => _encryption;

  bool get isReadable => _readable;

  bool get isEncrypted => _encryption != null;

  bool get isUnlocked => _unlocked;

  @override
  String toString() {
    return _base.toString();
  }
}
