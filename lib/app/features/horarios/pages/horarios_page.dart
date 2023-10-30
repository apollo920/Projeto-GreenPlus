
import 'dart:convert';


import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:printing/printing.dart';
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
        ]
      )
    );
  }
}

class PDFPickerService extends StatefulWidget {
  const PDFPickerService({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PDFPickerServiceState createState() => _PDFPickerServiceState();
}

class _PDFPickerServiceState extends State<PDFPickerService> {
  String base64PDF = '';

  Future<void> pickAndConvertFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
      // allowMultiple: false,
    );

    if (result != null) {
      Uint8List uploadfile = result.files.single.bytes ?? Uint8List.fromList([]);
      base64PDF = base64Encode(uploadfile);
      // ignore: use_build_context_synchronously
      Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PDFPreview(pdfBase64: base64PDF),
      )
    );
    } else {
      // ignore: use_build_context_synchronously
      showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Algo de errado aconteceu"),
          actions: <Widget>[
            TextButton(
              child: const Text("Ok"),
              onPressed: () {
                Navigator.of(context).pop();
              }
            )
          ]
        );
      }
    );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(icon: const Icon(Icons.arrow_back, color: Colors.white,), onPressed: () => Modular.to.pop()),
        title: const Text("Selecione o horário a ser exibido",
          style: TextStyle(
            color: Colors.white
        )),
        backgroundColor: const Color.fromARGB(255, 27, 136, 83),
      ),
      body: Container(
         width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fill,
              image: ExactAssetImage('assets/images/a.png'),
            )
          ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: (){
                  pickAndConvertFile();
                },
                child: const Text('Escolha o arquivo', style: TextStyle(color: Colors.black),)
              ),
              const SizedBox(
                height: 20
              ),
               FractionallySizedBox(
                widthFactor: 0.1,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                  child: const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('*Nota: Lembre-se que esse é um seletor de PDFs, tente usar apenas arquivos .PDF', style: TextStyle(color: Colors.black),),
                      ]
                    )))
              )
            ]
          )
        )
      )
    );
  }
}

class PDFPreview extends StatefulWidget {
  final String pdfBase64;

  const PDFPreview({super.key, required this.pdfBase64});

  @override
  // ignore: library_private_types_in_public_api
  _PDFPreviewState createState() =>
      _PDFPreviewState();
}

class _PDFPreviewState
    extends State<PDFPreview> {

  Future<void> showConfirmationDialog() async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Tem certeza que deseja sair(talvez você não tenha salvo o arquivo)?"),
          actions: <Widget>[
            TextButton(
              child: const Text("Cancelar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Sim"),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              }
            )
          ]
        );
      }
    );
  }
  
  Future<void> _changePDF(String data) async {
    await Modular.get<HorariosController>().changeHorarios(
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
      floatingActionButton: 
      ElevatedButton(
        onPressed: () async {
          await _changePDF(widget.pdfBase64);    
          // ignore: use_build_context_synchronously
          Navigator.of(context).pop();
          // ignore: use_build_context_synchronously
          Navigator.of(context).pop();
                  },
              child: const Text('Salvar'),
                ), 
      body:PdfPreview(
            build: (_) => base64Decode(widget.pdfBase64),
            useActions: false, ),
    );
  }
}
