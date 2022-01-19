class Thread implements Runnable {
  Function _runnable;
  bool _ended=false, _started=false;

  Thread(this._runnable);

  factory Thread.from() => Thread(null);

  void start() {
    if (_runnable != null) {
      _started = true;
      run();
    } else {
      _started = false;
      _ended = true;
    }
  }

  void stop() {
    _started = false;
    _ended = true;
    _runnable = null;
    start();
  }

  @override
  void run() {
    if (_runnable != null) {
      _runnable.call();
      _started = false;
      _ended = true;
    }
  }

  bool running() => _started && !_ended;

  bool finished() => _ended && !_started;

}

abstract class Runnable {
  void run();
}
