import 'package:aplikasi_rw/model/status_user_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class StatusUserServices extends StatusUserModel{
    
  factory StatusUserServices.create(Map<String, dynamic> object) {
    return StatusUserModel(
      userName: object['id'].toString(),
      caption: object['body']
    ) as StatusUserServices;
  }

  static Future<List<StatusUserModel>> getDataApi(int start, int limit) async {
    String apiUrl = 'https://jsonplaceholder.typicode.com/posts?_start=$start&_limit=$limit';
    // ambil data dari api
    var apiResult = await http.get(apiUrl);
    // ubah jadi json dan casting ke list
    var jsonObject =  json.decode(apiResult.body) as List;
    return jsonObject.map<StatusUserModel>((item) => StatusUserModel(
      userName: item['id'].toString(),
      caption: item['body']
    )).toList();
  }


}