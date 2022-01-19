import 'exceptions.dart';

class NullPointerException extends IException {
  NullPointerException(String message) : super(message, 'NullPointerException');
}