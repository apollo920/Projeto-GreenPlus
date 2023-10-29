import 'package:dartz/dartz.dart';
import 'package:greenplus/app/core/erros/erros.dart';
import '../../models/horarios.dart';
import '../datasources/i_horarios_datasource.dart';
import 'i_horarios_repository.dart';

class HorariosRepositoryImpl extends IHorariosRepository{

  final IHorariosDataSource dataSource;

  HorariosRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, String?>> getHorarios({required String idCurso}) async {
    try {
      String? listaHorarios = await dataSource.getHorarios(idCurso: idCurso);

      if (listaHorarios == null) {
        return Left(DataSourceEmpty());
      }

      return Right(listaHorarios);
    } catch (e) {
      return Left(DataSourceException());
    }
  }

  @override
  Future<Either<Failure, String>> addHorarios({required String idCurso, required String base64}) async {
    try {
      String? idQr = await dataSource.addHorarios(idCurso: idCurso, base64: base64);

      if (idQr == null || idQr.isEmpty) {
        return Left(DataSourceEmpty());
      }

      return Right(idQr);
    } catch (e) {
      return Left(DataSourceException());
    }
  }

}