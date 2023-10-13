
import '../../../../core/infra/client_http/i_client_http.dart';
import '../../../../core/infra/local_storage/i_local_secure_storage.dart';
import '../../models/home_adm.dart';
import 'i_home_adm_datasource.dart';

class HomeAdmDataSourceImpl implements IHomeAdmDataSource {
  final IClientHttp clientHttp;
  final ILocalSecureStorage localStorage;

  HomeAdmDataSourceImpl(this.clientHttp, this.localStorage);

  @override
  Future<List<HomeAdm>?> getHomeMenuAdm() async {
    
    return listaHomeMenuAdm.map((homeAdm) => HomeAdm.fromMap(homeAdm)).toList();

    // var result = await clientHttp.get(url: "/users/checktoken");
    // if (result.statusCode == 200) {
    //   return true;
    // } else if (result.statusCode != 500) {
    //   return false;
    // } else {
    //   throw Failure();
    // }
  }


  var listaHomeMenuAdm = [
    {
      "title": "Visualizar Conteúdos",
      "action": "/home",
      "icon": "0xf051f"
    },{
      "title": "Modificar Conteúdos",
      "action": "",
      "icon": "0xe821"
    },
  ];
}
