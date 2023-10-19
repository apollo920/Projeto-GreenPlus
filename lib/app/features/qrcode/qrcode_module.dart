import 'package:flutter_modular/flutter_modular.dart';
import 'package:greenplus/app/features/qrcode/pages/qrcode_controller.dart';
import 'infra/datasources/i_qrcode_datasource.dart';
import 'infra/datasources/qrcode_datasource_impl.dart';
import 'infra/repository/i_qrcode_repository.dart';
import 'infra/repository/qrcode_repository.dart';
import 'pages/qrcode_list.dart';
import 'pages/qrcode_page.dart';

class QrCodeModule extends Module {
  @override
  List<Bind> get binds => [
        Bind<IQrCodeDataSource>((i) => QrCodeDataSourceImpl(i(), i())),
        Bind<IQrCodeRepository>((i) => QrCodeRepositoryImpl(i())),
        Bind<QrCodeController>((i) => QrCodeController(i(), i()))
      ];

  @override
  List<ModularRoute> get routes => [
    ChildRoute("/",child: (context, args) => QrCodePage(controller: Modular.get())),
  ChildRoute("/qrcodewifi", child:  (context, args) => const QRCodeWifiGenerator()),
  ChildRoute("/qrcodelink", child:  (context, args) => const QRCodeLinkGenerator()),
  ChildRoute("/qrcodelist/:idCurso/:idPeriodo", child:  (context, args) => QRCodeListScreen(controller: Modular.get(), idCurso: args.params['idCurso'], idPeriodo: args.params['idPeriodo'],)),
  ChildRoute("/qrcodezoom", child:  (context, args) => const QRCodeZoomScreen(data: '',title: '',)),

  ];
}
