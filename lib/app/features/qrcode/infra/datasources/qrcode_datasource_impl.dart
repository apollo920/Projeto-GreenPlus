
import '../../../../core/infra/client_http/i_client_http.dart';
import '../../../../core/infra/local_storage/i_local_secure_storage.dart';
import '../../models/qrcode.dart';
import 'i_qrcode_datasource.dart';

class QrCodeDataSourceImpl implements IQrCodeDataSource {
  final IClientHttp clientHttp;
  final ILocalSecureStorage localStorage;

  QrCodeDataSourceImpl(this.clientHttp, this.localStorage);

  @override
  Future<List<QrCode>?> getQrCodes() async {
    return listaQrCode.map((menuModulo) => QrCode.fromMap(menuModulo)).toList();

    // var result = await clientHttp.get(url: "/users/checktoken");
    // if (result.statusCode == 200) {
    //   return true;
    // } else if (result.statusCode != 500) {
    //   return false;
    // } else {
    //   throw Failure();
    // }
  }


  var listaQrCode = [
    {
      "title": "Calendário acadêmico",
      "action": "",
      "icon": "0xf051f"
    },
  ];
}
