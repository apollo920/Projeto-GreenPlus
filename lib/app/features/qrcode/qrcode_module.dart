import 'package:flutter_modular/flutter_modular.dart';

import 'infra/datasources/i_qrcode_datasource.dart';
import 'infra/datasources/qrcode_datasource_impl.dart';
import 'infra/repository/i_qrcode_repository.dart';
import 'infra/repository/qrcode_repository.dart';
import 'page/qrcode_controller.dart';
import 'page/qrcode_page.dart';

class QrCodeModule extends Module {
  @override
  List<Bind> get binds => [
        Bind<IQrCodeDataSource>((i) => QrCodeDataSourceImpl(i(), i())),
        Bind<IQrCodeRepository>((i) => QrCodeRepositoryImpl(i())),
        Bind<QrCodeController>((i) => QrCodeController())
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute("/",
            child: (context, args) => QrCodePage(
                  controller: Modular.get(),
                ))
      ];
}
