import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class StorageService extends GetxService {
  late FlutterSecureStorage _box;

  Future<StorageService> init() async {
    _box = FlutterSecureStorage(
      aOptions: AndroidOptions(
        encryptedSharedPreferences: true,
      ),
    );
    return this;
  }

  Future<void> save(String key, data) async {
    return await _box.write(key: key, value: data);
  }

  Future<bool> hasKey(String key) async {
    return await _box.containsKey(key: key);
  }

  Future<bool> remove(String key) async {
    await _box.delete(key: key);
    return true;
  }

  Future<String?> find(String key) async {
    return await _box.read(key: key);
  }

  Future<void> deleteStorage() async {
    await _box.deleteAll();
  }
}
