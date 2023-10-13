import 'package:dartz/dartz.dart';

import '../../../../core/erros/erros.dart';
import '../../models/qrcode.dart';

abstract class IQrCodeRepository {
  Future<Either<Failure, List<QrCodeModel>>> getQrCodes();
}
