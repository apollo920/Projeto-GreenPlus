// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'escolha_adm_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$EscolhaAdmController on EscolhaAdmControllerBase, Store {
  Computed<dynamic>? _$loadedComputed;

  @override
  dynamic get loaded =>
      (_$loadedComputed ??= Computed<dynamic>(() => super.loaded,
              name: 'EscolhaAdmControllerBase.loaded'))
          .value;

  late final _$escolhaAdmAtom =
      Atom(name: 'EscolhaAdmControllerBase.escolhaAdm', context: context);

  @override
  List<EscolhaAdm> get escolhaAdm {
    _$escolhaAdmAtom.reportRead();
    return super.escolhaAdm;
  }

  @override
  set escolhaAdm(List<EscolhaAdm> value) {
    _$escolhaAdmAtom.reportWrite(value, super.escolhaAdm, () {
      super.escolhaAdm = value;
    });
  }

  late final _$loadingAtom =
      Atom(name: 'EscolhaAdmControllerBase.loading', context: context);

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
      Atom(name: 'EscolhaAdmControllerBase.erro', context: context);

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

  late final _$EscolhaAdmControllerBaseActionController =
      ActionController(name: 'EscolhaAdmControllerBase', context: context);

  @override
  dynamic setLoading(bool value) {
    final _$actionInfo = _$EscolhaAdmControllerBaseActionController.startAction(
        name: 'EscolhaAdmControllerBase.setLoading');
    try {
      return super.setLoading(value);
    } finally {
      _$EscolhaAdmControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setErro(bool value) {
    final _$actionInfo = _$EscolhaAdmControllerBaseActionController.startAction(
        name: 'EscolhaAdmControllerBase.setErro');
    try {
      return super.setErro(value);
    } finally {
      _$EscolhaAdmControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setEscolhaAdm(List<EscolhaAdm> value) {
    final _$actionInfo = _$EscolhaAdmControllerBaseActionController.startAction(
        name: 'EscolhaAdmControllerBase.setEscolhaAdm');
    try {
      return super.setEscolhaAdm(value);
    } finally {
      _$EscolhaAdmControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
escolhaAdm: ${escolhaAdm},
loading: ${loading},
erro: ${erro},
loaded: ${loaded}
    ''';
  }
}
