import 'package:flutter_modular/flutter_modular.dart';
import 'package:greenplus/app/features/home_adm/infra/datasources/home_adm_datasource_impl.dart';
import 'package:greenplus/app/features/home_adm/infra/repository/home_adm_repository.dart';
import 'package:greenplus/app/features/home_adm/infra/repository/i_home_adm_repository.dart';
import 'package:greenplus/app/features/home_adm/page/home_adm_controller.dart';
import 'package:greenplus/app/features/home_adm/page/home_adm_page.dart';

import 'infra/datasources/i_home_adm_datasource.dart';

class HomeAdmModule extends Module {

  @override
  List<Bind> get binds => [
    Bind<IHomeAdmDataSource>((i) => HomeAdmDataSourceImpl(i(), i())),
    Bind<IHomeAdmRepository>((i) => HomeAdmRepositoryImpl(i())),
    Bind<HomeAdmController>((i) => HomeAdmController(i(), i()))
  ];

  @override
  List<ModularRoute> get routes => [ChildRoute("/", child:  (context, args) => HomeAdmPage(controller: Modular.get(),))];
}
