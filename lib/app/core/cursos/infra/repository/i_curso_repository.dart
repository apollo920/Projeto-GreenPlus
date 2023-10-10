import 'package:dartz/dartz.dart';

import '../../../../core/erros/erros.dart';
import '../../models/curso.dart';

abstract class ICursoRepository {
  Future<Either<Failure, List<Curso>>> getCursos();
}
