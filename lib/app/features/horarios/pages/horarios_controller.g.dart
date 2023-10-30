// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'horarios_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HorariosController on HorariosControllerBase, Store {
  Computed<dynamic>? _$loadedComputed;

  @override
  dynamic get loaded =>
      (_$loadedComputed ??= Computed<dynamic>(() => super.loaded,
              name: 'HorariosControllerBase.loaded'))
          .value;
  Computed<dynamic>? _$showCursosWidgetComputed;

  @override
  dynamic get showCursosWidget => (_$showCursosWidgetComputed ??=
          Computed<dynamic>(() => super.showCursosWidget,
              name: 'HorariosControllerBase.showCursosWidget'))
      .value;
  Computed<dynamic>? _$showHorarioComputed;

  @override
  dynamic get showHorario =>
      (_$showHorarioComputed ??= Computed<dynamic>(() => super.showHorario,
              name: 'HorariosControllerBase.showHorario'))
          .value;

  late final _$cursoSelectedAtom =
      Atom(name: 'HorariosControllerBase.cursoSelected', context: context);

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

  late final _$pdfHorarioAtom =
      Atom(name: 'HorariosControllerBase.pdfHorario', context: context);

  @override
  String? get pdfHorario {
    _$pdfHorarioAtom.reportRead();
    return super.pdfHorario;
  }

  @override
  set pdfHorario(String? value) {
    _$pdfHorarioAtom.reportWrite(value, super.pdfHorario, () {
      super.pdfHorario = value;
    });
  }

  late final _$loadingAtom =
      Atom(name: 'HorariosControllerBase.loading', context: context);

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

  late final _$erroAtom =
      Atom(name: 'HorariosControllerBase.erro', context: context);

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

  late final _$HorariosControllerBaseActionController =
      ActionController(name: 'HorariosControllerBase', context: context);

  @override
  dynamic setLoading(bool value) {
    final _$actionInfo = _$HorariosControllerBaseActionController.startAction(
        name: 'HorariosControllerBase.setLoading');
    try {
      return super.setLoading(value);
    } finally {
      _$HorariosControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setErro(bool value) {
    final _$actionInfo = _$HorariosControllerBaseActionController.startAction(
        name: 'HorariosControllerBase.setErro');
    try {
      return super.setErro(value);
    } finally {
      _$HorariosControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setCursoSelected(Curso? value) {
    final _$actionInfo = _$HorariosControllerBaseActionController.startAction(
        name: 'HorariosControllerBase.setCursoSelected');
    try {
      return super.setCursoSelected(value);
    } finally {
      _$HorariosControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setHorarios(String? value) {
    final _$actionInfo = _$HorariosControllerBaseActionController.startAction(
        name: 'HorariosControllerBase.setHorarios');
    try {
      return super.setHorarios(value);
    } finally {
      _$HorariosControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
cursoSelected: ${cursoSelected},
pdfHorario: ${pdfHorario},
loading: ${loading},
erro: ${erro},
loaded: ${loaded},
showCursosWidget: ${showCursosWidget},
showHorario: ${showHorario}
    ''';
  }
}
