// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeController on HomeControllerBase, Store {
  Computed<dynamic>? _$loadedComputed;

  @override
  dynamic get loaded =>
      (_$loadedComputed ??= Computed<dynamic>(() => super.loaded,
              name: 'HomeControllerBase.loaded'))
          .value;

  late final _$menusModuloAtom =
      Atom(name: 'HomeControllerBase.menusModulo', context: context);

  @override
  List<MenuModulo> get menusModulo {
    _$menusModuloAtom.reportRead();
    return super.menusModulo;
  }

  @override
  set menusModulo(List<MenuModulo> value) {
    _$menusModuloAtom.reportWrite(value, super.menusModulo, () {
      super.menusModulo = value;
    });
  }

  late final _$loadingAtom =
      Atom(name: 'HomeControllerBase.loading', context: context);

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
      Atom(name: 'HomeControllerBase.erro', context: context);

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

  late final _$HomeControllerBaseActionController =
      ActionController(name: 'HomeControllerBase', context: context);

  @override
  dynamic setLoading(bool value) {
    final _$actionInfo = _$HomeControllerBaseActionController.startAction(
        name: 'HomeControllerBase.setLoading');
    try {
      return super.setLoading(value);
    } finally {
      _$HomeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setErro(bool value) {
    final _$actionInfo = _$HomeControllerBaseActionController.startAction(
        name: 'HomeControllerBase.setErro');
    try {
      return super.setErro(value);
    } finally {
      _$HomeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setMenusModulo(List<MenuModulo> value) {
    final _$actionInfo = _$HomeControllerBaseActionController.startAction(
        name: 'HomeControllerBase.setMenusModulo');
    try {
      return super.setMenusModulo(value);
    } finally {
      _$HomeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
menusModulo: ${menusModulo},
loading: ${loading},
erro: ${erro},
loaded: ${loaded}
    ''';
  }
}
