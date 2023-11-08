import 'package:dartz/dartz.dart';

import '../../../../core/erros/erros.dart';
import '../../models/eventos.dart';

abstract class IEventosRepository {
  Future<Either<Failure, List<EventoModel>>> getEventos({required String idCurso});
  Future<Either<Failure, List<EventoModel>>> getAllEventos();
  Future<Either<Failure, String>> addEventos({required String idCurso,  required EventoModel eventoModel});
  Future<Either<Failure, String>> deleteEventos({required String idCurso, required int idEvento});
}
