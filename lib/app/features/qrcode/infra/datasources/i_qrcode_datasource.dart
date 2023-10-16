import '../../models/qrcode.dart';

abstract class IQrCodeDataSource {
  Future<List<QrCodeModel>?> getQrCodes({required String idCurso, required String idPeriodo});
  Future<String?> addQrCode({required String idCurso, required String idPeriodo, required QrCodeModel qrCodeModel});
  Future<String?> deleteQrCode({required String idCurso, required String idPeriodo, required int idQrcode});
}
