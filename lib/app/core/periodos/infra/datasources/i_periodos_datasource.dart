import '../../models/periodo.dart';

abstract class IPeriodosDataSource {
  Future<List<Periodo>?> getPeriodos({required String idCurso});
}
