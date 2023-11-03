import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

mixin TimeoutManagerMixin<T extends StatefulWidget> on State<T> {
  late Timer _timer;
  bool _timeout = false;

  void startTimeoutTimer(BuildContext context) {
    _timer = Timer(const Duration(minutes: 1), () {
      _timeout = true;
      Modular.to.pushNamed('/timeout');
    });
  }

  void resetTimeoutTimer() {
    _timeout = false;
    _timer.cancel();
  }

  bool isTimedOut() {
    return _timeout;
  }
}