import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../../features/auth/login/infra/repository/i_login_repository.dart';
import '../../../features/auth/login/models/user.dart';
import '../../infra/local_storage/local_storage.dart';
import '../network_provider.dart';
import 'auth_status.dart';

part 'auth_store.g.dart';

class AuthStore = _AuthStoreBase with _$AuthStore;

abstract class _AuthStoreBase with Store {
  final ILoginRepository repository;

  _AuthStoreBase(this.repository) {

    reaction((p0) => null, (p0) { });
    reaction((_) => status, (_) {
      if (statusNetwork == StatusNetwork.TRUE) {
        switch (status) {
          case AuthStatus.Outdated:
            Modular.to.navigate("/forceupdate");
            break;
          case AuthStatus.Uninitialized:
            Modular.to.navigate(
              "/auth/",
            );
            break;
          case AuthStatus.Authenticating:
            break;
          case AuthStatus.Unauthenticated:
            Modular.to.navigate(
              "/auth/",
            );
            break;
          case AuthStatus.Authenticated:
            Modular.to.navigate("/home");
            break;
          default:
        }
      }
    });

    reaction((_) => statusNetwork, (_) async {
      if (statusNetwork == StatusNetwork.FALSE) {
        Modular.to.navigate("/connectivityscreen");
      } else if (statusNetwork == StatusNetwork.TRUE) {
        checkLogin();
      }
    });
  }

  @observable
  User? user;

  @observable
  AuthStatus? status;

  @observable
  StatusNetwork? statusNetwork;

  bool isRefreshToken = false;

  setIsRefreshToken(bool value) => isRefreshToken = value;

  @action
  Future<void> setUsuario(User? value) async {
    user = value;
    //await repository.salvarUsuario(user: user!);
  }

  @action
  void setAuthStatus(AuthStatus value) => status = value;

  @action
  void setStatusNetwork(StatusNetwork value) => statusNetwork = value;

  Future<bool> checkLogin() async {
    setAuthStatus(AuthStatus.Authenticating);
    var result = await repository.usuarioLogado();
    return result.fold((l) async {
      await signOut();
      return false;
    }, (user) async {
      await setUsuario(user);
      var valid = await repository.verificarToken(token: user.token ?? '');
      return valid.fold((l) async {
        await signOut();
        return false;
      }, (isValid) async {
        if (isValid) {
          await setUserAuthentication(user);
          return true;
        }

        await signOut();
        return false;
      });
    });
  }

  Future signOut() async {
    await LocalStorage.setInstance().then((value) => value.clear());
    setAuthStatus(AuthStatus.Unauthenticated);
    setUsuario(null);
  }

  uninitialized() {
    setAuthStatus(AuthStatus.Uninitialized);
  }

  setUserAuthentication(user) async {
    setUsuario(user);
    setAuthStatus(AuthStatus.Authenticated);
  }
}
