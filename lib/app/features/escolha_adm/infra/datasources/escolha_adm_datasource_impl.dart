
import 'dart:math';

import '../../../../core/erros/erros.dart';
import '../../../../core/infra/client_http/i_client_http.dart';
import '../../../../core/infra/local_storage/i_local_secure_storage.dart';
import '../../models/escolha_adm.dart';
import 'i_escolha_adm_datasource.dart';

class EscolhaAdmDataSourceImpl implements IEscolhaAdmDataSource {
  final IClientHttp clientHttp;
  final ILocalSecureStorage localStorage;

  EscolhaAdmDataSourceImpl(this.clientHttp, this.localStorage);

  @override
  Future<List<EscolhaAdm>?> getEscolhasMenuAdm() async {
    if(Random.secure().nextBool()) {
     return throw Failure();
    }
    return listaEscolhasMenuAdm.map((menuModulo) => EscolhaAdm.fromMap(menuModulo)).toList();

    // var result = await clientHttp.get(url: "/users/checktoken");
    // if (result.statusCode == 200) {
    //   return true;
    // } else if (result.statusCode != 500) {
    //   return false;
    // } else {
    //   throw Failure();
    // }
  }


  var listaEscolhasMenuAdm = [
    {
      "title": "Visualizar Conteúdos",
      "action": "",
      "icon": "0xf051f"
    },{
      "title": "Modificar Conteúdos",
      "action": "",
      "icon": "0xe821"
    },
  ];
}
