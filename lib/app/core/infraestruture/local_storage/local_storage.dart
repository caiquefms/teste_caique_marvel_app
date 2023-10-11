abstract class LocalStorage {
  Future<void> putString(String key, String value);
  Future<void> putInt(String key, int value);
  Future<void> putDouble(String key, double value);
  Future<void> putBool(String key, bool value);
  Future<void> putMap(String key, Map<String, dynamic> value);

  Future<String?> getString(String key);
  Future<int?> getInt(String key);
  Future<double?> getDouble(String key);
  Future<bool?> getBool(String key);
  Future<Map<String, dynamic>?> getMap(String key);

  Future<bool> containsKey(String key);
  Future<bool?> remove(String key);
  Future<void> removeAll();
}
