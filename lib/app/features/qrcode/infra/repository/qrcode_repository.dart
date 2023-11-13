import 'package:dartz/dartz.dart';

import 'package:greenplus/app/core/erros/erros.dart';

import 'package:greenplus/app/features/qrcode/models/qrcode.dart';

import '../datasources/i_qrcode_datasource.dart';
import 'i_qrcode_repository.dart';

class QrCodeRepositoryImpl extends IQrCodeRepository {
  final IQrCodeDataSource dataSource;

  QrCodeRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, List<QrCodeModel>>> getQrCodes(
      {required String idCurso, required String idPeriodo}) async {
    try {
      List<QrCodeModel>? listaQrCode =
          await dataSource.getQrCodes(idCurso: idCurso, idPeriodo: idPeriodo);

      if (listaQrCode == null) {
        return Left(DataSourceEmpty());
      }

      return Right(listaQrCode);
    } catch (e) {
      return Left(DataSourceException());
    }
  }

  @override
  Future<Either<Failure, String>> addQrCode(
      {required String idCurso,
      required String idPeriodo,
      required QrCodeModel qrCodeModel}) async {
    try {
      String? idQr = await dataSource.addQrCode(
          idCurso: idCurso, idPeriodo: idPeriodo, qrCodeModel: qrCodeModel);

      if (idQr == null || idQr.isEmpty) {
        return Left(DataSourceEmpty());
      }

      return Right(idQr);
    } catch (e) {
      return Left(DataSourceException());
    }
  }

  @override
  Future<Either<Failure, String>> deleteQrCode(
      {required String idCurso,
      required String idPeriodo,
      required String idQrcode}) async {
    try {
      String? idQr = await dataSource.deleteQrCode(
          idCurso: idCurso, idPeriodo: idPeriodo, idQrcode: idQrcode);

      if (idQr == null || idQr.isEmpty) {
        return Left(DataSourceEmpty());
      }

      return Right(idQr);
    } catch (e) {
      return Left(DataSourceException());
    }
  }
}
