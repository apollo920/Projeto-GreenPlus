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
  List<QrCodeModel> listaQrCode = []; 

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
  setQrCodes(List<QrCodeModel> value) => listaQrCode = value;

  @computed
  get showCursosWidget => cursoSelected == null;

  @computed
  get showPeriodosWidget => !showCursosWidget && periodoSelected == null;

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

obterQrCodes() async {
  setLoading(true);

  var result = await qrCodeRepository.getQrCodes();

  result.fold(
      (erro) {
        setErro(true);
        setLoading(false);
        showDialog(
          context:
          Modular.routerDelegate.navigatorKey.currentState!.context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Erro ao buscar os QrCodes'),
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
      }, (qrcode) {
    setQrCodes(qrcode);
    setErro(false);
    setLoading(false);
  });
}
}
