
import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:greenplus/app/core/controllers/auth/auth_store.dart';
import 'package:greenplus/app/core/cursos/infra/datasources/curso_datasource_impl.dart';
import 'package:greenplus/app/core/cursos/infra/datasources/i_curso_datasource.dart';
import 'package:greenplus/app/core/cursos/infra/repository/curso_repository.dart';
import 'package:greenplus/app/core/cursos/infra/repository/i_curso_repository.dart';
import 'package:greenplus/app/core/cursos/page/cursos_page.dart';
import 'package:greenplus/app/features/escolha_adm/escolha_adm_module.dart';
import 'package:greenplus/app/features/home/home_module.dart';

import 'core/cursos/page/curso_controller.dart';
import 'core/infra/client_http/client_http_impl.dart';
import 'core/infra/client_http/i_client_http.dart';
import 'core/infra/local_storage/i_local_secure_storage.dart';
import 'core/infra/local_storage/local_secure_storage_impl.dart';
import 'features/auth/auth_module.dart';
import 'features/auth/login/login_module.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
    Bind.instance<Dio>(Dio()),
    Bind.instance<FlutterSecureStorage>(const FlutterSecureStorage()),
    Bind<ILocalSecureStorage>((i) => LocalSecureStorageImpl(i())),
    Bind<IClientHttp>((i) => ClientHttpImpl(i())),
    ...LoginModule.export,
    Bind((i) => AuthStore(i())),
    Bind<ICursoDataSource>((i) => CursoDataSourceImpl(i(), i())),
    Bind<ICursoRepository>((i) => CursoRepositoryImpl(i())),
    Bind((i) => CursoController(i()))

  ];

  @override
  List<ModularRoute> get routes => [
    ModuleRoute('/auth', module: AuthModule()),
    ModuleRoute('/escadm', module: EscolhaAdmModule()),
    ModuleRoute('/home', module: HomeModule()),
    ChildRoute("/cursos", child:  (context, args) => CursosPage(controller: Modular.get(),)),
  ];
}