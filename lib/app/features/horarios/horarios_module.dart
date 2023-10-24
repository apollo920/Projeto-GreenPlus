
import 'package:flutter_modular/flutter_modular.dart';
import 'infra/datasources/horarios_datasource_impl.dart';
import 'infra/datasources/i_horarios_datasource.dart';
import 'infra/repository/horarios_repository.dart';
import 'infra/repository/i_horarios_repository.dart';
import 'pages/horarios_controller.dart';
import 'pages/horarios_page.dart';
import 'pages/horarios_pdf.dart';

class HorariosModule extends Module {
  @override
  List<Bind> get binds => [
        Bind<IHorariosDataSource>((i) => HorariosDataSourceImpl(i(), i())),
        Bind<IHorariosRepository>((i) => HorariosRepositoryImpl(i())),
        Bind<HorariosController>((i) => HorariosController(i(), i()))
      ];

  @override
  List<ModularRoute> get routes => [
    ChildRoute("/",child: (context, args) => HorariosPage(controller: Modular.get())),
    ChildRoute("/horariospdf/:idCurso", child:  (context, args) => PDFScreen(controller: Modular.get(), idCurso: args.params['idCurso'],)),
  ];
}
