import 'package:dartz/dartz.dart';
import 'package:greenplus/app/core/erros/erros.dart';
import '../../models/eventos.dart';
import '../datasources/i_eventos_datasource.dart';
import 'i_eventos_repository.dart';

class EventosRepositoryImpl extends IEventosRepository {
  final IEventosDataSource dataSource;

  EventosRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, List<EventoModel>>> getEventos(
      {required String idCurso}) async {
    //try {
    List<EventoModel>? listaEventos =
        await dataSource.getEventos(idCurso: idCurso);

    if (listaEventos == null) {
      return Left(DataSourceEmpty());
    }

    return Right(listaEventos);
    // } catch (e) {
    //   return Left(DataSourceException());
    // }
  }

  @override
  Future<Either<Failure, List<EventoModel>>> getAllEventos() async {
    try {
      List<EventoModel>? listaAllEventos = await dataSource.getAllEventos();

      if (listaAllEventos == null) {
        return Left(DataSourceEmpty());
      }

      return Right(listaAllEventos);
    } catch (e) {
      return Left(DataSourceException());
    }
  }

  @override
  Future<Either<Failure, String>> addEventos(
      {required String idCurso, required EventoModel eventoModel}) async {
    try {
      String? idEv = await dataSource.addEventos(
          idCurso: idCurso, eventoModel: eventoModel);

      if (idEv == null || idEv.isEmpty) {
        return Left(DataSourceEmpty());
      }

      return Right(idEv);
    } catch (e) {
      return Left(DataSourceException());
    }
  }

  @override
  Future<Either<Failure, String>> deleteEventos(
      {required String idCurso, required String idEvento}) async {
    try {
      String? idEv =
          await dataSource.deleteEventos(idCurso: idCurso, idEvento: idEvento);

      if (idEv == null || idEv.isEmpty) {
        return Left(DataSourceEmpty());
      }

      return Right(idEv);
    } catch (e) {
      return Left(DataSourceException());
    }
  }
}
