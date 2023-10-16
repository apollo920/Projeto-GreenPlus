import 'package:dartz/dartz.dart';

import '../../../../core/erros/erros.dart';
import '../../models/qrcode.dart';

abstract class IQrCodeRepository {
  Future<Either<Failure, List<QrCodeModel>>> getQrCodes({required String idCurso, required String idPeriodo});
  Future<Either<Failure, String>> addQrCode({required String idCurso, required String idPeriodo, required QrCodeModel qrCodeModel});
  Future<Either<Failure, String>> deleteQrCode({required String idCurso, required String idPeriodo, required int idQrcode});
}
