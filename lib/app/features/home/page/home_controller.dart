import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:greenplus/app/core/controllers/auth/auth_store.dart';
import 'package:mobx/mobx.dart';

import '../infra/repository/i_home_repository.dart';
import '../models/menu_modulo.dart';

part 'home_controller.g.dart';

class HomeController = HomeControllerBase with _$HomeController;

abstract class HomeControllerBase with Store {
  IHomeRepository homeRepository;
  AuthStore authStore;

  HomeControllerBase(this.homeRepository, this.authStore);

  @observable
  List<MenuModulo> menusModulo = [];

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
  setMenusModulo(List<MenuModulo> value) => menusModulo = value;

  obterMenusModulos() async {
    setLoading(true);
    await Future.delayed(const Duration(seconds: 4));
    var result = await homeRepository.getMenusMedulos();

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
      setMenusModulo(menus);
      setErro(false);
      setLoading(false);
    });
  }
}
