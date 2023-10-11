import 'dart:io';
import 'package:flutter/material.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import 'core/infraestruture/local_storage/secure_local_storage.dart';
import 'core/infraestruture/config/config_constants.dart';
import 'features/home/pages/home_page.dart';

void main() async {
  await preLoad();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Marvel App - Caique',
    home: HomePage(),
    locale: const Locale('pt', 'BR'),
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      useMaterial3: true,
    ),
  ));
}

Future preLoad() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    var ts = DateTime.now().millisecond;
    var hashString =
        '$ts${ConfigConstants.privatekey}${ConfigConstants.publicKey}';
    var hash = md5.convert(Utf8Encoder().convert(hashString)).toString();

    var _localSecurityStorage = SecureLocalStorage(Platform.isAndroid
        ? FlutterSecureStorage(
            aOptions: AndroidOptions(encryptedSharedPreferences: true),
          )
        : FlutterSecureStorage(iOptions: IOSOptions()));
    _localSecurityStorage.putInt("ts", ts);
    _localSecurityStorage.putString("apikey", ConfigConstants.publicKey);
    _localSecurityStorage.putString("hash", hash);
  } catch (e) {
    print(e);
  }
}
