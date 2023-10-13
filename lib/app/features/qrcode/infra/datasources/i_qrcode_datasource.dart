import '../../models/qrcode.dart';

abstract class IQrCodeDataSource {
  Future<List<QrCodeModel>?> getQrCodes();
}
