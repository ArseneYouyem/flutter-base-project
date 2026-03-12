import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../helper/outputs.dart';

class StorageService extends GetxService {
  late GetStorage _box;

  Future<StorageService> init() async {
    await GetStorage.init();
    _box = GetStorage();
    return this;
  }

  Future<void> save(String key, data) async {
    return await _box.write(key, data);
  }

  bool hasKey(String key) {
    return _box.hasData(key);
  }

  Future<bool> remove(String key) async {
    await _box.remove(key);
    return true;
  }

  T? find<T>(String key) {
    return _box.read<T>(key);
  }

  Future<void> deleteStorage() async {
    await _box.erase();
  }

  Future<void> checkKey() async {
    await _box.getKeys();
  }

  // Future<File> createFile(String? nameFile) async {
  //   var dir = await getApplicationDocumentsDirectory();
  //   return File('${dir.path}/$nameFile');
  // }

  Future<void> ressetDirectory() async {
    final listKey = _box.getKeys();
    List<String> listK = [];

    for (var key in listKey) {
      if ('$key'.startsWith('cash_')) listK.add('$key');
    }
    for (var key in listK) {
      printIfDebug('removing $key');
      await _box.remove(key);
    }
  }
}
