import 'dart:convert';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:greenplus/app/core/controllers/auth/auth_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:greenplus/app/features/horarios/pages/horarios_controller.dart';
import 'package:printing/printing.dart';
import 'package:greenplus/app/core/widgets/buttons/expandable_fab.dart';
import 'package:greenplus/app/core/widgets/timer_tela_de_descanso.dart';

import '../../../core/pages/empty/empty_page.dart';

class PDFScreen extends StatefulWidget {
  final HorariosController controller;
  final String idCurso;

  const PDFScreen({super.key, required this.controller, required this.idCurso});

  @override
  State<PDFScreen> createState() => _PDFScreenState();
}

class _PDFScreenState extends State<PDFScreen> with TimeoutManagerMixin {
  @override
  void initState() {
    super.initState();
    startTimeoutTimer(context);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      widget.controller.obterHorarios(idCurso: widget.idCurso);
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
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                widget.controller.setCursoSelected(null);
                Modular.to.pop();
              }),
          title: const Text(
            "Lista de Eventos",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: const Color.fromARGB(255, 27, 136, 83),
        ),
        floatingActionButton: (Modular.get<AuthStore>().user?.isAdmin ?? false)
            ? Observer(
                builder: (_) {
                  if (!widget.controller.erro) {
                    return ExpandableFab(
                      fabButtons: [
                        FabActionButton(
                          icon: Icons.picture_as_pdf,
                          onPressed: () =>
                              Modular.to.pushNamed('/horarios/pdfpicker'),
                          title: 'Trocar horários',
                        ),
                      ],
                    );
                  }
                  return Container();
                },
              )
            : null,
        body: Center(
            child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: ExactAssetImage('assets/images/aa.png'),
                  ),
                ),
                child: Center(
                    child: Column(children: [
                  Expanded(child: Observer(builder: (_) {
                    if (widget.controller.pdfHorario!.isNotEmpty) {
                      var pdf = widget.controller.pdfHorario;
                      return PdfPreview(
                        build: (_) => base64Decode(pdf ?? ''),
                        useActions: false,
                      );
                    } else if (widget.controller.erro) {
                      return Column(
                        children: [
                          const EmptyPage(
                            imagePath: "assets/images/server_down.svg",
                            message: "Erro ao carregar dados!",
                            isSvg: true,
                            heightPercent: 0.4,
                            subMessage: "Tente novamente mais tarde",
                            textColor: Colors.white,
                          ),
                          ElevatedButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text("VOLTAR")),
                          const SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                            onPressed: () => widget.controller
                                .obterHorarios(idCurso: widget.idCurso),
                            child: const Text("TENTE NOVAMENTE"),
                          ),
                        ],
                      );
                    } else {
                      return const EmptyPage(
                        imagePath: "assets/images/empty.svg",
                        message: "Sem Eventos",
                        isSvg: true,
                        heightPercent: 0.4,
                        subMessage: "Tente novamente mais tarde",
                        textColor: Colors.white,
                      );
                    }
                  }))
                ])))));
  }
}
