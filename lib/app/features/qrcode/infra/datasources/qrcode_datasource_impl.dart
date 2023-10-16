import '../../../../core/infra/client_http/i_client_http.dart';
import '../../../../core/infra/local_storage/i_local_secure_storage.dart';
import '../../models/qrcode.dart';
import 'i_qrcode_datasource.dart';

class QrCodeDataSourceImpl implements IQrCodeDataSource {
  final IClientHttp clientHttp;
  final ILocalSecureStorage localStorage;

  QrCodeDataSourceImpl(this.clientHttp, this.localStorage);

  @override
  Future<List<QrCodeModel>?> getQrCodes(
      {required String idCurso, required String idPeriodo}) async {
    return listaQrCodeByCursoAndPeriodo[idCurso]?[idPeriodo]
        ?.map((qrcode) => QrCodeModel.fromMap(qrcode))
        .toList();
  }

  @override
  Future<String?> addQrCode(
      {required String idCurso,
      required String idPeriodo,
      required QrCodeModel qrCodeModel}) async {
    try {
      String id =
          (listaQrCodeByCursoAndPeriodo[idCurso]![idPeriodo]!.length + 1)
              .toString();
      var newQrCode = qrCodeModel.toMap();
      newQrCode['id'] = id;
      listaQrCodeByCursoAndPeriodo[idCurso]?[idPeriodo]!.add(newQrCode);
      return id;
    } on Exception catch (e) {
      return null;
    }
  }

 @override
Future<String?> deleteQrCode(
    {required String idCurso,
    required String idPeriodo,
    required int idQrcode}) async {
  try {
    var qrCodes = listaQrCodeByCursoAndPeriodo[idCurso]?[idPeriodo];
    if (qrCodes != null) {
      for (int i = 0; i < qrCodes.length; i++) {
        if (qrCodes[i]['id'] == idQrcode.toString()) {
          qrCodes.removeAt(i);
          return idQrcode.toString();
        }
      }
    }
    return null;
  } on Exception catch (e) {
    return null;
  }
}



// var result = await clientHttp.get(url: "/users/checktoken");
// if (result.statusCode == 200) {
//   return true;
// } else if (result.statusCode != 500) {
//   return false;
// } else {
//   throw Failure();
// }
}

var listaQrCode = [
  {
    "content": "WIFI:T:WPA;S:SuaRedeWiFi;P:SuaSenha;;",
    "title": "WIFI DA PADARIA",
    "icon": "0xf051f",
    "type": "WiFi",
  },
  {
    "content": "https://exemplo.com",
    "title": "Exemplo de Link",
    "icon": "0xf1234",
    "type": "Link",
  },
];

