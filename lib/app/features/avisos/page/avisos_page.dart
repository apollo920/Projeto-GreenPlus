import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:greenplus/app/core/cursos/page/cursos_page.dart';

import '../../../core/cursos/models/curso.dart';

class AvisosPage extends StatefulWidget {
  const AvisosPage({super.key});

  @override
  State<AvisosPage> createState() => _AvisosPageState();
}

class _AvisosPageState extends State<AvisosPage> {
  Curso? cursoSelected;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Escolha um dos cursos específicos'),
          backgroundColor: Color.fromARGB(255, 27, 136, 83),
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_sharp),
            onPressed: () {
              if (cursoSelected == null) Modular.to.pop();
              setState(() {
                cursoSelected = null;
              });
            },
          )),
      body: Column(
        children: [
          Expanded(
            child: Builder(builder: (context) {
              if (cursoSelected == null) {
                return CursosPage(
                    controller: Modular.get(),
                    callBack: (curso) {
                      setState(() {
                        cursoSelected = curso;
                      });
                    });
              }
              if (cursoSelected != null) {
                return Container(child: Text("Telas de avisos"),);
              }
              return Container();
            }),
          )
        ],
      ),
    );
  }
}
