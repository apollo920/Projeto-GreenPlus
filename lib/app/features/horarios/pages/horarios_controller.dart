import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import '../../../core/controllers/auth/auth_store.dart';
import '../../../core/cursos/models/curso.dart';
import '../infra/repository/i_horarios_repository.dart';

part 'horarios_controller.g.dart';

class HorariosController = HorariosControllerBase with _$HorariosController;

abstract class HorariosControllerBase with Store {
  IHorariosRepository horariosRepository;
  AuthStore authStore;

  HorariosControllerBase(this.horariosRepository, this.authStore);

  @observable
  Curso? cursoSelected;

  @observable
  String? pdfHorario;

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
  setHorarios(String? value) => pdfHorario = value;

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
    pdfHorario = '';
    setLoading(true);

    var result = await horariosRepository.getHorarios(idCurso: idCurso);

    result.fold((erro) {
      setErro(true);
      setLoading(false);
    }, (horario) {
      setHorarios(horario);
      setErro(false);
      setLoading(false);
    });
  }

  Future changeHorarios({required String base64}) async {
    // showLoading();
    print(1);
    var result = await horariosRepository.changeHorarios(
        idCurso: cursoSelected!.id!, base64: base64);
    // await Future.delayed(const Duration(seconds: 3));
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
      pdfHorario = base64;
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
