import 'utils.dart';

int nextInt(int start, int end) => Random.nextInt(start, end);

double nextDouble(double start, double end) {
  var val = Random.random();
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
      val = Random.random() + extra.toDouble();
      print('Rand: ' + rand.toString());
      print('Extra: ' + extra.toString());
      print('Val: ' + val.toString());
      if (val >= min && val <= max) return val;
    }
  }
  return null;
}

class Random {

  static double random() => Math.random();

  static int rint() => Math.rint();


  static double nextDoubleRange(double range) => nextDouble(0.0, range);

  static int nextIntRange(int range) => Math.nextInt(range);

  static double nextDouble(double min, double max) {
    if (min == max) {
      return min;
    }

    var minVal = Math.min(min, max), maxVal = Math.max(min, max);
    var val = random() + minVal;

    while (val < minVal || val > maxVal) {
      val = random() + minVal;
    }

    return val;
  }

  static int nextInt(int min, int max) {
    if (min == max) {
      return min;
    }

    var minVal = Math.min(min.toDouble(), max.toDouble()).toInt(), maxVal = Math.max(min.toDouble(), max.toDouble()).toInt();

    var val = nextIntRange(maxVal - minVal);
    
    while (val < minVal || val > maxVal) {
      val = nextIntRange(maxVal - minVal) + minVal;
    }

    return val;
  }

  static String nextLetter(String letter) {
    if (letter != null && letter.isNotEmpty) {
      return letter[nextIntRange(letter.length - 1)];
    }
    return '';
  }
}