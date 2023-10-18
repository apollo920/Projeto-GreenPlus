import '../../models/eventos.dart';

abstract class IEventosDataSource {
  Future<List<EventoModel>?> getEventos({required String idCurso});
  Future<String?> addEventos({required String idCurso,  required EventoModel eventoModel});
  Future<String?> deleteEventos({required String idCurso, required int idEvento});
}
