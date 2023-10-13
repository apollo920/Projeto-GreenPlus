
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
    return listaMenuModulo.map((menuModulo) => MenuModulo.fromMap(menuModulo)).toList();

    // var result = await clientHttp.get(url: "/users/checktoken");
    // if (result.statusCode == 200) {
    //   return true;
    // } else if (result.statusCode != 500) {
    //   return false;
    // } else {
    //   throw Failure();
    // }
  }


  var listaMenuModulo = [
    {
      "title": "Calendário acadêmico",
      "action": "",
      "icon": "0xf051f"
    },{
      "title": "Horários",
      "action": "/cursos",
      "icon": "0xe821"
    },
    {
      "title": "Avisos",
      "action": "/avisos",
      "icon": "0xef11"
    },
    {
      "title": "Calendário de provas",
      "action": "/cursos",
      "icon": "0xf0401"
    },
    {
      "title": "Eventos",
      "action": "/cursos",
      "icon": "0xe23e"
    },
    {
      "title": "Qrcodes",
      "action": "/qrcode",
      "icon": "0xe4f5"
    },
  ];
}
