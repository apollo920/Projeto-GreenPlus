
abstract class IHorariosDataSource {
  Future<String?> getHorarios({required String idCurso});
  Future<String?> changeHorarios({required String idCurso, required String base64});
}
