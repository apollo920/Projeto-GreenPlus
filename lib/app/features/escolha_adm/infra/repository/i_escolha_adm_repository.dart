import 'package:dartz/dartz.dart';

import '../../../../core/erros/erros.dart';
import '../../models/escolha_adm.dart';

abstract class IEscolhaAdmRepository {
  Future<Either<Failure, List<EscolhaAdm>>> getEscolhasMenuAdm();
}
