import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:greenplus/app/features/eventos/models/eventos.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/cursos/page/cursos_page.dart';
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
                  Modular.to.pushNamed('/eventos/eventoslist/${curso.id}');
                }),
          )
        ],
      ),
    );
  }
}


class ImagePickerService extends StatefulWidget {
  @override
  _ImagePickerServiceState createState() => _ImagePickerServiceState();
}

class _ImagePickerServiceState extends State<ImagePickerService> {
  final _picker = ImagePicker();
  String observacoes = '';

  Future<void> getImageAndAddEventos() async {
    XFile? pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      String base64Image = base64Encode(await pickedImage.readAsBytes());
      Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ImagePreviewAndObservations(imagePath: base64Image),
      ),
    );
      // await _addImage(base64Image, observacoes);
    } else {
      
    }
  }

  Future<void> _addImage(String data, String observacoes) async {
    await Modular.get<EventosController>().addEventos(
      eventosModel: EventoModel.fromMap({
        "image": data,
        "observacoes": observacoes,
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(icon: const Icon(Icons.arrow_back, color: Colors.white,), onPressed: () => Modular.to.pop()),
        title: const Text("Selecione uma imagem a ser exibida",
          style: TextStyle(
            color: Colors.white
        ),),
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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: getImageAndAddEventos,
                child: const Text('Selecionar Imagem', style: TextStyle(color: Colors.black),),),
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
                        Text('*Nota: Lembre-se que esse é um seletor de imagens, tente usar apenas arquivos .PNG, .JPEG ou .JPG', style: TextStyle(color: Colors.black),),
                      ],
                    ))),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ImagePreviewAndObservations extends StatefulWidget {
  final String imagePath;

  ImagePreviewAndObservations({required this.imagePath});

  @override
  _ImagePreviewAndObservationsState createState() =>
      _ImagePreviewAndObservationsState();
}

class _ImagePreviewAndObservationsState
    extends State<ImagePreviewAndObservations> {
  String observacoes = '';
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
  
  Future<void> _addImage(String data, String observacoes) async {
    await Modular.get<EventosController>().addEventos(
      eventosModel: EventoModel.fromMap({
        "image": data,
        "observacoes": observacoes,
      }),
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
          "Verificação de imagem selecionada e observações",
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
            Text("Imagem selecionada", style: TextStyle(color: Colors.white),),
            SizedBox(height: 7),
            Image.memory(
                    base64Decode(widget.imagePath),
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: MediaQuery.of(context).size.height *0.5, 
                    fit: BoxFit.contain,),
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
                      Text("Escreva suas observações(Se necessário):"),
                      TextFormField(
                        controller: textController,
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () async {
                          setState(() {
                            observacoes = textController.text; 
                          });
                          await _addImage(widget.imagePath, observacoes);
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