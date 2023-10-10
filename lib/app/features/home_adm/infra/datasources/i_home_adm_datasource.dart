import '../../models/home_adm.dart';

abstract class IHomeAdmDataSource {
  Future<List<HomeAdm>?> getHomeMenuAdm();
}
