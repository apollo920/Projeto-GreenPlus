import 'package:flutter_modular/flutter_modular.dart';

import 'infra/datasources/i_login_datasource.dart';
import 'infra/datasources/login_datasource_impl.dart';
import 'infra/repository/i_login_repository.dart';
import 'infra/repository/login_repository.dart';
import 'page/login_controller.dart';
import 'page/login_page.dart';

class LoginModule extends Module {

  static List<Bind> export = [
    Bind<ILoginDataSource>((i) => LoginDataSourceImpl(i(), i())),
    Bind<ILoginRepository>((i) => LoginRepositoryImpl(i())),
  ];

  @override
  List<Bind> get binds => [Bind<LoginController>((i) => LoginController(i(), i()))];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/',
            child: (context, args) => LoginPage(controller: Modular.get(),)),
      ];
}
