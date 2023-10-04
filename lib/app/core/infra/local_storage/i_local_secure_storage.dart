abstract class ILocalSecureStorage {
  Future<bool> save(
      {required String id, required String data, Map? parameters});

  Future<bool> delete({required String id, Map? parameters});

  Future<String?> get({required String id, Map? parameters});

  Future<bool> clear({Map parameters});
}
