import '../../models/user.dart';

abstract class ILoginDataSource {
  Future<String?> loginUsername({required String username, required String password});
  Future<User?> usuarioLogado();
  Future<bool> salvarUsuarioLocalmente(User user);
  Future<bool> logout();
  Future<bool> verificarToken(String token);

}
