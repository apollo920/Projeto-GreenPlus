import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:greenplus/app/core/periodos/models/periodo.dart';
import 'package:greenplus/app/core/utils/string_extensions.dart';
import 'package:greenplus/app/core/widgets/grid_menus.dart';
import 'package:greenplus/app/core/widgets/timer_tela_de_descanso.dart';

import '../../widgets/buttons/custom_button_quadrado.dart';
import 'periodos_controller.dart';

class PeriodosPage extends StatefulWidget {
  final String idCurso;
  final PeriodosController controller;
  final Function(Periodo curso) callBack;

  const PeriodosPage(
      {super.key,
      required this.controller,
      required this.idCurso,
      required this.callBack});

  @override
  State<PeriodosPage> createState() => _PeriodosPageState();
}

class _PeriodosPageState extends State<PeriodosPage> with TimeoutManagerMixin {
  @override
  void initState() {
    super.initState();
    startTimeoutTimer(context);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      widget.controller.obterPeriodos(idCurso: widget.idCurso);
    });
  }

  @override
  void dispose() {
    resetTimeoutTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: ExactAssetImage('assets/images/aa.png'))),
          child: Center(
            child: SingleChildScrollView(
              child: Observer(builder: (context) {
                if (widget.controller.loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (widget.controller.erro) {
                  return Column(
                    children: [
                      Container(
                        color: Colors.red,
                        child: const Text("Error"),
                      ),
                      OutlinedButton(
                          onPressed: () => widget.controller
                              .obterPeriodos(idCurso: widget.idCurso),
                          child: const Text("Tentar novamente"))
                    ],
                  );
                }
                if (widget.controller.loaded) {
                  int halfLength =
                      (widget.controller.periodos.length / 2).ceil();
                  return GridMenus(
                      contentLine1: widget.controller.periodos
                          .take(halfLength)
                          .map((periodo) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 30),
                                child: CustomButtonQuadrado(
                                  backgroundColor:
                                      const Color.fromARGB(255, 27, 136, 83),
                                  icon: periodo.icon!.toIcon(),
                                  onPressed: () => widget.callBack(periodo),
                                  label: periodo.nome ?? '',
                                ),
                              ))
                          .toList(),
                      contentLine2: widget.controller.periodos
                          .skip(halfLength)
                          .map((periodo) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 30),
                                child: CustomButtonQuadrado(
                                  backgroundColor:
                                      const Color.fromARGB(255, 27, 136, 83),
                                  icon: periodo.icon!.toIcon(),
                                  onPressed: () => widget.callBack(periodo),
                                  label: periodo.nome ?? '',
                                ),
                              ))
                          .toList());
                }
                return Container();
              }),
            ),
          )),
    );
  }
}
