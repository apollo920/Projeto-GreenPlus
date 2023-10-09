import 'package:flutter_modular/flutter_modular.dart';
import 'package:greenplus/app/features/home/infra/datasources/home_datasource_impl.dart';
import 'package:greenplus/app/features/home/infra/repository/home_repository.dart';
import 'package:greenplus/app/features/home/infra/repository/i_home_repository.dart';
import 'package:greenplus/app/features/home/page/home_controller.dart';
import 'package:greenplus/app/features/home/page/home_page.dart';

import 'infra/datasources/i_home_datasource.dart';

class HomeModule extends Module {

  @override
  List<Bind> get binds => [
    Bind<IHomeDataSource>((i) => HomeDataSourceImpl(i(), i())),
    Bind<IHomeRepository>((i) => HomeRepositoryImpl(i())),
    Bind<HomeController>((i) => HomeController(i(), i()))
  ];

  @override
  List<ModularRoute> get routes => [ChildRoute("/", child:  (context, args) => HomePage(controller: Modular.get(),))];
}
