import 'package:dartz/dartz.dart';

import '../../../../core/erros/erros.dart';

abstract class IHorariosRepository {
  Future<Either<Failure, String?>> getHorarios({required String idCurso});
  Future<Either<Failure, String?>> changeHorarios(
      {required String idCurso, required String base64});
}
