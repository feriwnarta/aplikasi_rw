import 'dart:convert';

import 'package:aplikasi_rw/model/comment_model.dart';
import 'package:http/http.dart' as http;

class CommentService {
  static Future<List<CommentModel>> getDataApi(int start, int limit) async {
    String apiUrl =
        'https://jsonplaceholder.typicode.com/comments?_start=$start&_limit=$limit';
    // ambil data dari api
    var apiResult = await http.get(apiUrl);
    // ubah jadi json dan casting ke list
    var jsonObject = json.decode(apiResult.body) as List;
    return jsonObject
        .map<CommentModel>((item) => CommentModel(
            urlImage:
                'https://img.idxchannel.com/media/700/images/idx/2022/03/08/Kekayaan_Orang_Tua_Sisca_Kohl.jpg',
            comment: item['body'],
            userName: item['name'],
            date: item['email']))
        .toList();
  }
}
