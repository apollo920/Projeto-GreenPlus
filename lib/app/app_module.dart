
import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:greenplus/app/core/controllers/auth/auth_store.dart';
import 'package:greenplus/app/core/cursos/infra/datasources/curso_datasource_impl.dart';
import 'package:greenplus/app/core/cursos/infra/datasources/i_curso_datasource.dart';
import 'package:greenplus/app/core/cursos/infra/repository/curso_repository.dart';
import 'package:greenplus/app/core/cursos/infra/repository/i_curso_repository.dart';
import 'package:greenplus/app/core/cursos/page/cursos_page.dart';
import 'package:greenplus/app/core/periodos/infra/datasources/i_periodos_datasource.dart';
import 'package:greenplus/app/core/periodos/infra/repository/i_periodos_repository.dart';
import 'package:greenplus/app/core/periodos/page/periodos_controller.dart';
import 'package:greenplus/app/features/avisos/page/avisos_page.dart';
import 'package:greenplus/app/features/eventos/infra/datasources/eventos_datasource_impl.dart';
import 'package:greenplus/app/features/eventos/infra/datasources/i_eventos_datasource.dart';
import 'package:greenplus/app/features/eventos/infra/repository/eventos_repository.dart';
import 'package:greenplus/app/features/eventos/infra/repository/i_eventos_repository.dart';
import 'package:greenplus/app/features/eventos/pages/eventos_controller.dart';
import 'package:greenplus/app/features/eventos/pages/eventos_tela_de_descanso.dart';
import 'package:greenplus/app/features/home/home_module.dart';
import 'core/cursos/page/curso_controller.dart';
import 'core/infra/client_http/client_http_impl.dart';
import 'core/infra/client_http/i_client_http.dart';
import 'core/infra/local_storage/i_local_secure_storage.dart';
import 'core/infra/local_storage/local_secure_storage_impl.dart';
import 'core/periodos/infra/datasources/periodos_datasource_impl.dart';
import 'core/periodos/infra/repository/periodos_repository.dart';
import 'features/auth/auth_module.dart';
import 'features/auth/login/login_module.dart';
import 'features/eventos/eventos_module.dart';
import 'features/horarios/horarios_module.dart';
import 'features/qrcode/qrcode_module.dart';

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
    Bind((i) => CursoController(i())),
    Bind<IPeriodosDataSource>((i) => PeriodosDataSourceImpl(i(), i())),
    Bind<IPeriodosRepository>((i) => PeriodosRepositoryImpl(i())),
    Bind((i) => PeriodosController(i())),
    Bind<IEventosDataSource>((i) => EventosDataSourceImpl(i(), i())),
    Bind<IEventosRepository>((i) => EventosRepositoryImpl(i())),
    Bind((i) => EventosController(i(),i())),
  ];

  @override
  List<ModularRoute> get routes => [
    ModuleRoute('/auth', module: AuthModule()),
    ModuleRoute('/home', module: HomeModule()),
    ModuleRoute('/qrcode', module: QrCodeModule()),
    ModuleRoute('/eventos', module: EventosModule()),
    ModuleRoute('/horarios', module: HorariosModule()),
    ChildRoute("/timeout", child:  (context, args) => TimeoutScreen(controller: Modular.get())),
    ChildRoute("/cursos", child:  (context, args) => CursosPage(controller: Modular.get(), callBack: args.data,)),
    //ChildRoute("/periodos/:idCurso", child:  (context, args) => PeriodosPage(controller: Modular.get(), idCurso: args.params['idCurso'],)),
    ChildRoute("/avisos", child:  (context, args) => const AvisosPage()),
  ];
}