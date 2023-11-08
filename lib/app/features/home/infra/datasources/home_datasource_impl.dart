import 'package:greenplus/app/core/utils/api_routes.dart';

import '../../../../core/erros/erros.dart';
import '../../../../core/infra/client_http/i_client_http.dart';
import '../../../../core/infra/local_storage/i_local_secure_storage.dart';
import '../../models/menu_modulo.dart';
import 'i_home_datasource.dart';

class HomeDataSourceImpl implements IHomeDataSource {
  final IClientHttp clientHttp;
  final ILocalSecureStorage localStorage;

  HomeDataSourceImpl(this.clientHttp, this.localStorage);

  @override
  Future<List<MenuModulo>?> getMenusMedulos() async {

    var result = await clientHttp.get(url: ApiRoutes.MENU);
    if (result.statusCode == 200) {
      print(result);
      var json = result.data;
      var menus = json['data'] as List?;
      // print(menus);
      return menus?.map((menuModulo) => MenuModulo.fromMap(menuModulo)).toList();
    } else if (result.statusCode != 500) {
      var json = result.data;
      throw Failure(message: json['message'] ?? "Erro na consulta");
    } else {
      throw Failure();
    }
  }
}
