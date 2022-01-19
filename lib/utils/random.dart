import 'dart:math';
import 'utils.dart';

int nextInt(int start, int end) => Random().nextInt((Math.max(start.toDouble(), end.toDouble()) - Math.min(start.toDouble(), end.toDouble())).toInt()) + Math.min(start.toDouble(), end.toDouble()).toInt();

double nextDouble(double start, double end) {
  var val = Random().nextDouble();
  final min = Math.min(start, end);
  final max = Math.max(start, end);

  var whole = Math.abs(end - start).toInt();
  print('Whole: ' + whole.toString());
  print('Start: ' + start.toString());
  print('End: ' + end.toString());

  if (max > min) {
    while (val < min || val > max) {
      var rand = nextInt(start.toInt(), end.toInt());
      var extra = whole > 0 ? rand :  min;
      val = Random().nextDouble() + extra.toDouble();
      print('Rand: ' + rand.toString());
      print('Extra: ' + extra.toString());
      print('Val: ' + val.toString());
      if (val >= min && val <= max) return val;
    }
  }
  return null;
}