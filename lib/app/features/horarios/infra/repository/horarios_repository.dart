import 'package:dartz/dartz.dart';
import 'package:greenplus/app/core/erros/erros.dart';
import '../datasources/i_horarios_datasource.dart';
import 'i_horarios_repository.dart';

class HorariosRepositoryImpl extends IHorariosRepository {
  final IHorariosDataSource dataSource;

  HorariosRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, String?>> getHorarios(
      {required String idCurso}) async {
    // try {
    String? listaHorarios = await dataSource.getHorarios(idCurso: idCurso);

    if (listaHorarios == null) {
      return Left(DataSourceEmpty());
    }

    return Right(listaHorarios);
    // } catch (e) {
    // return Left(DataSourceException());
    // }
  }

  @override
  Future<Either<Failure, String?>> changeHorarios(
      {required String idCurso, required String base64}) async {
    // try {
    print(2);
    String? newBase64 =
        await dataSource.changeHorarios(idCurso: idCurso, base64: base64);

    if (newBase64 == null || newBase64.isEmpty) {
      return Left(DataSourceEmpty());
    }

    return Right(newBase64);
//     } catch (e) {
//       return Left(DataSourceException());
//     }
  }
}
