import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserSecureStorage {
  static const _STORAGE = FlutterSecureStorage();
  static const _KEYIDUSER = 'idUser';

  static Future setIdUser(String idUser) async => await _STORAGE.write(key: _KEYIDUSER, value: idUser);
  static Future<String> getIdUser() async => await _STORAGE.read(key: _KEYIDUSER);
  static Future deleteIdUser() async {
    String idUser = await UserSecureStorage.getIdUser();
    if(idUser != null && idUser.isNotEmpty){
      await _STORAGE.delete(key: _KEYIDUSER);
    }
  }
} 