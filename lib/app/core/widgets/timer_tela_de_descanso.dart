import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

mixin TimeoutManagerMixin<T extends StatefulWidget> on State<T> {
  late Timer _timer;
  bool _timeout = false;

  void startTimeoutTimer(BuildContext context) {
    _timer = Timer(const Duration(seconds: 10), () {
      _timeout = true;
      Modular.to.pushNamed('/timeout');
    });
  }

  void resetTimeoutTimer() {
    print("resetTimeoutTimer");
    _timeout = false;
    _timer.cancel();
    startTimeoutTimer(context);
  }

  bool isTimedOut() {
    return _timeout;
  }
}