import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:greenplus/app/features/horarios/pages/horarios_controller.dart';
import 'package:printing/printing.dart';

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
        title: Text('PDF Viewer'),
      ),
      body: Observer(
        builder: (_) {
        if (widget.controller.listaHorario == null) {
          const Center(
            child: CircularProgressIndicator(),
          );
        }
        return PdfPreview(build: (_) => base64Decode(widget.controller.listaHorario ?? ''), );
      }),
    );
  }
}