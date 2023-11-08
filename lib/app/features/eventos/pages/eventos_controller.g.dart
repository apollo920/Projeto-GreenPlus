// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'eventos_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$EventosController on EventosControllerBase, Store {
  Computed<dynamic>? _$loadedComputed;

  @override
  dynamic get loaded =>
      (_$loadedComputed ??= Computed<dynamic>(() => super.loaded,
              name: 'EventosControllerBase.loaded'))
          .value;
  Computed<dynamic>? _$showCursosWidgetComputed;

  @override
  dynamic get showCursosWidget => (_$showCursosWidgetComputed ??=
          Computed<dynamic>(() => super.showCursosWidget,
              name: 'EventosControllerBase.showCursosWidget'))
      .value;
  Computed<dynamic>? _$showEventoComputed;

  @override
  dynamic get showEvento =>
      (_$showEventoComputed ??= Computed<dynamic>(() => super.showEvento,
              name: 'EventosControllerBase.showEvento'))
          .value;

  late final _$cursoSelectedAtom =
      Atom(name: 'EventosControllerBase.cursoSelected', context: context);

  @override
  Curso? get cursoSelected {
    _$cursoSelectedAtom.reportRead();
    return super.cursoSelected;
  }

  @override
  set cursoSelected(Curso? value) {
    _$cursoSelectedAtom.reportWrite(value, super.cursoSelected, () {
      super.cursoSelected = value;
    });
  }

  late final _$loadingAtom =
      Atom(name: 'EventosControllerBase.loading', context: context);

  @override
  bool get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
    });
  }

  late final _$listaEventoAtom =
      Atom(name: 'EventosControllerBase.listaEvento', context: context);

  @override
  ObservableList<EventoModel> get listaEvento {
    _$listaEventoAtom.reportRead();
    return super.listaEvento;
  }

  @override
  set listaEvento(ObservableList<EventoModel> value) {
    _$listaEventoAtom.reportWrite(value, super.listaEvento, () {
      super.listaEvento = value;
    });
  }

  late final _$listaAllEventoAtom =
      Atom(name: 'EventosControllerBase.listaAllEvento', context: context);

  @override
  ObservableList<EventoModel> get listaAllEvento {
    _$listaAllEventoAtom.reportRead();
    return super.listaAllEvento;
  }

  @override
  set listaAllEvento(ObservableList<EventoModel> value) {
    _$listaAllEventoAtom.reportWrite(value, super.listaAllEvento, () {
      super.listaAllEvento = value;
    });
  }

  late final _$erroAtom =
      Atom(name: 'EventosControllerBase.erro', context: context);

  @override
  bool get erro {
    _$erroAtom.reportRead();
    return super.erro;
  }

  @override
  set erro(bool value) {
    _$erroAtom.reportWrite(value, super.erro, () {
      super.erro = value;
    });
  }

  late final _$EventosControllerBaseActionController =
      ActionController(name: 'EventosControllerBase', context: context);

  @override
  dynamic setLoading(bool value) {
    final _$actionInfo = _$EventosControllerBaseActionController.startAction(
        name: 'EventosControllerBase.setLoading');
    try {
      return super.setLoading(value);
    } finally {
      _$EventosControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setErro(bool value) {
    final _$actionInfo = _$EventosControllerBaseActionController.startAction(
        name: 'EventosControllerBase.setErro');
    try {
      return super.setErro(value);
    } finally {
      _$EventosControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setCursoSelected(Curso? value) {
    final _$actionInfo = _$EventosControllerBaseActionController.startAction(
        name: 'EventosControllerBase.setCursoSelected');
    try {
      return super.setCursoSelected(value);
    } finally {
      _$EventosControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setEventos(List<EventoModel> value) {
    final _$actionInfo = _$EventosControllerBaseActionController.startAction(
        name: 'EventosControllerBase.setEventos');
    try {
      return super.setEventos(value);
    } finally {
      _$EventosControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setAllEventos(List<EventoModel> value) {
    final _$actionInfo = _$EventosControllerBaseActionController.startAction(
        name: 'EventosControllerBase.setAllEventos');
    try {
      return super.setAllEventos(value);
    } finally {
      _$EventosControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
cursoSelected: ${cursoSelected},
loading: ${loading},
listaEvento: ${listaEvento},
listaAllEvento: ${listaAllEvento},
erro: ${erro},
loaded: ${loaded},
showCursosWidget: ${showCursosWidget},
showEvento: ${showEvento}
    ''';
  }
}
