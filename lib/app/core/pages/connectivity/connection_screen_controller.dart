
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../controllers/auth/auth_status.dart';
import '../../controllers/auth/auth_store.dart';
import '../../controllers/network_provider.dart';
part 'connection_screen_controller.g.dart';


// ignore: library_private_types_in_public_api
class ConnectionScreenController = _ConnectionScreenControllerBase with _$ConnectionScreenController;

abstract class _ConnectionScreenControllerBase with Store{

  _ConnectionScreenControllerBase(){
    reaction((_) => Modular.get<AuthStore>().statusNetwork, (status) {
      if(status == StatusNetwork.LOADING || Modular.get<AuthStore>().status == AuthStatus.Authenticating) {
        setLoading(true);
      } else {
        setLoading(false);
      }
    });
  }

  @observable
  bool loading = false;

  @action
  setLoading(bool value) => loading = value;

}