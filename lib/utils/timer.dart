class Timer {
  final int durationInSecs;

  bool _ended;

  Timer(this.durationInSecs);

  static int currentTimeMillis() => DateTime.now().millisecond;

  static int currentTimeInSec() => DateTime.now().second;

  void start(void Function(int elapsedTimeInSecs, int startTimeInSecs, int currentTimeInSecs, bool hasEnded) todo) async {
    var start = currentTimeInSec();
    var current = start;
    _ended = false;
    while ((current - start) < durationInSecs) {
      todo(current - start, start, currentTimeInSec(), false);

      await Future.delayed(Duration(seconds: 1));
      current = currentTimeInSec();
      if ((current - start) == durationInSecs) {
        todo(current - start, start, currentTimeInSec(), true);
        _ended = true;
        break;
      }
    }
  }

  bool hasEnded() => _ended;

  void countdown(void Function(int countdownTimeInSecs, int startTimeInSecs, int currentTimeInSecs, bool hasEnded) todo) async {
    var start = currentTimeInSec();
    var current = start;
    _ended = false;
    while ((current - start) < durationInSecs) {
      todo(durationInSecs - (current - start), start, currentTimeInSec(), false);

      await Future.delayed(Duration(seconds: 1));
      current = currentTimeInSec();
      if ((current - start) == durationInSecs) {
        todo(durationInSecs - (current - start), start, currentTimeInSec(), true);
        _ended = true;
        break;
      }
    }
  }

}

