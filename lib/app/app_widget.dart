import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:greenplus/app/core/controllers/timeout_controller.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
    Modular.setNavigatorKey(navigatorKey);
    Modular.setInitialRoute('/auth/login');
    return MaterialApp.router(
      title: 'GreenPlus',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          useMaterial3: true, colorSchemeSeed: const Color(0xFF1b8853)),
      builder: (context, widget) =>
          Navigator(
            onGenerateRoute: (settings) =>
                MaterialPageRoute(
                  builder: (context) {
                    return TesteObserver(controller: Modular.get(),
                    child: widget ?? Container());
                  },
                ),
          ),
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
    ); //added by extension
  }
}

class TesteObserver extends StatefulWidget {
  final Widget child;
  final TimeoutController controller;

  const TesteObserver({super.key, required this.child, required this.controller});

  @override
  State<TesteObserver> createState() => _TesteObserverState();
}

class _TesteObserverState extends State<TesteObserver> {

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerUp: (value){
        widget.controller.restartTimeoutTimer();
      },
        child: widget.child);
  }
  @override
  void initState() {
    super.initState();
    widget.controller.startTimeoutTimer();
  }
}