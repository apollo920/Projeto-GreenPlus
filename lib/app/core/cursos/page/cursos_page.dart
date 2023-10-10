import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:greenplus/app/core/utils/string_extensions.dart';
import 'package:greenplus/app/core/widgets/grid_menus.dart';

import '../../widgets/custom_button_quadrado.dart';
import 'curso_controller.dart';

class CursosPage extends StatefulWidget {
  final CursoController controller;

  const CursosPage({super.key, required this.controller});

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
        appBar: AppBar(
          title: const Text('Escolha um dos cursos específicos'),
          backgroundColor: Color.fromARGB(255, 27, 136, 83),
        ),
        body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: ExactAssetImage('assets/images/a.png'))),
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
                            onPressed: () =>
                                widget.controller.obterCursos(),
                            child: const Text("Tentar novamente"))
                      ],
                    );
                  }
                  if (widget.controller.loaded) {
                    return GridMenus(
                        contentLine1: widget.controller.cursos
                            .take(3)
                            .map((curso) => CustomButtonQuadrado(
                                  backgroundColor:
                                      const Color.fromARGB(255, 27, 136, 83),
                                  icon: curso.icon!.toIcon(),
                                  onPressed: () {
                                    //controller.navigateToCourseScreen(context, n, 'Eng');
                                  },
                                  label: curso.nome ?? '',
                                ))
                            .toList(),
                        contentLine2: widget.controller.cursos
                            .sublist(
                                widget.controller.cursos.length - 3, widget.controller.cursos.length)
                            .map((curso) => CustomButtonQuadrado(
                                  backgroundColor:
                                      const Color.fromARGB(255, 27, 136, 83),
                                  icon: curso.icon!.toIcon(),
                                  onPressed: () {
                                    //controller.navigateToCourseScreen(context, n, 'Eng');
                                  },
                                  label: curso.nome ?? '',
                                ))
                            .toList());
                  }
                  return Container();
                }),
              ),
            )));
  }
}
