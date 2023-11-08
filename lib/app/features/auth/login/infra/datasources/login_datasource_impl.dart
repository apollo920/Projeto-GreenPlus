import '../../../../../core/erros/erros.dart';
import '../../../../../core/infra/client_http/i_client_http.dart';
import '../../../../../core/infra/local_storage/i_local_secure_storage.dart';
import '../../models/user.dart';
import 'i_login_datasource.dart';

class LoginDataSourceImpl implements ILoginDataSource {
  final IClientHttp clientHttp;
  final ILocalSecureStorage localStorage;

  LoginDataSourceImpl(this.clientHttp, this.localStorage);

  @override
  Future<String?> loginUsername(
      {required String username, required String password}) async {

    // return "tokenabcd";

    var payload = {
      "username": username,
      "password": password,
    };

    var result = await clientHttp.post(url: "/users/login", body: payload);
    if (result.statusCode == 200) {
      final json = result.data;

      var token = json['token'];

      return token;
    } else if (result.statusCode != 500) {
      final json = result?.data;
      throw Failure(message: json['message'] ?? 'Erro na consulta');
    } else {
      throw Failure();
    }
  }

  @override
  Future<bool> logout() async {
    try {
      return localStorage.clear();
    } catch (e) {
      return false;
    }
  }

  @override
  Future<User?> usuarioLogado() async {
    try {
      String? user = await localStorage.get(id: "userLogged");
      return user != null ? User.fromJson(user) : null;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<bool> salvarUsuarioLocalmente(User userModel) async {
    try {
      var userStored = await usuarioLogado();
      userStored ??= User.fromJson('');

      return await localStorage.save(
          id: 'userLogged',
          data: userStored!.copyWith(
                  password: userModel.password,
                  token: userModel.token,
                  username: userModel.username)
              .toJson());
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> verificarToken(String token) async {
    return true;
    // var result = await clientHttp.get(url: "/users/checktoken");
    // if (result.statusCode == 200) {
    //   return true;
    // } else if (result.statusCode != 500) {
    //   return false;
    // } else {
    //   throw Failure();
    // }
  }
}
