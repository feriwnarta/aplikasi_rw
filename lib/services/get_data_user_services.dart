import 'package:aplikasi_rw/model/user_model.dart';
import 'package:aplikasi_rw/server-app.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GetDataUserServices {
  // static Future<String> getDataUser(String id) async {
  //   String uri = '${ServerApp.url}src/user/user.php';
  //   var request = http.MultipartRequest('POST', Uri.parse(uri));
  //   UserModel user;
  //   var message;

  //   String data;
  //   if (id != null && id.isNotEmpty) {
  //     request.fields['id_user'] = id;
  //     await request.send().then((value) {
  //       http.Response.fromStream(value).then((value) {
  //          message = json.decode(value.body);
  //         user = UserModel(
  //             urlProfile: message['profile_image'],
  //             username: message['username']);
  //             data = message['profile_image'];
  //             print(message['username']);
  //             print(message['profile_image']);

  //         // return user;
  //       });
  //     });
  //   }
  //   return message['username'];
  // }

  static Future<UserModel> getDataUser(String idUser) async {
    String url = '${ServerApp.url}src/user/user.php';
    var data = {"id_user": idUser};
    var response = await http.post(url, body: jsonEncode(data));
    if (response.statusCode >= 200 && response.body.isNotEmpty) {
      var result = jsonDecode(response.body);
      print(result['username']);
      UserModel model = UserModel(
          urlProfile: result['profile_image'], username: result['username']);
      return model;
    }
  }
}
