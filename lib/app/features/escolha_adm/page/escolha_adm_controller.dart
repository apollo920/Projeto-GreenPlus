import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:greenplus/app/core/controllers/auth/auth_store.dart';
import 'package:mobx/mobx.dart';

import '../infra/repository/i_escolha_adm_repository.dart';
import '../models/escolha_adm.dart';

part 'home_controller.g.dart';

class EscolhaAdmController = EscolhaAdmControllerBase with _$EscolhaAdmController;

abstract class EscolhaAdmControllerBase with Store {
  IEscolhaAdmRepository escolhaAdmRepository;
  AuthStore authStore;

  EscolhaAdmControllerBase(this.escolhaAdmRepository, this.authStore);

  @observable
  List<EscolhaAdm> escolhaAdm = [];

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
  setEscolhaAdm(List<EscolhaAdm> value) => escolhaAdm = value;

  obterEscolhaAdm() async {
    setLoading(true);
    
    var result = await escolhaAdmRepository.getEscolhasMenuAdm();

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
      setEscolhaAdm(menus);
      setErro(false);
      setLoading(false);
    });
  }
}
