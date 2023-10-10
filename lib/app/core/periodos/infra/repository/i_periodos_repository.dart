import 'package:dartz/dartz.dart';

import '../../../../core/erros/erros.dart';
import '../../models/periodo.dart';

abstract class IPeriodosRepository {
  Future<Either<Failure, List<Periodo>>> getPeriodos({required String idCurso});
}
