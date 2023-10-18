import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../../core/controllers/auth/auth_store.dart';
import '../../../core/cursos/models/curso.dart';
import '../../../core/periodos/models/periodo.dart';
import '../infra/repository/i_eventos_repository.dart';
import '../models/eventos.dart';

part 'eventos_controller.g.dart';

class EventosController = EventosControllerBase with _$EventosController;

abstract class EventosControllerBase with Store {
  IEventosRepository qrCodeRepository;
  AuthStore authStore;

  EventosControllerBase(this.qrCodeRepository, this.authStore);

  @observable
  Curso? cursoSelected;

  @observable
  Periodo? periodoSelected;

  @observable
  bool loading = false;

  @observable
  ObservableList<EventoModel> listaEvento = ObservableList<EventoModel>.of([]);

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
  setPeriodoSelected(Periodo? value) => periodoSelected = value;

  @action
  setEventos(List<EventoModel> value) =>
      listaEvento = ObservableList<EventoModel>.of(value);

  @computed
  get showCursosWidget => cursoSelected == null;

  @computed
  get showPeriodosWidget => !showCursosWidget;

  @computed
  get showEvento => !showPeriodosWidget && !showCursosWidget;

  back() {
    if (showEvento) {
      return setPeriodoSelected(null);
    }
    if (showPeriodosWidget) {
      return setCursoSelected(null);
    }
    if (showCursosWidget) {
      return Modular.to.pop();
    }
  }
}