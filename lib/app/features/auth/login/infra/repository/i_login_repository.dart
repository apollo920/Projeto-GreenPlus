import 'package:dartz/dartz.dart';

import '../../../../../core/erros/erros.dart';
import '../../models/user.dart';

abstract class ILoginRepository {
  Future<Either<Failure, String>> loginUsername(
      {required String username, required String password});

  Future<Either<Failure, User>> usuarioLogado();

  Future<Either<Failure, bool>> verificarToken({required String token});

  Future<Either<Failure, bool>> salvarUsuario({required User user});
}
