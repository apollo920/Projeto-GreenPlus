
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'i_local_secure_storage.dart';

class LocalSecureStorageImpl implements ILocalSecureStorage{
  final FlutterSecureStorage storage;
  LocalSecureStorageImpl(this.storage);

  @override
  Future<bool> clear({Map<dynamic, dynamic>? parameters}) async {
    await storage.deleteAll();
    return Future.value(true);
  }

  @override
  Future<bool> delete({required String id, Map<dynamic, dynamic>? parameters}) async {
    await storage.delete(key: id);
    return Future.value(true);
  }

  @override
  Future<String?> get({required String id, Map<dynamic, dynamic>? parameters}) async {
    String? value = await storage.read(key: id);
    return Future.value(value);
  }

  @override
  Future<bool> save({required String id, required String data, Map<dynamic, dynamic>? parameters}) async {
    await storage.write(key: id, value: data);
    return Future.value(true);
  }


}