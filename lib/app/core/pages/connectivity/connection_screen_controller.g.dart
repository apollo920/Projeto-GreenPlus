// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'connection_screen_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ConnectionScreenController on _ConnectionScreenControllerBase, Store {
  late final _$loadingAtom =
      Atom(name: '_ConnectionScreenControllerBase.loading', context: context);

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

  late final _$_ConnectionScreenControllerBaseActionController =
      ActionController(
          name: '_ConnectionScreenControllerBase', context: context);

  @override
  dynamic setLoading(bool value) {
    final _$actionInfo = _$_ConnectionScreenControllerBaseActionController
        .startAction(name: '_ConnectionScreenControllerBase.setLoading');
    try {
      return super.setLoading(value);
    } finally {
      _$_ConnectionScreenControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
loading: ${loading}
    ''';
  }
}
