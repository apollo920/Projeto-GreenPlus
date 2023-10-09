import 'package:flutter_modular/flutter_modular.dart';
import 'package:greenplus/app/features/escolha_adm/infra/datasources/escolha_adm_datasource_impl.dart';
import 'package:greenplus/app/features/escolha_adm/infra/repository/escolha_adm_repository.dart';
import 'package:greenplus/app/features/escolha_adm/infra/repository/i_escolha_adm_repository.dart';
import 'package:greenplus/app/features/escolha_adm/page/escolha_adm_controller.dart';
import 'package:greenplus/app/features/escolha_adm/page/escolha_adm_page.dart';

import 'infra/datasources/i_escolha_adm_datasource.dart';

class EscolhaAdmModule extends Module {

  @override
  List<Bind> get binds => [
    Bind<IEscolhaAdmDataSource>((i) => EscolhaAdmDataSourceImpl(i(), i())),
    Bind<IEscolhaAdmRepository>((i) => EscolhaAdmRepositoryImpl(i())),
    Bind<EscolhaAdmController>((i) => EscolhaAdmController(i(), i()))
  ];

  @override
  List<ModularRoute> get routes => [ChildRoute("/", child:  (context, args) => EscolhaAdmPage(controller: Modular.get(),))];
}
