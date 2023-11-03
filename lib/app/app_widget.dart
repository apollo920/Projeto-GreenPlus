import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'core/widgets/timer_tela_de_descanso.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

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
                    return TesteObserver(child: widget ?? Container());
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

  const TesteObserver({super.key, required this.child});

  @override
  State<TesteObserver> createState() => _TesteObserverState();
}

class _TesteObserverState extends State<TesteObserver>
    with TimeoutManagerMixin {


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => resetTimeoutTimer(),
      child: widget.child,
    );
  }

  @override
  void initState() {
    super.initState();

    startTimeoutTimer(context);
  }
}

