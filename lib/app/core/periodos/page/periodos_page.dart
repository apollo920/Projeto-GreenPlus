import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:greenplus/app/core/periodos/models/periodo.dart';
import 'package:greenplus/app/core/utils/string_extensions.dart';
import 'package:greenplus/app/core/widgets/grid_menus.dart';

import '../../widgets/buttons/custom_button_quadrado.dart';
import 'periodos_controller.dart';

class PeriodosPage extends StatefulWidget {
  final String idPeriodo;
  final PeriodosController controller;
  final Function(Periodo curso) callBack;

  const PeriodosPage(
      {super.key,
      required this.controller,
      required this.idPeriodo,
      required this.callBack});

  @override
  State<PeriodosPage> createState() => _PeriodosPageState();
}

class _PeriodosPageState extends State<PeriodosPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      widget.controller.obterPeriodos(idPeriodo: widget.idPeriodo);
    });
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
                              .obterPeriodos(idPeriodo: widget.idPeriodo),
                          child: const Text("Tentar novamente"))
                    ],
                  );
                }
                if (widget.controller.loaded) {
                  int halfLength = widget.controller.periodos.length <= 5 ? 5 : (widget.controller.periodos.length / 2).ceil();
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
