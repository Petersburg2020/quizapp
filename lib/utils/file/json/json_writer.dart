import '../../utils.dart';

class JsonWriter {
  String _path;
  bool _writeable, _unlocked;
  String _encryption;
  final JsonBase _base = JsonBase();

  JsonWriter() {
    _writeable = true;
    _unlocked = true;
    _encryption = null;
    _path = '';
  }

  Future<void> set(String path, {bool isPath=true, bool append=true}) async {
    if (append) {
      final reader = JsonReader();
      await reader.set(path, isPath: isPath);
      _base.set(reader.base);
    }
    _base.setWritable(_writeable);
    _path = isPath ? path : _path;
    _encryption = isArrayRoot ? _getArrayObjectValue('encryption') : isObjectRoot ? _getObjectValue('encryption') : null;
  }

  void setPath(String path) => _path = path;

  String get path => _path;

  bool get hasPath => _path.isNotEmpty;

  bool get isObjectRoot => _base.isObject;

  bool get isArrayRoot => _base.isArray;

  JsonBase get base => _base;

  JsonObject get object => _unlocked ? _base.object : null;

  JsonArray get array => _unlocked ? _base.array : null;

  Root get root => _base.root;

  int get size => _base.size;

  bool get isEmpty => _base.isEmpty;


  void createRootObject() => _base.setObject({});

  void createRootArray() => _base.setArray([]);


  int _getArrayObjectIndex(String name) {
    if (isArrayRoot && !isEmpty) {
      for (var index = 0; index < size; index++) {
        if (isObject(array.get(index)) && array.getObject(index).containsName(name)) return index;
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

    if (encryption != null) {
      if (isArrayRoot) {
        var index = _getArrayObjectIndex('encryption');
        if (index > -1) {
          array.getObject(index).removeName('encryption');
        }
      } else if (isObjectRoot) object.removeName('encryption');
    } else {
      if (isArrayRoot) {
        var index = _getArrayObjectIndex('encryption');
        if (index > -1) {
          array.getObject(index).add('encryption', encryption);
        }
      } else if (isObjectRoot) object.add('encryption', encryption);
    }
    _unlocked = encryption == null;
  }

  void setWritable(bool writable) {
    _writeable = writable;
    _base.setWritable(writable);
  }

  void setUnlocked(String encryption) {
    if (encryption != null && _encryption != null) {
      _unlocked = encryption == _encryption;
    } else {
      _unlocked = _encryption == null;
    }
  }

  String get encryption => _encryption;

  bool get isWriteable => _writeable;

  bool get isEncrypted => _encryption != null;

  bool get isUnlocked => _unlocked;

  Future<bool> store({String encryption}) async {
    if (_writeable && !_base.isNone) {
      setUnlocked(encryption);
      if (!isUnlocked) return false;
      var str = toString();
      return await write(_path, str);
    }
    return false;
  }

  @override
  String toString() {
    return _base.toString();
  }

}