import 'dart:async';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'timeout_controller.g.dart';

class TimeoutController = _TimeoutControllerBase with _$TimeoutController;

abstract class _TimeoutControllerBase with Store {
  Timer? _timer;
  bool _timeout = false;
  bool _isTimeoutScreenOpened = false;

  void startTimeoutTimer() {
    _timer = Timer.periodic(const Duration(minutes: 2), (time) {
      print("${time.tick}");
      _timeout = true;
      if (!_isTimeoutScreenOpened) {
        _isTimeoutScreenOpened = true;
        Modular.to.pushNamed('/timeout');
      }
    });
  }

  void resetTimeoutTimer() {
    _timeout = false;
    _timer?.cancel();
  }

  void pauseTimeoutTimer() {
    _timer?.cancel();
  }

  void restartTimeoutTimer() {
    _timeout = false;
    _isTimeoutScreenOpened = false;
    _timer?.cancel();
    startTimeoutTimer();
  }

  bool isTimedOut() {
    return _timeout;
  }

  void resetTimeoutScreenOpened() {
    _isTimeoutScreenOpened = false;
  }
}
