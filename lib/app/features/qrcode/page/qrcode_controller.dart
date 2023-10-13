import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../../core/cursos/models/curso.dart';
import '../../../core/periodos/models/periodo.dart';
import '../models/qrcode.dart';
import 'package:greenplus/app/features/qrcode/infra/datasources/qrcode_datasource_impl.dart';

part 'qrcode_controller.g.dart';

class QrCodeController = QrCodeControllerBase with _$QrCodeController;

abstract class QrCodeControllerBase with Store {
  // IQrCodeRepository homeRepository;
  // AuthStore authStore;

  //QrCodeControllerBase();

  @observable
  Curso? cursoSelected;

  @observable
  Periodo? periodoSelected;

  @observable
  bool loading = false;

  ObservableList<QrCodeModel> listaQrCode = ObservableList.of([
    {
      "content": "WIFI:T:WPA;S:SuaRedeWiFi;P:SuaSenha;;",
      "title": "WIFI DA PADARIA",
      "icon": "0xf051f",
      "type": "WiFi",
    },
    {
      "content": "https://exemplo.com",
      "title": "Exemplo de Link",
      "icon": "0xf1234",
      "type": "Link",
    },
  ].map((e) => QrCodeModel.fromMap(e)).toList());

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

// obterMenusModulos() async {
//   setLoading(true);
//
//   var result = await homeRepository.getMenusMedulos();
//
//   result.fold(
//       (erro) {
//         setErro(true);
//         setLoading(false);
//         showDialog(
//           context:
//           Modular.routerDelegate.navigatorKey.currentState!.context,
//           builder: (context) {
//             return AlertDialog(
//               title: const Text('Erro ao buscar os menus'),
//               content: Text(erro.message ?? ''),
//               actions: [
//                 TextButton(
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                   child: const Text('OK'),
//                 )
//               ],
//             );
//           },
//         );
//       }, (menus) {
//     setMenusModulo(menus);
//     setErro(false);
//     setLoading(false);
//   });
// }
}
