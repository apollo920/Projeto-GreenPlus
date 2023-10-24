
import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../core/cursos/page/cursos_page.dart';
import 'horarios_controller.dart';

class HorariosPage extends StatefulWidget {
  final HorariosController controller;
  const HorariosPage({super.key, required this.controller});

  @override
  State<HorariosPage> createState() => _HorariosPageState();
}

class _HorariosPageState extends State<HorariosPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Escolha um dos cursos específicos', style: TextStyle(color: Colors.white),),
          backgroundColor: const Color.fromARGB(255, 27, 136, 83),
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: Colors.white,
            onPressed: () {
              widget.controller.back();
            },
          )),
      body: Column(
        children: [
          Expanded(
            child: CursosPage(
                controller: Modular.get(),
                callBack: (curso) {
                  widget.controller.setCursoSelected(curso);
                  Modular.to.pushNamed('/horarios/horariospdf/${curso.id}');
                }),
          )
        ],
      ),
    );
  }
}

class PDFToBase64Screen extends StatefulWidget {
  @override
  _PDFToBase64ScreenState createState() => _PDFToBase64ScreenState();
}

class _PDFToBase64ScreenState extends State<PDFToBase64Screen> {
  String base64PDF = '';

  Future<void> pickAndConvertFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      File file = File(result.files.single.path!);
      List<int> pdfBytes = await file.readAsBytes();
      base64PDF = base64Encode(pdfBytes);

      
      print('Base64 encoded PDF: $base64PDF');
    } else {
      // User canceled the picker
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF to Base64'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            pickAndConvertFile();
          },
          child: Text('Pick and Convert PDF'),
        ),
      ),
    );
  }
}
