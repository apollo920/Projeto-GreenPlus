
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:greenplus/app/core/controllers/auth/auth_store.dart';
import 'package:greenplus/app/features/qrcode/infra/repository/i_qrcode_repository.dart';
import 'package:mobx/mobx.dart';
import '../../../core/cursos/models/curso.dart';
import '../../../core/periodos/models/periodo.dart';
import '../models/qrcode.dart';

part 'qrcode_controller.g.dart';

class QrCodeController = QrCodeControllerBase with _$QrCodeController;

abstract class QrCodeControllerBase with Store {
  IQrCodeRepository qrCodeRepository;
  AuthStore authStore;

  QrCodeControllerBase(this.qrCodeRepository, this.authStore);

  @observable
  Curso? cursoSelected;

  @observable
  Periodo? periodoSelected;

  @observable
  bool loading = false;

  @observable
  ObservableList<QrCodeModel> listaQrCode = ObservableList<QrCodeModel>.of([]);

  @observable
  bool erro = false;

  @action
  setLoading(bool value) => loading = value;

  @action
  setErro(bool value) => erro = value;

  @computed
  get loaded => loading == false && erro == false;

  @action
  setCursoSelected(Curso? value) => cursoSelected = value;

  @action
  setPeriodoSelected(Periodo? value) => periodoSelected = value;

  @action
  setQrCodes(List<QrCodeModel> value) =>
      listaQrCode = ObservableList<QrCodeModel>.of(value);

  @computed
  get showCursosWidget => cursoSelected == null;

  @computed
  get showPeriodosWidget => !showCursosWidget;

  @computed
  get showQrCode => !showPeriodosWidget && !showCursosWidget;

  back() {
    if (showQrCode) {
      return setPeriodoSelected(null);
    }
    if (showPeriodosWidget) {
      return setCursoSelected(null);
    }
    if (showCursosWidget) {
      return Modular.to.pop();
    }
  }

  obterQrCodes({required String idCurso, required String idPeriodo}) async {
    setLoading(true);

    var result = await qrCodeRepository.getQrCodes(
        idCurso: idCurso, idPeriodo: idPeriodo);

  result.fold((erro) {
  setErro(true);
  setLoading(false);
  showDialog(
    context: Modular.routerDelegate.navigatorKey.currentState!.context,
    builder: (context) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
        child: AlertDialog(
          title: const Text('Erro ao buscar os QrCodes'),
          content: Text(erro.message ?? ''),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            )
          ]
        )
      );
    }
  );
}, (qrcode) {
  setQrCodes(qrcode);
  setErro(false);
  setLoading(false);
});

  }

  Future addQrCode({required QrCodeModel qrCodeModel}) async {
    showLoading();

    var result = await qrCodeRepository.addQrCode(
        idCurso: cursoSelected!.id! , idPeriodo: periodoSelected!.id!, qrCodeModel: qrCodeModel);
    await Future.delayed(const Duration(seconds: 3));
    result.fold((erro) {
      Navigator.pop(Modular.routerDelegate.navigatorKey.currentState!.context);
      showDialog(
        context: Modular.routerDelegate.navigatorKey.currentState!.context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Erro ao adicionar QrCode'),
            content: Text(erro.message ?? ''),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              )
            ]
          );
        }
      );
    }, (id) {
      listaQrCode.add(qrCodeModel.copyWith(id: id));
      Navigator.pop(Modular.routerDelegate.navigatorKey.currentState!.context);
    });
  }

  Future deleteQrCode({required int idQrcode}) async {
  showLoading();

  var result = await qrCodeRepository.deleteQrCode(
      idCurso: cursoSelected!.id!, idPeriodo: periodoSelected!.id!, idQrcode: idQrcode);
  await Future.delayed(const Duration(seconds: 3));
  result.fold((erro) {
    Navigator.pop(Modular.routerDelegate.navigatorKey.currentState!.context);
    showDialog(
      context: Modular.routerDelegate.navigatorKey.currentState!.context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Erro ao apagar QrCode'),
          content: Text(erro.message ?? ''),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            )
          ]
        );
      }
    );
  }, (id) {
    listaQrCode.removeWhere((element) => element.id == id.toString());
    Navigator.pop(Modular.routerDelegate.navigatorKey.currentState!.context);
  });
}

  showLoading(){
    showDialog(
      context: Modular.routerDelegate.navigatorKey.currentState!.context,
      builder: (context) {
        return const Center(child: CircularProgressIndicator(),);
      }
    );
  }
}

