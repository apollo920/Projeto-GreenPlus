import 'package:greenplus/app/core/utils/api_routes.dart';

import '../../../../core/erros/erros.dart';
import '../../../../core/infra/client_http/i_client_http.dart';
import '../../../../core/infra/local_storage/i_local_secure_storage.dart';
import '../../models/menu_modulo.dart';
import 'i_home_datasource.dart';

class HomeDataSourceImpl implements IHomeDataSource {
  final IClientHttp clientHttp;
  final ILocalSecureStorage localStorage;

  HomeDataSourceImpl(this.clientHttp, this.localStorage);

  @override
  Future<List<MenuModulo>?> getMenusMedulos() async {

    var result = await clientHttp.get(url: ApiRoutes.HOME);
    if (result.statusCode == 200) {
      var json = result.data;
      var menus = json['data'] as List?;
      await Future.delayed(Duration(seconds: 2));
      return menus?.map((menuModulo) => MenuModulo.fromMap(menuModulo)).toList();
    } else if (result.statusCode != 500) {
      print(result.data);
      var json = result.data;
      throw Failure(message: json['message'] ?? "Erro na consulta");
    } else {
      throw Failure();
    }
  }

  var listaMenuModulo = [
    {"title": "Calendário acadêmico", "action": "", "icon": "0xf051f"},
    {"title": "Horários", "action": "/horarios", "icon": "0xe821"},
    {"title": "Eventos", "action": "/eventos", "icon": "0xe23e"},
    {"title": "Qrcodes", "action": "/qrcode", "icon": "0xe4f5"},
  ];
}
