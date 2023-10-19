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
            child: Observer(builder: (context) {
              if (widget.controller.showCursosWidget) {
                return CursosPage(
                    controller: Modular.get(),
                    callBack: (curso) {
                      widget.controller.setCursoSelected(curso);
                      Modular.to.pushNamed('/eventos/eventoslist/${curso.id}');
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
      String observacoes = '';
      await _addImage(base64Image, observacoes);
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
    throw UnimplementedError();
  }
}

