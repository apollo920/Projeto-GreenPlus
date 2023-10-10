
import '../../../../core/infra/client_http/i_client_http.dart';
import '../../../../core/infra/local_storage/i_local_secure_storage.dart';
import '../../models/curso.dart';
import 'i_curso_datasource.dart';

class CursoDataSourceImpl implements ICursoDataSource {
  final IClientHttp clientHttp;
  final ILocalSecureStorage localStorage;

  CursoDataSourceImpl(this.clientHttp, this.localStorage);

  @override
  Future<List<Curso>?> getCursos() async {
    return listaCursos.map((curso) => Curso.fromMap(curso)).toList();

    // var result = await clientHttp.get(url: "/users/checktoken");
    // if (result.statusCode == 200) {
    //   return true;
    // } else if (result.statusCode != 500) {
    //   return false;
    // } else {
    //   throw Failure();
    // }
  }


  var listaCursos = [
    {
      "nome": "Engenharia de software",
      "action": "/periodos/1",
      "icon": "0xf051f"
    },{
      "nome": "Direito",
      "action": "/periodos/2",
      "icon": "0xe821"
    },
    {
      "nome": "Administração",
      "action": "/periodos/3",
      "icon": "0xef11"
    }
  ];
}
