import '../../../../core/infra/client_http/i_client_http.dart';
import '../../../../core/infra/local_storage/i_local_secure_storage.dart';
import '../../models/eventos.dart';
import 'i_eventos_datasource.dart';

class EventosDataSourceImpl implements IEventosDataSource {
  final IClientHttp clientHttp;
  final ILocalSecureStorage localStorage;

  EventosDataSourceImpl(this.clientHttp, this.localStorage);

  @override
  Future<List<EventoModel>?> getEventos(
      {required String idCurso}) async {
    return listaEventosByCursos[idCurso]?.map((evento) => EventoModel.fromMap(evento)).toList();
  }

  @override
  Future<String?> addEventos(
      {required String idCurso,  required EventoModel eventoModel}) async {
    try {
      String id =
          (listaEventosByCursos[idCurso]!.length + 1)
              .toString();
      var newEventos = eventoModel.toMap();
      newEventos['id'] = id;
      listaEventosByCursos[idCurso]?.add(newEventos);
      String idAll =
          (listaEventosByCursos['all']!.length + 1)
              .toString();
      var newEventosAll = eventoModel.toMap();
      newEventosAll['id'] = idAll;
      listaEventosByCursos['all']?.add(newEventosAll);
      return id;
    } on Exception catch (e) {
      return null;
    }
  }

 @override
Future<String?> deleteEventos(
    {required String idCurso,
    required int idEvento}) async {
  try {
    var qrCodes = listaEventosByCursos[idCurso];
    var qrCodesAll = listaEventosByCursos['all'];
    if (qrCodesAll != null) {
      for (int i = 0; i < qrCodes!.length; i++) {
        for (int j = 0; j < qrCodesAll.length; j++) {
          if (qrCodes[i]['image'] == qrCodesAll[j]['image']) {
          qrCodesAll.removeAt(j);
            }
          }
        }
      }
    if (qrCodes != null) {
      for (int i = 0; i < qrCodes.length; i++) {
        if (qrCodes[i]['id'] == idEvento.toString()) {
          qrCodes.removeAt(i);
          return idEvento.toString();
        }
      }
    }
    return null;
  } on Exception catch (e) {
    return null;
  }
}


// var result = await clientHttp.get(url: "/cursos/:idCurso");
// if (result.statusCode == 200) {
//   return true;
// } else if (result.statusCode != 500) {
//   return false;
// } else {
//   throw Failure();
// }
}

var listaEventosByCursos = {
  "1": [],
  "2": [],
  "all":[]
};
