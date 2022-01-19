class Thread implements Runnable {
  Future<bool> Function() _runnable;
  bool _ended=false, _started=false;

  Thread(this._runnable);

  factory Thread.from() => Thread(null);

  void start() async {
    if (_runnable != null) {
      _started = true;
      await run();
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
  Future<void> run() async {
    if (_runnable != null) {
      final b = await _runnable.call();
      print(b);
      _started = !b;
      _ended = b;
    }
  }

  bool running() => _started && !_ended;

  bool finished() => _ended && !_started;

  State getState() {
    if (running() && !finished()) {
      return State.RUNNABLE;
    } else if (finished()) {
      return State.TERMINATED;
    } else {
      return State.STARTED;
    }
  }

  @override
  void pause() {

  }

}

enum State {
  RUNNABLE, STARTED, TERMINATED
}

abstract class Runnable {
  void run();

  void pause();

}
