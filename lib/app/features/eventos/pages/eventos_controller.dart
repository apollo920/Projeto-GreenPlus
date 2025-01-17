import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import '../../../core/controllers/auth/auth_store.dart';
import '../../../core/cursos/models/curso.dart';
import '../infra/repository/i_eventos_repository.dart';
import '../models/eventos.dart';

part 'eventos_controller.g.dart';

class EventosController = EventosControllerBase with _$EventosController;

abstract class EventosControllerBase with Store {
  IEventosRepository eventosRepository;
  AuthStore authStore;

  EventosControllerBase(this.eventosRepository, this.authStore);

  @observable
  Curso? cursoSelected;

  @observable
  bool loading = false;

  @observable
  ObservableList<EventoModel> listaEvento = ObservableList<EventoModel>.of([]);

  @observable
  ObservableList<EventoModel> listaAllEvento =
      ObservableList<EventoModel>.of([]);

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
  setEventos(List<EventoModel> value) =>
      listaEvento = ObservableList<EventoModel>.of(value);

  @action
  setAllEventos(List<EventoModel> value) =>
      listaAllEvento = ObservableList<EventoModel>.of(value);

  @computed
  get showCursosWidget => cursoSelected == null;

  @computed
  get showEvento => !showCursosWidget;

  back() {
    if (showEvento) {
      return setCursoSelected(null);
    }
    if (showCursosWidget) {
      return Modular.to.pop();
    }
  }

  obterEventos({required String idCurso}) async {
    listaEvento.clear();
    setLoading(true);

    var result = await eventosRepository.getEventos(idCurso: idCurso);

    result.fold((erro) {
      setErro(true);
      setLoading(false);
    }, (evento) {
      setEventos(evento);
      setErro(false);
      setLoading(false);
    });
  }

  obterAllEventos() async {
    listaEvento.clear();
    setLoading(true);


    var result = await eventosRepository.getAllEventos();

    result.fold((erro) {
      setErro(true);
      setLoading(false);
    }, (allEvento) {
      setAllEventos(allEvento);
      setErro(false);
      setLoading(false);
    });
  }

  Future addEventos({required EventoModel eventosModel}) async {
    // showLoading();
    setLoading(true);
    var result = await eventosRepository.addEventos(
        idCurso: cursoSelected!.id!, eventoModel: eventosModel);
    // await Future.delayed(const Duration(seconds: 3));
    result.fold((erro) {
      setLoading(false);
      print("erro: $result");
      Navigator.pop(Modular.routerDelegate.navigatorKey.currentState!.context);
      showDialog(
          context: Modular.routerDelegate.navigatorKey.currentState!.context,
          builder: (context) {
            return AlertDialog(
                title: const Text('Erro ao adicionar eventos'),
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
      setLoading(false);
      print("deu certo: $result");
      Navigator.pop(Modular.routerDelegate.navigatorKey.currentState!.context);
    });
  }

  Future deleteEventos({required String idEvento}) async {
    // showLoading();

    var result = await eventosRepository.deleteEventos(
        idCurso: cursoSelected!.id!, idEvento: idEvento);
    // await Future.delayed(const Duration(seconds: 3));
    result.fold((erro) {
      print("erro: $result");
      showDialog(
          context: Modular.routerDelegate.navigatorKey.currentState!.context,
          builder: (context) {
            return AlertDialog(
                title: const Text('Erro ao apagar Evento'),
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
      print("deu certo: $result");
      listaEvento.removeWhere((element) => element.id == id.toString());
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

  showTrash() {
    if ((Modular.get<AuthStore>().user?.isAdmin ?? false)) {
      return true;
    } else {
      return false;
    }
  }
}

// evento.id?.isNotEmpty ?? false,