var listaQrCodeByCursoAndPeriodo = {
  "1": {
    "0": [
      {
        "content": "WIFI:T:WPA;S:SuaRedeWiFi;P:SuaSenha;;",
        "title": "WIFI DA PADARIA 0",
        "icon": "0xf051f",
        "type": "WiFi",
      },
      {
        "content": "https://exemplo.com",
        "title": "Exemplo de Link 0",
        "icon": "0xf1234",
        "type": "Link",
      }
    ],
    "1": [
      {
        "content": "WIFI:T:WPA;S:SuaRedeWiFi;P:SuaSenha;;",
        "title": "WIFI DA PADARIA 1",
        "icon": "0xf051f",
        "type": "WiFi",
      },
      {
        "content": "https://exemplo.com",
        "title": "Exemplo de Link 1",
        "icon": "0xf1234",
        "type": "Link",
      }
    ],
    "2": [
      {
        "content": "WIFI:T:WPA;S:SuaRedeWiFi;P:SuaSenha;;",
        "title": "WIFI DA PADARIA 2",
        "icon": "0xf051f",
        "type": "WiFi",
      },
      {
        "content": "https://exemplo.com",
        "title": "Exemplo de Link 2",
        "icon": "0xf1234",
        "type": "Link",
      }
    ],
    "3": [
      {
        "content": "WIFI:T:WPA;S:SuaRedeWiFi;P:SuaSenha;;",
        "title": "WIFI DA PADARIA 3",
        "icon": "0xf051f",
        "type": "WiFi",
      },
      {
        "content": "https://exemplo.com",
        "title": "Exemplo de Link 3",
        "icon": "0xf1234",
        "type": "Link",
      }
    ],
    "4": [
      {
        "content": "WIFI:T:WPA;S:SuaRedeWiFi;P:SuaSenha;;",
        "title": "WIFI DA PADARIA 4",
        "icon": "0xf051f",
        "type": "WiFi",
      },
      {
        "content": "https://exemplo.com",
        "title": "Exemplo de Link 4",
        "icon": "0xf1234",
        "type": "Link",
      }
    ],
    "5": [
      {
        "content": "WIFI:T:WPA;S:SuaRedeWiFi;P:SuaSenha;;",
        "title": "WIFI DA PADARIA 5",
        "icon": "0xf051f",
        "type": "WiFi",
      },
      {
        "content": "https://exemplo.com",
        "title": "Exemplo de Link 5",
        "icon": "0xf1234",
        "type": "Link",
      }
    ],
    "6": [
      {
        "content": "WIFI:T:WPA;S:SuaRedeWiFi;P:SuaSenha;;",
        "title": "WIFI DA PADARIA 6",
        "icon": "0xf051f",
        "type": "WiFi",
      },
      {
        "content": "https://exemplo.com",
        "title": "Exemplo de Link 6",
        "icon": "0xf1234",
        "type": "Link",
      }
    ],
    "7": [
      {
        "content": "WIFI:T:WPA;S:SuaRedeWiFi;P:SuaSenha;;",
        "title": "WIFI DA PADARIA 7",
        "icon": "0xf051f",
        "type": "WiFi",
      },
      {
        "content": "https://exemplo.com",
        "title": "Exemplo de Link 7",
        "icon": "0xf1234",
        "type": "Link",
      }
    ]
  },
  "2": {
    "0": [],
    "1": [
      {
        "content": "WIFI:T:WPA;S:SuaRedeWiFi;P:SuaSenha;;",
        "title": "WIFI DA PADARIA  2 1",
        "icon": "0xf051f",
        "type": "WiFi",
      },
      {
        "content": "https://exemplo.com",
        "title": "Exemplo de Link 2 1",
        "icon": "0xf1234",
        "type": "Link",
      }
    ],
    "2": [
      {
        "content": "WIFI:T:WPA;S:SuaRedeWiFi;P:SuaSenha;;",
        "title": "WIFI DA PADARIA 2",
        "icon": "0xf051f",
        "type": "WiFi",
      },
      {
        "content": "https://exemplo.com",
        "title": "Exemplo de Link 2",
        "icon": "0xf1234",
        "type": "Link",
      }
    ],
    "3": [
      {
        "content": "WIFI:T:WPA;S:SuaRedeWiFi;P:SuaSenha;;",
        "title": "WIFI DA PADARIA 3",
        "icon": "0xf051f",
        "type": "WiFi",
      },
      {
        "content": "https://exemplo.com",
        "title": "Exemplo de Link 3",
        "icon": "0xf1234",
        "type": "Link",
      }
    ],
    "4": [
      {
        "content": "WIFI:T:WPA;S:SuaRedeWiFi;P:SuaSenha;;",
        "title": "WIFI DA PADARIA 4",
        "icon": "0xf051f",
        "type": "WiFi",
      },
      {
        "content": "https://exemplo.com",
        "title": "Exemplo de Link 4",
        "icon": "0xf1234",
        "type": "Link",
      }
    ],
    "5": [
      {
        "content": "WIFI:T:WPA;S:SuaRedeWiFi;P:SuaSenha;;",
        "title": "WIFI DA PADARIA 5",
        "icon": "0xf051f",
        "type": "WiFi",
      },
      {
        "content": "https://exemplo.com",
        "title": "Exemplo de Link 5",
        "icon": "0xf1234",
        "type": "Link",
      }
    ],
    "6": [
      {
        "content": "WIFI:T:WPA;S:SuaRedeWiFi;P:SuaSenha;;",
        "title": "WIFI DA PADARIA 6",
        "icon": "0xf051f",
        "type": "WiFi",
      },
      {
        "content": "https://exemplo.com",
        "title": "Exemplo de Link 6",
        "icon": "0xf1234",
        "type": "Link",
      }
    ],
    "7": [
      {
        "content": "WIFI:T:WPA;S:SuaRedeWiFi;P:SuaSenha;;",
        "title": "WIFI DA PADARIA 7",
        "icon": "0xf051f",
        "type": "WiFi",
      },
      {
        "content": "https://exemplo.com",
        "title": "Exemplo de Link 7",
        "icon": "0xf1234",
        "type": "Link",
      }
    ]
  },
  "3": {
    "0": [
      {
        "content": "WIFI:T:WPA;S:SuaRedeWiFi;P:SuaSenha;;",
        "title": "WIFI DA PADARIA 0",
        "icon": "0xf051f",
        "type": "WiFi",
      },
      {
        "content": "https://exemplo.com",
        "title": "Exemplo de Link 0",
        "icon": "0xf1234",
        "type": "Link",
      }
    ],
    "1": [
      {
        "content": "WIFI:T:WPA;S:SuaRedeWiFi;P:SuaSenha;;",
        "title": "WIFI DA PADARIA 1",
        "icon": "0xf051f",
        "type": "WiFi",
      },
      {
        "content": "https://exemplo.com",
        "title": "Exemplo de Link 1",
        "icon": "0xf1234",
        "type": "Link",
      }
    ],
    "2": [
      {
        "content": "WIFI:T:WPA;S:SuaRedeWiFi;P:SuaSenha;;",
        "title": "WIFI DA PADARIA 2",
        "icon": "0xf051f",
        "type": "WiFi",
      },
      {
        "content": "https://exemplo.com",
        "title": "Exemplo de Link 2",
        "icon": "0xf1234",
        "type": "Link",
      }
    ],
    "3": [
      {
        "content": "WIFI:T:WPA;S:SuaRedeWiFi;P:SuaSenha;;",
        "title": "WIFI DA PADARIA 3",
        "icon": "0xf051f",
        "type": "WiFi",
      },
      {
        "content": "https://exemplo.com",
        "title": "Exemplo de Link 3",
        "icon": "0xf1234",
        "type": "Link",
      }
    ],
    "4": [
      {
        "content": "WIFI:T:WPA;S:SuaRedeWiFi;P:SuaSenha;;",
        "title": "WIFI DA PADARIA 4",
        "icon": "0xf051f",
        "type": "WiFi",
      },
      {
        "content": "https://exemplo.com",
        "title": "Exemplo de Link 4",
        "icon": "0xf1234",
        "type": "Link",
      }
    ],
    "5": [
      {
        "content": "WIFI:T:WPA;S:SuaRedeWiFi;P:SuaSenha;;",
        "title": "WIFI DA PADARIA 5",
        "icon": "0xf051f",
        "type": "WiFi",
      },
      {
        "content": "https://exemplo.com",
        "title": "Exemplo de Link 5",
        "icon": "0xf1234",
        "type": "Link",
      }
    ],
    "6": [
      {
        "content": "WIFI:T:WPA;S:SuaRedeWiFi;P:SuaSenha;;",
        "title": "WIFI DA PADARIA 6",
        "icon": "0xf051f",
        "type": "WiFi",
      },
      {
        "content": "https://exemplo.com",
        "title": "Exemplo de Link 6",
        "icon": "0xf1234",
        "type": "Link",
      }
    ],
    "7": [
      {
        "content": "WIFI:T:WPA;S:SuaRedeWiFi;P:SuaSenha;;",
        "title": "WIFI DA PADARIA 7",
        "icon": "0xf051f",
        "type": "WiFi",
      },
      {
        "content": "https://exemplo.com",
        "title": "Exemplo de Link 7",
        "icon": "0xf1234",
        "type": "Link",
      }
    ]
  }
};
