import 'exceptions.dart';

class NumberFormatException extends IException {
  NumberFormatException (String message) : super(message, 'NumberFormatException');
}