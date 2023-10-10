import 'package:dartz/dartz.dart';
import 'package:greenplus/app/features/home_adm/models/home_adm.dart';
import '../../../../core/erros/erros.dart';
abstract class IHomeAdmRepository {
  Future<Either<Failure, List<HomeAdm>>> getHomeMenuAdm();
}
