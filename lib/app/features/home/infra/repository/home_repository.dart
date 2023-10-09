import 'package:dartz/dartz.dart';

import 'package:greenplus/app/core/erros/erros.dart';
import 'package:greenplus/app/features/auth/login/models/user.dart';
import 'package:greenplus/app/features/home/models/menu_modulo.dart';

import '../datasources/i_home_datasource.dart';
import 'i_home_repository.dart';

class HomeRepositoryImpl extends IHomeRepository{

  final IHomeDataSource dataSource;

  HomeRepositoryImpl(this.dataSource);
  @override
  Future<Either<Failure, List<MenuModulo>>> getMenusMedulos() async {
    try {
      List<MenuModulo>? listaMenusModulos = await dataSource.getMenusMedulos();

      if (listaMenusModulos == null) {
        return Left(DataSourceEmpty());
      }

      return Right(listaMenusModulos);
    } catch (e) {
      return Left(DataSourceException());
    }
  }


}