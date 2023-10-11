import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'local_storage.dart';

class SecureLocalStorageKeys {}

class SecureLocalStorage implements LocalStorage {
  final FlutterSecureStorage _storage;

  SecureLocalStorage(this._storage);

  @override
  Future<bool> containsKey(String key) async {
    return await _storage.containsKey(key: key);
  }

  @override
  Future<int?> getInt(String key) async {
    if (!await containsKey(key)) return null;
    final value = await _storage.read(key: key);
    try {
      if (value == null) return null;
      return int.parse(value);
    } on FormatException {
      throw TypeError();
    }
  }

  @override
  Future<String?> getString(String key) async {
    return await _storage.read(key: key);
  }

  @override
  Future<void> putInt(String key, int value) async {
    await _storage.write(key: key, value: value.toString());
  }

  @override
  Future<void> putString(String key, String value) async {
    await _storage.write(key: key, value: value);
  }
}
