import '../../models/escolha_adm.dart';

abstract class IEscolhaAdmDataSource {
  Future<List<EscolhaAdm>?> getEscolhasMenuAdm();
}
