import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../core/cursos/page/cursos_page.dart';
import '../../../core/periodos/page/periodos_page.dart';


import 'eventos_controller.dart';

class EventosPage extends StatefulWidget {
  final EventosController controller;
  const EventosPage({super.key, required this.controller});

  @override
  State<EventosPage> createState() => _EventosPageState();
}

class _EventosPageState extends State<EventosPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Observer(
              builder: (context) {
                return widget.controller.showPeriodosWidget ? const Text('Escolha um dos periodos específicos') :  const Text('Escolha um dos cursos específicos');
              }
          ),
          backgroundColor: const Color.fromARGB(255, 27, 136, 83),
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_sharp),
            onPressed: () {
              widget.controller.back();
            },
          )),
      body: Column(
        children: [
          Expanded(
            child: Observer(builder: (context) {
              if (widget.controller.showCursosWidget) {
                return CursosPage(
                    controller: Modular.get(),
                    callBack: (curso) {
                      widget.controller.setCursoSelected(curso);
                    });
              }
              if (widget.controller.showPeriodosWidget) {
                return PeriodosPage(
                    controller: Modular.get(),
                    idCurso: widget.controller.cursoSelected!.id!,
                    callBack: (periodo) {
                      widget.controller.setPeriodoSelected(periodo);
                      Modular.to.pushNamed('/qrcode/qrcodelist/${widget.controller.cursoSelected?.id}/${periodo.id}');
                    });
              }

              return Container();
            }),
          )
        ],
      ),
    );
  }
}