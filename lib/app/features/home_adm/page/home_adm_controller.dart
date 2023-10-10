import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:greenplus/app/core/controllers/auth/auth_store.dart';
import 'package:mobx/mobx.dart';

import '../infra/repository/i_home_adm_repository.dart';
import '../models/home_adm.dart';

part 'home_controller.g.dart';

class HomeAdmController = HomeAdmControllerBase with _$HomeAdmController;

abstract class HomeAdmControllerBase with Store {
  IHomeAdmRepository HomeAdmRepository;
  AuthStore authStore;

  HomeAdmControllerBase(this.HomeAdmRepository, this.authStore);

  @observable
  List<HomeAdm> homeAdm = [];

  @observable
  bool loading = false;

  @observable
  bool erro = false;

  @action
  setLoading(bool value) => loading = value;

  @action
  setErro(bool value) => erro = value;

  @computed
  get loaded => loading == false && erro == false;

  @action
  setHomeAdm(List<HomeAdm> value) => homeAdm = value;

  obterHomeAdm() async {
    setLoading(true);
    
    var result = await HomeAdmRepository.getHomeMenuAdm();

    result.fold(
        (erro) {
          setErro(true);
          setLoading(false);
          showDialog(
            context:
            Modular.routerDelegate.navigatorKey.currentState!.context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Erro ao buscar os menus'),
                content: Text(erro.message ?? ''),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('OK'),
                  )
                ],
              );
            },
          );
        }, (menus) {
      setHomeAdm(menus);
      setErro(false);
      setLoading(false);
    });
  }
}
