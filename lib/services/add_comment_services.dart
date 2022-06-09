import 'package:aplikasi_rw/screen/loading_send_screen.dart';
import 'package:aplikasi_rw/server-app.dart';
import 'package:aplikasi_rw/utils/UserSecureStorage.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddCommentServices {
  

  static Future addComment(
      String idStatus, String comment, BuildContext context) async {
    String idUser = await UserSecureStorage.getIdUser();
    String url = '${ServerApp.url}src/status/comment/add_comment.php';
    var data = {'id_user': idUser, 'id_status': idStatus, 'comment': comment};

    showLoading(context);
    http.Response response = await http.post(url, body: jsonEncode(data));
    if (response.statusCode == 200) {
      Navigator.of(context).pop();
    }
  }
}
