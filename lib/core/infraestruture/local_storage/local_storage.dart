abstract class LocalStorage {
  Future<void> putString(String key, String value);
  Future<void> putInt(String key, int value);
  Future<String?> getString(String key);
  Future<int?> getInt(String key);
  Future<bool> containsKey(String key);
}
