// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'qrcode_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$QrCodeController on QrCodeControllerBase, Store {
  Computed<dynamic>? _$loadedComputed;

  @override
  dynamic get loaded =>
      (_$loadedComputed ??= Computed<dynamic>(() => super.loaded,
              name: 'QrCodeControllerBase.loaded'))
          .value;
  Computed<dynamic>? _$showCursosWidgetComputed;

  @override
  dynamic get showCursosWidget => (_$showCursosWidgetComputed ??=
          Computed<dynamic>(() => super.showCursosWidget,
              name: 'QrCodeControllerBase.showCursosWidget'))
      .value;
  Computed<dynamic>? _$showPeriodosWidgetComputed;

  @override
  dynamic get showPeriodosWidget => (_$showPeriodosWidgetComputed ??=
          Computed<dynamic>(() => super.showPeriodosWidget,
              name: 'QrCodeControllerBase.showPeriodosWidget'))
      .value;
  Computed<dynamic>? _$showQrCodeComputed;

  @override
  dynamic get showQrCode =>
      (_$showQrCodeComputed ??= Computed<dynamic>(() => super.showQrCode,
              name: 'QrCodeControllerBase.showQrCode'))
          .value;

  late final _$cursoSelectedAtom =
      Atom(name: 'QrCodeControllerBase.cursoSelected', context: context);

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

  late final _$periodoSelectedAtom =
      Atom(name: 'QrCodeControllerBase.periodoSelected', context: context);

  @override
  Periodo? get periodoSelected {
    _$periodoSelectedAtom.reportRead();
    return super.periodoSelected;
  }

  @override
  set periodoSelected(Periodo? value) {
    _$periodoSelectedAtom.reportWrite(value, super.periodoSelected, () {
      super.periodoSelected = value;
    });
  }

  late final _$loadingAtom =
      Atom(name: 'QrCodeControllerBase.loading', context: context);

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

  late final _$listaQrCodeAtom =
      Atom(name: 'QrCodeControllerBase.listaQrCode', context: context);

  @override
  ObservableList<QrCodeModel> get listaQrCode {
    _$listaQrCodeAtom.reportRead();
    return super.listaQrCode;
  }

  @override
  set listaQrCode(ObservableList<QrCodeModel> value) {
    _$listaQrCodeAtom.reportWrite(value, super.listaQrCode, () {
      super.listaQrCode = value;
    });
  }

  late final _$erroAtom =
      Atom(name: 'QrCodeControllerBase.erro', context: context);

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

  late final _$QrCodeControllerBaseActionController =
      ActionController(name: 'QrCodeControllerBase', context: context);

  @override
  dynamic setLoading(bool value) {
    final _$actionInfo = _$QrCodeControllerBaseActionController.startAction(
        name: 'QrCodeControllerBase.setLoading');
    try {
      return super.setLoading(value);
    } finally {
      _$QrCodeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setErro(bool value) {
    final _$actionInfo = _$QrCodeControllerBaseActionController.startAction(
        name: 'QrCodeControllerBase.setErro');
    try {
      return super.setErro(value);
    } finally {
      _$QrCodeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setCursoSelected(Curso? value) {
    final _$actionInfo = _$QrCodeControllerBaseActionController.startAction(
        name: 'QrCodeControllerBase.setCursoSelected');
    try {
      return super.setCursoSelected(value);
    } finally {
      _$QrCodeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setPeriodoSelected(Periodo? value) {
    final _$actionInfo = _$QrCodeControllerBaseActionController.startAction(
        name: 'QrCodeControllerBase.setPeriodoSelected');
    try {
      return super.setPeriodoSelected(value);
    } finally {
      _$QrCodeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setQrCodes(List<QrCodeModel> value) {
    final _$actionInfo = _$QrCodeControllerBaseActionController.startAction(
        name: 'QrCodeControllerBase.setQrCodes');
    try {
      return super.setQrCodes(value);
    } finally {
      _$QrCodeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
cursoSelected: ${cursoSelected},
periodoSelected: ${periodoSelected},
loading: ${loading},
listaQrCode: ${listaQrCode},
erro: ${erro},
loaded: ${loaded},
showCursosWidget: ${showCursosWidget},
showPeriodosWidget: ${showPeriodosWidget},
showQrCode: ${showQrCode}
    ''';
  }
}
