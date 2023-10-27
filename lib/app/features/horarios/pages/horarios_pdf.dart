import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:greenplus/app/features/horarios/pages/horarios_controller.dart';

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
        return PDFView(
          filePath: widget.controller.listaHorario,
          enableSwipe: true,
          swipeHorizontal: true,
          autoSpacing: false,
          pageFling: false,
          onRender: (_pages) {
            print("Rendered $_pages pages");
          },
          onError: (error) {
            print(error.toString());
          },
          onPageError: (page, error) {
            print('$page: ${error.toString()}');
          },
          onViewCreated: (PDFViewController pdfViewController) {

          },
          onPageChanged: (int? page, int? total) {
            print('page change: $page/$total');
          },
        );
      }),
    );
  }
}