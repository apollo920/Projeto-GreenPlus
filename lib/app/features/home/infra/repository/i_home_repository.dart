import 'package:dartz/dartz.dart';

import '../../../../core/erros/erros.dart';
import '../../models/menu_modulo.dart';

abstract class IHomeRepository {
  Future<Either<Failure, List<MenuModulo>>> getMenusMedulos();
}
