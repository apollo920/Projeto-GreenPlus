import 'package:flutter_modular/flutter_modular.dart';
import 'package:greenplus/app/core/utils/api_routes.dart';
import '../../../../core/erros/erros.dart';
import '../../../../core/infra/client_http/i_client_http.dart';
import '../../../../core/infra/local_storage/i_local_secure_storage.dart';
import '../../models/eventos.dart';
import 'i_eventos_datasource.dart';

class EventosDataSourceImpl implements IEventosDataSource {
  final IClientHttp clientHttp;
  final ILocalSecureStorage localStorage;

  EventosDataSourceImpl(this.clientHttp, this.localStorage);

  @override
  Future<List<EventoModel>?> getEventos({required String idCurso}) async {
    var result =
        await clientHttp.get(url: ApiRoutes.GETEVENTOS(idCurso: idCurso));
    if (result.statusCode == 200 || result.statusCode == 404) {
      var json = result.data;
      var eventos = json['data'] as List?;
      return eventos?.map((evento) => EventoModel.fromMap(evento)).toList();
    } else if (result.statusCode != 500) {
      var json = result.data;
      throw Failure(message: json['message'] ?? "Erro na consulta");
    } else {
      throw Failure();
    }

    // return listaEventosByCursos[idCurso]?.map((evento) => EventoModel.fromMap(evento)).toList();
  }

  @override
  Future<List<EventoModel>?> getAllEventos() async {
    var result = await clientHttp.get(url: ApiRoutes.GETALLEVENTOS);
    if (result.statusCode == 200 || result.statusCode == 404) {
      var json = result.data;
      var allEventos = json['data'] as List?;
      return allEventos
          ?.map((allEvento) => EventoModel.fromMap(allEvento))
          .toList();
    } else if (result.statusCode == 401) {
      Modular.to.pop();
      return [];
    } else if (result.statusCode != 500) {
      var json = result.data;
      throw Failure(message: json['message'] ?? "Erro na consulta");
    } else {
      throw Failure();
    }

    // List<EventoModel> allEventos = [];
    // for (var eventos in listaEventosByCursos.values) {
    //   allEventos.addAll(eventos.map((evento) => EventoModel.fromMap(evento)).toList());
    // }
    // return allEventos;
  }

  @override
  Future<String?> addEventos(
      {required String idCurso, required EventoModel eventoModel}) async {
    var result = await clientHttp.post(
        url: ApiRoutes.ADDEVENTOS(idCurso: idCurso, eventoModel: eventoModel),
        body: eventoModel.toMap());
    if (result.statusCode == 201) {
      var json = result.data;
      var idEventos = json['data']?.toString();
      return idEventos;
    } else if (result.statusCode != 500) {
      var json = result.data;
      throw Failure(message: json['message'] ?? "Erro ao adicionar evento");
    } else {
      throw Failure();
    }

    // try {
    //   String id =
    //       (listaEventosByCursos[idCurso]!.length + 1)
    //           .toString();
    //   var newEventos = eventoModel.toMap();
    //   newEventos['id'] = id;
    //   listaEventosByCursos[idCurso]?.add(newEventos);
    //   return id;
    // } on Exception catch (e) {
    //   return null;
    // }
  }

  @override
  Future<String?> deleteEventos(
      {required String idCurso, required String idEvento}) async {
    var result = await clientHttp.delete(
        url: ApiRoutes.DELETEEVENTOS(idCurso: idCurso, idEvento: idEvento));
    if (result.statusCode == 200 || result.statusCode == 404) {
      var json = result.data;
      var idEventos = json['data'] as String?;
      return idEventos;
    } else if (result.statusCode != 500) {
      var json = result.data;
      throw Failure(message: json['message'] ?? "Erro ao deletar evento");
    } else {
      throw Failure();
    }

    // try {
    //   var qrCodes = listaEventosByCursos[idCurso];
    //   if (qrCodes != null) {
    //     for (int i = 0; i < qrCodes.length; i++) {
    //       if (qrCodes[i]['id'] == idEvento.toString()) {
    //         qrCodes.removeAt(i);
    //         return idEvento.toString();
    //       }
    //     }
    //   }
    //   return null;
    // } on Exception catch (e) {
    //   return null;
    // }
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
