import '../../../../core/erros/erros.dart';
import '../../../../core/infra/client_http/i_client_http.dart';
import '../../../../core/infra/local_storage/i_local_secure_storage.dart';
import '../../../../core/utils/api_routes.dart';
import 'i_horarios_datasource.dart';

class HorariosDataSourceImpl implements IHorariosDataSource {
  final IClientHttp clientHttp;
  final ILocalSecureStorage localStorage;

  HorariosDataSourceImpl(this.clientHttp, this.localStorage);

  @override
  Future<String?> getHorarios({required String idCurso}) async {
    var result =
        await clientHttp.get(url: ApiRoutes.GETHORARIOS(idCurso: idCurso));
    if (result.statusCode == 200) {
      var json = result.data;
      var horario = json['data'] as String?;
      return horario;
    } else if (result.statusCode != 500) {
      var json = result.data;
      throw Failure(message: json['message'] ?? "Erro na consulta");
    } else {
      throw Failure();
    }

    // return listaHorariosByCursos[idCurso];
  }

  @override
  Future<String?> changeHorarios(
      {required String idCurso, required String base64}) async {
    var result = await clientHttp.put(
        url: ApiRoutes.CHANGEHORARIOS(idCurso: idCurso, base64: base64),
        body: base64);
    if (result.statusCode == 200) {
      var json = result.data;
      var horario = json['data'] as String?;
      return horario;
    } else if (result.statusCode != 500) {
      var json = result.data;
      throw Failure(message: json['message'] ?? "Erro na consulta");
    } else {
      throw Failure();
    }
    //   try {
    //     listaHorariosByCursos[idCurso] = base64;
    //     var horariosList = listaHorariosByCursos[idCurso];
    //     if (horariosList != null) {
    //       return horariosList;
    //     }
    //   } on Exception catch (e) {
    //     return null;
    //   }
    //   return null;
    // }
  }

  var listaHorariosByCursos = {"1": '', "2": '', "3": ''};
}
