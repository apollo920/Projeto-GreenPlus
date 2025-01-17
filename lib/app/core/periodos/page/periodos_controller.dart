import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:mobx/mobx.dart';

import '../infra/repository/i_periodos_repository.dart';
import '../models/periodo.dart';


part 'periodos_controller.g.dart';

class PeriodosController = PeriodosControllerBase with _$PeriodosController;

abstract class PeriodosControllerBase with Store {
  IPeriodosRepository periodosRepository;

  PeriodosControllerBase(this.periodosRepository);

  @observable
  List<Periodo> periodos = [];

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
  setPeriodos(List<Periodo> value) => periodos = value;

  obterPeriodos({required String idPeriodo}) async {
    setLoading(true);
    
    var result = await periodosRepository.getPeriodos(idPeriodo: idPeriodo);

    result.fold(
        (erro) {
          setErro(true);
          setLoading(false);
          showDialog(
            context:
            Modular.routerDelegate.navigatorKey.currentState!.context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Erro ao buscar os periodoss'),
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
        }, (periodos) {
      setPeriodos(periodos);
      setErro(false);
      setLoading(false);
    });
  }
}
