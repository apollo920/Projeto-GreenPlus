import '../../models/curso.dart';

abstract class ICursoDataSource {
  Future<List<Curso>?> getCursos();
}
