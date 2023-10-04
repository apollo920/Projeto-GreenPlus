// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AuthStore on _AuthStoreBase, Store {
  late final _$userAtom = Atom(name: '_AuthStoreBase.user', context: context);

  @override
  User? get user {
    _$userAtom.reportRead();
    return super.user;
  }

  @override
  set user(User? value) {
    _$userAtom.reportWrite(value, super.user, () {
      super.user = value;
    });
  }

  late final _$statusAtom =
      Atom(name: '_AuthStoreBase.status', context: context);

  @override
  AuthStatus? get status {
    _$statusAtom.reportRead();
    return super.status;
  }

  @override
  set status(AuthStatus? value) {
    _$statusAtom.reportWrite(value, super.status, () {
      super.status = value;
    });
  }

  late final _$statusNetworkAtom =
      Atom(name: '_AuthStoreBase.statusNetwork', context: context);

  @override
  StatusNetwork? get statusNetwork {
    _$statusNetworkAtom.reportRead();
    return super.statusNetwork;
  }

  @override
  set statusNetwork(StatusNetwork? value) {
    _$statusNetworkAtom.reportWrite(value, super.statusNetwork, () {
      super.statusNetwork = value;
    });
  }

  late final _$setUsuarioAsyncAction =
      AsyncAction('_AuthStoreBase.setUsuario', context: context);

  @override
  Future<void> setUsuario(User? value) {
    return _$setUsuarioAsyncAction.run(() => super.setUsuario(value));
  }

  late final _$_AuthStoreBaseActionController =
      ActionController(name: '_AuthStoreBase', context: context);

  @override
  void setAuthStatus(AuthStatus value) {
    final _$actionInfo = _$_AuthStoreBaseActionController.startAction(
        name: '_AuthStoreBase.setAuthStatus');
    try {
      return super.setAuthStatus(value);
    } finally {
      _$_AuthStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setStatusNetwork(StatusNetwork value) {
    final _$actionInfo = _$_AuthStoreBaseActionController.startAction(
        name: '_AuthStoreBase.setStatusNetwork');
    try {
      return super.setStatusNetwork(value);
    } finally {
      _$_AuthStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
user: ${user},
status: ${status},
statusNetwork: ${statusNetwork}
    ''';
  }
}
