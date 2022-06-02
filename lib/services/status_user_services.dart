import 'package:aplikasi_rw/model/status_user_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../server-app.dart';

class StatusUserServices extends StatusUserModel {
  static Future<http.MultipartRequest> sendDataStatus(
      {String idUser,
      String imgPath,
      String username,
      String foto_profile,
      String caption}) async {
    String uri =
        '${ServerApp.url}src/status/add_status.php';
    var request = http.MultipartRequest('POST', Uri.parse(uri));

    print(idUser);
    print(imgPath);
    print(username);
    print(foto_profile);
    print(caption);

    if (imgPath != null && imgPath.isNotEmpty) {
      var pic = await http.MultipartFile.fromPath('status_image', imgPath);
      request.files.add(pic);
      request.fields['id_user'] = idUser;
      request.fields['username'] = username;
      request.fields['foto_profile'] = foto_profile;
      request.fields['caption'] = caption;

      return request;

      // await request.send().then((value) {
      //   http.Response.fromStream(value).then((value) {
      //     String message = json.decode(value.body);
      //     print('msg' + message);
      //   });
      // });

    }
    return request;
  }

  static Future<List<StatusUserModel>> getDataApi(String idUser, int start, int limit) async {
    var data = {'id_user': idUser, 'start': start, 'limit': limit};
    String apiUrl =
        '${ServerApp.url}src/status/status.php';
    // ambil data dari api
    var apiResult = await http.post(apiUrl, body: json.encode(data));
    // ubah jadi json dan casting ke list
    var jsonObject = json.decode(apiResult.body) as List;
    return jsonObject
        .map<StatusUserModel>((item) => StatusUserModel(
              userName: item['username'],
              uploadTime: item['upload_time'],
              urlProfile: item['foto_profile'],
              caption: item['caption'],
              urlStatusImage: '${ServerApp.url}' + item['status_image'],
              numberOfComments: item['comment'],
              numberOfLikes: item['like'],
            ))
        .toList();
  }
}
