import '../../models/menu_modulo.dart';

abstract class IHomeDataSource {
  Future<List<MenuModulo>?> getMenusMedulos();
}
