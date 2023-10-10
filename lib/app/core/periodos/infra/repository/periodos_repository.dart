import 'package:dartz/dartz.dart';

import 'package:greenplus/app/core/erros/erros.dart';

import '../../models/periodo.dart';
import '../datasources/i_periodos_datasource.dart';
import 'i_periodos_repository.dart';

class PeriodosRepositoryImpl extends IPeriodosRepository{

  final IPeriodosDataSource dataSource;

  PeriodosRepositoryImpl(this.dataSource);
  @override
  Future<Either<Failure, List<Periodo>>> getPeriodos({required String idCurso}) async {
    try {
      List<Periodo>? listaPeriodoss = await dataSource.getPeriodos(idCurso: idCurso);

      if (listaPeriodoss == null) {
        return Left(DataSourceEmpty());
      }

      return Right(listaPeriodoss);
    } catch (e) {
      return Left(DataSourceException());
    }
  }


}