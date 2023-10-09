
import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:greenplus/app/core/controllers/auth/auth_store.dart';
import 'package:greenplus/app/features/escolha_adm/escolha_adm_module.dart';
import 'package:greenplus/app/features/home/home_module.dart';

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
    Bind((i) => AuthStore(i()))
  ];

  @override
  List<ModularRoute> get routes => [
    ModuleRoute('/auth', module: AuthModule()),
    ModuleRoute('/escadm', module: EscolhaAdmModule()),
    ModuleRoute('/home', module: HomeModule()),
  ];
}