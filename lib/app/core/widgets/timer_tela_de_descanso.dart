import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

mixin TimeoutManagerMixin<T extends StatefulWidget> on State<T> {
  Timer? _timer;
  bool _timeout = false;
  bool _isTimeoutScreenOpened = false; 

  void startTimeoutTimer() {
    _timer = Timer(const Duration(hours: 10), () {
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
    _timer?.cancel();
    startTimeoutTimer();
  }

  bool isTimedOut() {
    return _timeout;
  }

  // Método para redefinir o indicador da tela de timeout
  void resetTimeoutScreenOpened() {
    _isTimeoutScreenOpened = false;
  }
}
