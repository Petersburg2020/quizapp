export 'number_format_exception.dart';
export 'null_pointer_exception.dart';

abstract class IException implements Exception {
  final String _message, _type;

  IException(this._message, this._type);

  String get message => _message;

  @override
  String toString() => _type + ': ' + _message;
}