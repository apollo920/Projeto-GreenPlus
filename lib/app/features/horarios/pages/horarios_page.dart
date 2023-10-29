
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
      // ignore: use_build_context_synchronously
      Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PDFPreview(pdfPath: base64PDF),
      ),
    );
    } else {
      const Text("erro");
    }
  }

  Future<void> _addPDF(String data) async {
    await Modular.get<HorariosController>().addHorarios(
      base64: data,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF to Base64'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: (){
            pickAndConvertFile();
          },
          child: Text('Pick and Convert PDF'),
        ),
      ),
    );
  }
}

class PDFPreview extends StatefulWidget {
  final String pdfPath;

  PDFPreview({required this.pdfPath});

  @override
  _PDFPreviewState createState() =>
      _PDFPreviewState();
}

class _PDFPreviewState
    extends State<PDFPreview> {
  TextEditingController textController = TextEditingController();

  Future<void> showConfirmationDialog() async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Tem certeza que deseja sair?"),
          actions: <Widget>[
            TextButton(
              child: Text("Cancelar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Sim"),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  
  Future<void> _addPDF(String data) async {
    await Modular.get<HorariosController>().addHorarios(
      base64: data,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => showConfirmationDialog(),
        ),
        title: const Text(
          "Verificação do PDF selecionado",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 27, 136, 83),
      ),
      body: Container(
        width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fill,
              image: ExactAssetImage('assets/images/a.png'),
            ),
          ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("PDF selecionado", style: TextStyle(color: Colors.white),),
            SizedBox(height: 7),
            // Image.memory(
            //         base64Decode(widget.imagePath),
            //         width: MediaQuery.of(context).size.width * 0.5,
            //         height: MediaQuery.of(context).size.height *0.5, 
            //         fit: BoxFit.contain,),
            SizedBox(height: 20,),
            Container(
              width: MediaQuery.of(context).size.width * 0.5,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20))),
              child: FractionallySizedBox(
                widthFactor: 0.5,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () async {
                          await _addPDF(widget.pdfPath);
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                        },
                        child: const Text('Salvar'),
                      ),
                      SizedBox(height: 20,)
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
