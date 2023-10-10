import 'package:dartz/dartz.dart';

import 'package:greenplus/app/core/erros/erros.dart';

import '../../models/curso.dart';
import '../datasources/i_curso_datasource.dart';
import 'i_curso_repository.dart';

class CursoRepositoryImpl extends ICursoRepository{

  final ICursoDataSource dataSource;

  CursoRepositoryImpl(this.dataSource);
  @override
  Future<Either<Failure, List<Curso>>> getCursos() async {
    try {
      List<Curso>? listaCursos = await dataSource.getCursos();

      if (listaCursos == null) {
        return Left(DataSourceEmpty());
      }

      return Right(listaCursos);
    } catch (e) {
      return Left(DataSourceException());
    }
  }


}