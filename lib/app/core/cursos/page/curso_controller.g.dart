// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'curso_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CursoController on CursoControllerBase, Store {
  Computed<dynamic>? _$loadedComputed;

  @override
  dynamic get loaded =>
      (_$loadedComputed ??= Computed<dynamic>(() => super.loaded,
              name: 'CursoControllerBase.loaded'))
          .value;

  late final _$cursosAtom =
      Atom(name: 'CursoControllerBase.cursos', context: context);

  @override
  List<Curso> get cursos {
    _$cursosAtom.reportRead();
    return super.cursos;
  }

  @override
  set cursos(List<Curso> value) {
    _$cursosAtom.reportWrite(value, super.cursos, () {
      super.cursos = value;
    });
  }

  late final _$loadingAtom =
      Atom(name: 'CursoControllerBase.loading', context: context);

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
      Atom(name: 'CursoControllerBase.erro', context: context);

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

  late final _$CursoControllerBaseActionController =
      ActionController(name: 'CursoControllerBase', context: context);

  @override
  dynamic setLoading(bool value) {
    final _$actionInfo = _$CursoControllerBaseActionController.startAction(
        name: 'CursoControllerBase.setLoading');
    try {
      return super.setLoading(value);
    } finally {
      _$CursoControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setErro(bool value) {
    final _$actionInfo = _$CursoControllerBaseActionController.startAction(
        name: 'CursoControllerBase.setErro');
    try {
      return super.setErro(value);
    } finally {
      _$CursoControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setCursos(List<Curso> value) {
    final _$actionInfo = _$CursoControllerBaseActionController.startAction(
        name: 'CursoControllerBase.setCursos');
    try {
      return super.setCursos(value);
    } finally {
      _$CursoControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
cursos: ${cursos},
loading: ${loading},
erro: ${erro},
loaded: ${loaded}
    ''';
  }
}
