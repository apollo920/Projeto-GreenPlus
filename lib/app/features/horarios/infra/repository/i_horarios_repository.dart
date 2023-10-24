import 'package:dartz/dartz.dart';

import '../../../../core/erros/erros.dart';
import '../../models/horarios.dart';

abstract class IHorariosRepository {
  Future<Either<Failure, String?>> getHorarios({required String idCurso});
  Future<Either<Failure, String>> addHorarios({required String idCurso,  required HorarioModel horarioModel});
}
