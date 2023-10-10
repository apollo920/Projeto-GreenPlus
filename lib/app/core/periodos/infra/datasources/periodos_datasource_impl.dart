import '../../../../core/infra/client_http/i_client_http.dart';
import '../../../../core/infra/local_storage/i_local_secure_storage.dart';
import '../../models/periodo.dart';
import 'i_periodos_datasource.dart';

class PeriodosDataSourceImpl implements IPeriodosDataSource {
  final IClientHttp clientHttp;
  final ILocalSecureStorage localStorage;

  PeriodosDataSourceImpl(this.clientHttp, this.localStorage);

  @override
  Future<List<Periodo>?> getPeriodos({required String idCurso}) async {
    return listaPeriodoss[idCurso]?.map((periodo) => Periodo.fromMap(periodo)).toList();

    // var result = await clientHttp.get(url: "/users/checktoken");
    // if (result.statusCode == 200) {
    //   return true;
    // } else if (result.statusCode != 500) {
    //   return false;
    // } else {
    //   throw Failure();
    // }
  }

  var listaPeriodoss = {
    "1": [
      {"nome": "Periodo 1", "action": "/periodos/1", "icon": "0xf051f"},
      {"nome": "Periodo 2", "action": "/periodos/1", "icon": "0xf051f"},
      {"nome": "Periodo 3", "action": "/periodos/1", "icon": "0xf051f"},
      {"nome": "Periodo 4", "action": "/periodos/1", "icon": "0xf051f"},
      {"nome": "Periodo 5", "action": "/periodos/1", "icon": "0xf051f"},
      {"nome": "Periodo 6", "action": "/periodos/1", "icon": "0xf051f"},
      {"nome": "Periodo 7", "action": "/periodos/1", "icon": "0xf051f"},
      {"nome": "Periodo 8", "action": "/periodos/1", "icon": "0xf051f"}
    ],
    "2": [
      {"nome": "Periodo 1", "action": "/periodos/1", "icon": "0xf051f"},
      {"nome": "Periodo 2", "action": "/periodos/1", "icon": "0xf051f"},
      {"nome": "Periodo 3", "action": "/periodos/1", "icon": "0xf051f"},
      {"nome": "Periodo 4", "action": "/periodos/1", "icon": "0xf051f"},
      {"nome": "Periodo 5", "action": "/periodos/1", "icon": "0xf051f"},
      {"nome": "Periodo 6", "action": "/periodos/1", "icon": "0xf051f"},
      {"nome": "Periodo 7", "action": "/periodos/1", "icon": "0xf051f"},
      {"nome": "Periodo 8", "action": "/periodos/1", "icon": "0xf051f"},
      {"nome": "Periodo 9", "action": "/periodos/1", "icon": "0xf051f"},
      {"nome": "Periodo 10", "action": "/periodos/1", "icon": "0xf051f"}
    ],
    "3": [
      {"nome": "Periodo 1", "action": "/periodos/1", "icon": "0xf051f"},
      {"nome": "Periodo 2", "action": "/periodos/1", "icon": "0xf051f"},
      {"nome": "Periodo 3", "action": "/periodos/1", "icon": "0xf051f"},
      {"nome": "Periodo 4", "action": "/periodos/1", "icon": "0xf051f"},
      {"nome": "Periodo 5", "action": "/periodos/1", "icon": "0xf051f"},
      {"nome": "Periodo 6", "action": "/periodos/1", "icon": "0xf051f"},
      {"nome": "Periodo 7", "action": "/periodos/1", "icon": "0xf051f"},
      {"nome": "Periodo 8", "action": "/periodos/1", "icon": "0xf051f"}
    ]
  };
}
