
import 'package:flutter_modular/flutter_modular.dart';
import 'package:greenplus/app/features/eventos/pages/eventos_carrossel.dart';
import 'infra/datasources/eventos_datasource_impl.dart';
import 'infra/datasources/i_eventos_datasource.dart';
import 'infra/repository/eventos_repository.dart';
import 'infra/repository/i_eventos_repository.dart';
import 'pages/eventos_controller.dart';
import 'pages/eventos_page.dart';

class EventosModule extends Module {
  @override
  List<Bind> get binds => [
        Bind<IEventosDataSource>((i) => EventosDataSourceImpl(i(), i())),
        Bind<IEventosRepository>((i) => EventosRepositoryImpl(i())),
        Bind<EventosController>((i) => EventosController(i(), i()))
      ];

  @override
  List<ModularRoute> get routes => [
    ChildRoute("/",child: (context, args) => EventosPage(controller: Modular.get())),
    ChildRoute("/eventoslist/:idCurso", child:  (context, args) => EventosCarousel(controller: Modular.get(), idCurso: args.params['idCurso'],)),
    ChildRoute("/eventospicker", child:  (context, args) => const EventosPickerService()),
  ];
}
