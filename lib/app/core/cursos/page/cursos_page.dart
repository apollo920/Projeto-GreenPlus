import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:greenplus/app/core/utils/string_extensions.dart';
import 'package:greenplus/app/core/widgets/grid_menus.dart';

import '../../widgets/buttons/custom_button_quadrado.dart';
import '../models/curso.dart';
import 'curso_controller.dart';

class CursosPage extends StatefulWidget {
  final Function(Curso curso) callBack;
  final CursoController controller;

  const CursosPage(
      {super.key, required this.controller, required this.callBack});

  @override
  State<CursosPage> createState() => _CursosPageState();
}

class _CursosPageState extends State<CursosPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      widget.controller.obterCursos();
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
            child: Center(child: SingleChildScrollView(
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
                          onPressed: () => widget.controller.obterCursos(),
                          child: const Text("Tentar novamente"))
                    ],
                  );
                }
                if (widget.controller.loaded) {
                  int halfLength = widget.controller.cursos.length <= 5 ? 5 : (widget.controller.cursos.length / 2).ceil();
                  return GridMenus(
                      contentLine1: widget.controller.cursos
                          .take(halfLength)
                          .map((curso) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 30),
                                child: CustomButtonQuadrado(
                                  backgroundColor:
                                      const Color.fromARGB(255, 27, 136, 83),
                                  icon: curso.icon!.toIcon(),
                                  onPressed: () => widget.callBack(curso),
                                  label: curso.nome ?? '',
                                ),
                              ))
                          .toList(),
                      contentLine2: widget.controller.cursos
                          .skip(halfLength)
                          .map((curso) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: CustomButtonQuadrado(
                                backgroundColor:
                                    const Color.fromARGB(255, 27, 136, 83),
                                icon: curso.icon!.toIcon(),
                                onPressed: () => widget.callBack(curso),
                                label: curso.nome ?? '',
                              )))
                          .toList());
                }
                return Container();
              }),
            ))));
  }
}
