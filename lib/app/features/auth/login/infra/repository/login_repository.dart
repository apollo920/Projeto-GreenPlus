import 'package:dartz/dartz.dart';

import 'package:greenplus/app/core/erros/erros.dart';
import 'package:greenplus/app/features/auth/login/models/user.dart';

import '../datasources/i_login_datasource.dart';
import 'i_login_repository.dart';

class LoginRepositoryImpl extends ILoginRepository{

  final ILoginDataSource dataSource;

  LoginRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, String>> loginUsername({required String username, required String password}) async {
    try {
      var token = await dataSource.loginUsername(username: username, password: password);

      if (token == null) {
        return Left(ErrorLoginUserName());
      }

      return Right(token);
    } catch (e) {
      return Left(ErrorLoginUserName(message: e.toString().isNotEmpty ? e.toString() : "Erro ao realizar o login"));
    }
  }

  @override
  Future<Either<Failure, bool>> salvarUsuario({required User user}) async {
    try {
      bool result = await dataSource.salvarUsuarioLocalmente(user);
      return Right(result);
    } catch (e) {
      return Left(StorageFailure());
    }
  }

  @override
  Future<Either<Failure, User>> usuarioLogado() async {
    try {
      var user = await dataSource.usuarioLogado();

      if (user == null) {
        return Left(ErrorGetLoggedUser(
            message: "Error ao tentar recuperar usuario logado"));
      }

      return Right(user);
    } catch (e) {
      return Left(ErrorGetLoggedUser(
          message: "Error ao tentar recuperar usuario logado"));
    }
  }

  @override
  Future<Either<Failure, bool>> verificarToken({required String token}) async {
    try {
      bool result = await dataSource.verificarToken(token);
      return Right(result);
    } catch (e) {
      return Left(DataSourceException());
    }
  }

}