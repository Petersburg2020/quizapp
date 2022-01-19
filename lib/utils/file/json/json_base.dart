import '../json_manager.dart';

class JsonBase {
  Map<String, dynamic> _object;
  List<dynamic> _array;
  Root _root;
  bool _readable, _writable;

  JsonBase() {
    _reset();
  }

  factory JsonBase.fromObject(Map<String, dynamic> object) {
    final base = JsonBase();
    base.setObject(object);
    return base;
  }

  factory JsonBase.fromArray(List<dynamic> array) {
    final base = JsonBase();
    base.setArray(array);
    return base;
  }

  void _reset() {
    _object = null;
    _array = null;
    _readable = true;
    _writable = true;
    _root = Root.None;
  }

  void set(JsonBase base) {
    if (base != null) {
      if (base.isArray) {
        setArr(base.array);
      } else if (base.isObject) {
        setObj(base.object);
      } else {
        _reset();
      }
    }
  }

  JsonBase setArray(Iterable<dynamic> array) {
    if (array != null) {
      _array = array;
      _root = Root.Array;
    }
    return this;
  }

  JsonBase setArr(JsonArray array) => setArray(array != null ? array.values : null);

  JsonBase setObject(Map<String, dynamic> object) {
    if (object != null) {
      _object = object;
      _root = Root.Object;
    }
    return this;
  }

  JsonBase setObj(JsonObject object) => setObject(object != null ? object.object : null);


  bool get isArray => _array != null && _root == Root.Array;

  bool get isObject => _object != null && _root == Root.Object;

  bool get isNone => !isArray && !isObject;

  Root get root => _root;

  JsonArray get array => isArray ? JsonArray(_array, readable: _readable, writable: _writable) : null;

  JsonObject get object => isObject ? JsonObject(_object, readable: _readable, writable: _writable) : null;

  void setReadable(bool readable) => _readable = readable;

  void setWritable(bool writable) => _writable = writable;

  bool get isWritable => _writable;

  bool get isReadable => _readable;


  int get size => isArray ? array.size : isObject ? object.size : 0;

  bool get isEmpty => size == 0;


  @override
  String toString() => isArray ? array.toString() : isObject ? object.toString() : '';

}

enum Root {
  Array, None, Object
}