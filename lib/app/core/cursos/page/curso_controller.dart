import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:mobx/mobx.dart';

import '../infra/repository/i_curso_repository.dart';
import '../models/curso.dart';


part 'curso_controller.g.dart';

class CursoController = CursoControllerBase with _$CursoController;

abstract class CursoControllerBase with Store {
  ICursoRepository cursoRepository;

  CursoControllerBase(this.cursoRepository);

  @observable
  List<Curso> cursos = [];

  @observable
  bool loading = false;

  @observable
  bool erro = false;

  @action
  setLoading(bool value) => loading = value;

  @action
  setErro(bool value) => erro = value;

  @computed
  get loaded => loading == false && erro == false;

  @action
  setCursos(List<Curso> value) => cursos = value;

  obterCursos() async {
    setLoading(true);
    
    var result = await cursoRepository.getCursos();

    result.fold(
        (erro) {
          setErro(true);
          setLoading(false);
          showDialog(
            context:
            Modular.routerDelegate.navigatorKey.currentState!.context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Erro ao buscar os cursos'),
                content: Text(erro.message ?? ''),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('OK'),
                  )
                ],
              );
            },
          );
        }, (cursos) {
      setCursos(cursos);
      setErro(false);
      setLoading(false);
    });
  }
}
