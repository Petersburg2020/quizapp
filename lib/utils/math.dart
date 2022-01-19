import 'dart:math';

class Math {
  static double min(double a, double b) => a >= b ? b : a;
  static double max(double a, double b) => a < b ? b : a;
  static double div(double a, double b) => a / b;
  static double abs(double a) => a.abs();
  static double random() => Random().nextDouble();

  static double nthRoot(double num, int nth) {
    var xPre = Math.random() * 10;
    var eps = 0.001;
    var delX = 2147483647;
    var xK = 0.0;

    while (delX > eps) {
      xK = ((nth - 1) * xPre + num / pow(xPre, nth - 1)) / nth;
      delX = Math.abs(xK - xPre) as int;
      xPre = xK;
    }
    return xK;
  }
  static double logN(double num, int nth) => log(num) / log(nth.toDouble());
  static double percent(double total, double fraction) => ratio(total, fraction) * 100;
  static double ratio(double total, double fraction) => fraction / total;
}