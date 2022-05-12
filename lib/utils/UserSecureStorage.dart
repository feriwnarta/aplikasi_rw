import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserSecureStorage {
  static const _STORAGE = FlutterSecureStorage();
  static const _KEYIDUSER = 'idUser';

  static Future setIdUser(String idUser) async => await _STORAGE.write(key: _KEYIDUSER, value: idUser);
  static Future<String> getIdUser() async => await _STORAGE.read(key: _KEYIDUSER);

} 