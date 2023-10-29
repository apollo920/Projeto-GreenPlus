import 'dart:convert';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:greenplus/app/core/controllers/auth/auth_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:greenplus/app/features/horarios/pages/horarios_controller.dart';
import 'package:printing/printing.dart';
import 'package:greenplus/app/core/widgets/buttons/expandable_fab.dart';

class PDFScreen extends StatefulWidget {
  final HorariosController controller;
  final String idCurso;

  PDFScreen({required this.controller, required this.idCurso});

  @override
  State<PDFScreen> createState() => _PDFScreenState();
}

class _PDFScreenState extends State<PDFScreen> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      widget.controller.obterHorarios(idCurso: widget.idCurso);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Horários'),
      ),
      floatingActionButton: (Modular.get<AuthStore>().user?.isAdmin ?? false)
        ? Observer(
          builder: (_) {  
          if (!widget.controller.erro){
          return ExpandableFab(
              fabButtons: [
                FabActionButton(
                  icon: Icons.picture_as_pdf,
                  onPressed: () => Modular.to.pushNamed('/horarios/pdfpicker'),
                  title: 'Trocar horários',
                ),
              ],
            );
          }
          return Container();
          },
        )
        : null,
      body: Observer(
        builder: (_) {
        return Stack(
          children: [

            PdfPreview(
              build: (_) => base64Decode(widget.controller.listaHorario ?? ''),
              useActions: false, ),
            ],
        );
      }),
    );
  }
}