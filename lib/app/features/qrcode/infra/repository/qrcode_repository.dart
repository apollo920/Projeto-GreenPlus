import 'package:dartz/dartz.dart';

import 'package:greenplus/app/core/erros/erros.dart';


import 'package:greenplus/app/features/qrcode/models/qrcode.dart';

import '../datasources/i_qrcode_datasource.dart';
import 'i_qrcode_repository.dart';

class QrCodeRepositoryImpl extends IQrCodeRepository{

  final IQrCodeDataSource dataSource;

  QrCodeRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, List<QrCodeModel>>> getQrCodes() async {
    try {
      List<QrCodeModel>? listaQrCode = await dataSource.getQrCodes();

      if (listaQrCode == null) {
        return Left(DataSourceEmpty());
      }

      return Right(listaQrCode);
    } catch (e) {
      return Left(DataSourceException());
    }
  }


}