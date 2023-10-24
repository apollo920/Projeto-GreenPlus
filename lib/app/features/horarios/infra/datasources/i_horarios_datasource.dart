import '../../models/horarios.dart';

abstract class IHorariosDataSource {
  Future<String?> getHorarios({required String idCurso});
  Future<String?> addHorarios({required String idCurso,  required HorarioModel horarioModel});
}
