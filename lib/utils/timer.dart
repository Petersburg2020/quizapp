
class Timer {
  final int durationInSecs;

  Timer(this.durationInSecs);

  static int currentTimeMillis() => DateTime.now().millisecond;

  static int currentTimeInSec() => DateTime.now().second;

  void start(void Function(int elapsedTimeInSecs, int startTimeInSecs, int currentTimeInSecs) todo) async {
    var start = currentTimeInSec();
    var current = start;
    while ((current - start) < durationInSecs) {
      todo(current - start, start, currentTimeInSec());

      await Future.delayed(Duration(seconds: 1));
      current = currentTimeInSec();
      if ((current - start) == durationInSecs) {
        todo(current - start, start, currentTimeInSec());
        break;
      }
    }
  }

  void countdown(void Function(int countdownTimeInSecs, int startTimeInSecs, int currentTimeInSecs) todo) async {
    var start = currentTimeInSec();
    var current = start;
    while ((current - start) < durationInSecs) {
      todo(durationInSecs - (current - start), start, currentTimeInSec());

      await Future.delayed(Duration(seconds: 1));
      current = currentTimeInSec();
      if ((current - start) == durationInSecs) {
        todo(durationInSecs - (current - start), start, currentTimeInSec());
        break;
      }
    }
  }


}

