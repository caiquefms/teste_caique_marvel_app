import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import 'dart:io';
import 'local_storage.dart';

class SecureLocalStorageKeys {}

class SecureLocalStorage implements LocalStorage {
  final FlutterSecureStorage _storage;

  SecureLocalStorage()
      : _storage = Platform.isAndroid
            ? FlutterSecureStorage(
                aOptions: AndroidOptions(encryptedSharedPreferences: true),
              )
            : FlutterSecureStorage(iOptions: IOSOptions());

  @override
  Future<bool?> remove(String key) async {
    if (!await containsKey(key)) return null;
    await _storage.delete(key: key);
    return true;
  }

  @override
  Future<void> removeAll() async {
    await _storage.deleteAll();
  }

  @override
  Future<bool> containsKey(String key) async {
    return await _storage.containsKey(key: key);
  }

  @override
  Future<bool?> getBool(String key) async {
    if (!await containsKey(key)) return null;
    final value = await _storage.read(key: key) ?? 'null';
    switch (value.toLowerCase()) {
      case 'true':
        return true;
      case 'false':
        return false;
      case 'null':
        return null;
      default:
        throw TypeError();
    }
  }

  @override
  Future<double?> getDouble(String key) async {
    if (!await containsKey(key)) return null;
    final value = await _storage.read(key: key);
    try {
      if (value == null) return null;
      return double.parse(value);
    } on FormatException {
      throw TypeError();
    }
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
  Future<Map<String, dynamic>?> getMap(String key) async {
    final value = await _storage.read(key: key);
    try {
      if (value == null) return null;
      return jsonDecode(value);
    } on Exception {
      throw TypeError();
    }
  }

  @override
  Future<String?> getString(String key) async {
    return await _storage.read(key: key);
  }

  @override
  Future<void> putBool(String key, bool value) async {
    await _storage.write(key: key, value: value.toString());
  }

  @override
  Future<void> putDouble(String key, double value) async {
    await _storage.write(key: key, value: value.toString());
  }

  @override
  Future<void> putInt(String key, int value) async {
    await _storage.write(key: key, value: value.toString());
  }

  @override
  Future<void> putMap(String key, Map<String, dynamic> value) async {
    await _storage.write(key: key, value: jsonEncode(value));
  }

  @override
  Future<void> putString(String key, String value) async {
    await _storage.write(key: key, value: value);
  }
}
