import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import '../../../core/controllers/auth/auth_store.dart';
import '../../../core/cursos/models/curso.dart';
import '../infra/repository/i_horarios_repository.dart';
import '../models/horarios.dart';

part 'horarios_controller.g.dart';

class HorariosController = HorariosControllerBase with _$HorariosController;

abstract class HorariosControllerBase with Store {
  IHorariosRepository horariosRepository;
  AuthStore authStore;

  HorariosControllerBase(this.horariosRepository, this.authStore);

  @observable
  Curso? cursoSelected;
  
  @observable
  String? listaHorario;

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
  setCursoSelected(Curso? value) => cursoSelected = value;

  @action
  setHorarios(String? value) => listaHorario = value;

  @computed
  get showCursosWidget => cursoSelected == null;

  @computed
  get showHorario => !showCursosWidget;

  back() {
    if (showHorario) {
      return setCursoSelected(null);
    }
    if (showCursosWidget) {
      return Modular.to.pop();
    }
  }

  obterHorarios({required String idCurso}) async {
    
    setLoading(true);

    var result = await horariosRepository.getHorarios(
        idCurso: idCurso);

    result.fold((erro) {
      setErro(true);
      setLoading(false);
    }, (horario) {
      setHorarios(horario);
      
      setErro(false);
      setLoading(false);
    });
  }

  Future addHorarios({required HorarioModel horariosModel, required String idCurso, required String base64}) async {
    showLoading();
    var result = await horariosRepository.addHorarios(
        idCurso: cursoSelected!.id!,
        horarioModel: horariosModel);
    await Future.delayed(const Duration(seconds: 3));
    result.fold((erro) {
      Navigator.pop(Modular.routerDelegate.navigatorKey.currentState!.context);
      showDialog(
          context: Modular.routerDelegate.navigatorKey.currentState!.context,
          builder: (context) {
            return AlertDialog(
                title: const Text('Erro ao adicionar horarios'),
                content: Text(erro.message ?? ''),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('OK'),
                  )
                ]);
          });
    }, (id) {
      listaHorario = base64;
      Navigator.pop(Modular.routerDelegate.navigatorKey.currentState!.context);
    });
  }

  showLoading() {
    showDialog(
        context: Modular.routerDelegate.navigatorKey.currentState!.context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }

}


// Modular.routerDelegate.navigatorKey.currentState!.context,