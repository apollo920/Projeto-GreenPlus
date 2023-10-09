import 'package:dartz/dartz.dart';

import 'package:greenplus/app/core/erros/erros.dart';

import 'package:greenplus/app/features/escolha_adm/models/escolha_adm.dart';


import '../datasources/i_escolha_adm_datasource.dart';
import 'i_escolha_adm_repository.dart';

class EscolhaAdmRepositoryImpl extends IEscolhaAdmRepository{

  final IEscolhaAdmDataSource dataSource;

  EscolhaAdmRepositoryImpl(this.dataSource);
  @override
  Future<Either<Failure, List<EscolhaAdm>>> getEscolhasMenuAdm() async {
    try {
      List<EscolhaAdm>? listaEscolhasMenuAdm = await dataSource.getEscolhasMenuAdm();

      if (listaEscolhasMenuAdm == null) {
        return Left(DataSourceEmpty());
      }

      return Right(listaEscolhasMenuAdm);
    } catch (e) {
      return Left(DataSourceException());
    }
  }


}