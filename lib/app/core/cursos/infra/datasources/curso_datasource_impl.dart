
import '../../../../core/infra/client_http/i_client_http.dart';
import '../../../../core/infra/local_storage/i_local_secure_storage.dart';
import '../../../erros/erros.dart';
import '../../../utils/api_routes.dart';
import '../../models/curso.dart';
import 'i_curso_datasource.dart';

class CursoDataSourceImpl implements ICursoDataSource {
  final IClientHttp clientHttp;
  final ILocalSecureStorage localStorage;

  CursoDataSourceImpl(this.clientHttp, this.localStorage);

  @override
  Future<List<Curso>?> getCursos() async {
    var result = await clientHttp.get(url: ApiRoutes.CURSOS);
    if (result.statusCode == 200) {
      var json = result.data;
      var cursos = json['data'] as List?;
      return cursos?.map((curso) => Curso.fromMap(curso)).toList();
    } else if (result.statusCode != 500) {
      var json = result.data;
      throw Failure(message: json['message'] ?? "Erro na consulta");
    } else {
      throw Failure();
    }

  }


  var listaCursos = [
    {
      "nome": "Engenharia\n de software",
      "action": "/periodos/1",
      "id": "1",
      "icon": "0xe185"
    },{
      "nome": "Direito",
      "action": "/periodos/2",
      "id": "2",
      "icon": "0xf1c2"
    },
    {
      "nome": "Administração",
      "action": "/periodos/3",
      "id": "3",
      "icon": "0xf085d"
    }
  ];
}
