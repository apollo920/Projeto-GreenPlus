import 'package:dartz/dartz.dart';

import 'package:greenplus/app/core/erros/erros.dart';

import 'package:greenplus/app/features/home_adm/models/home_adm.dart';


import '../datasources/i_home_adm_datasource.dart';
import 'i_home_adm_repository.dart';

class HomeAdmRepositoryImpl extends IHomeAdmRepository{

  final IHomeAdmDataSource dataSource;

  HomeAdmRepositoryImpl(this.dataSource);
  @override
  Future<Either<Failure, List<HomeAdm>>> getHomeMenuAdm() async {
    try {
      List<HomeAdm>? listaHomeMenuAdm = await dataSource.getHomeMenuAdm();

      if (listaHomeMenuAdm == null) {
        return Left(DataSourceEmpty());
      }

      return Right(listaHomeMenuAdm);
    } catch (e) {
      return Left(DataSourceException());
    }
  }


}