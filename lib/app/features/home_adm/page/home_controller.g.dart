// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_adm_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeAdmController on HomeAdmControllerBase, Store {
  Computed<dynamic>? _$loadedComputed;

  @override
  dynamic get loaded =>
      (_$loadedComputed ??= Computed<dynamic>(() => super.loaded,
              name: 'HomeAdmControllerBase.loaded'))
          .value;

  late final _$homeAdmAtom =
      Atom(name: 'HomeAdmControllerBase.homeAdm', context: context);

  @override
  List<HomeAdm> get homeAdm {
    _$homeAdmAtom.reportRead();
    return super.homeAdm;
  }

  @override
  set homeAdm(List<HomeAdm> value) {
    _$homeAdmAtom.reportWrite(value, super.homeAdm, () {
      super.homeAdm = value;
    });
  }

  late final _$loadingAtom =
      Atom(name: 'HomeAdmControllerBase.loading', context: context);

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
      Atom(name: 'HomeAdmControllerBase.erro', context: context);

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

  late final _$HomeAdmControllerBaseActionController =
      ActionController(name: 'HomeAdmControllerBase', context: context);

  @override
  dynamic setLoading(bool value) {
    final _$actionInfo = _$HomeAdmControllerBaseActionController.startAction(
        name: 'HomeAdmControllerBase.setLoading');
    try {
      return super.setLoading(value);
    } finally {
      _$HomeAdmControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setErro(bool value) {
    final _$actionInfo = _$HomeAdmControllerBaseActionController.startAction(
        name: 'HomeAdmControllerBase.setErro');
    try {
      return super.setErro(value);
    } finally {
      _$HomeAdmControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setHomeAdm(List<HomeAdm> value) {
    final _$actionInfo = _$HomeAdmControllerBaseActionController.startAction(
        name: 'HomeAdmControllerBase.setHomeAdm');
    try {
      return super.setHomeAdm(value);
    } finally {
      _$HomeAdmControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
homeAdm: ${homeAdm},
loading: ${loading},
erro: ${erro},
loaded: ${loaded}
    ''';
  }
}
