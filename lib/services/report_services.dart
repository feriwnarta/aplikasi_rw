import 'package:aplikasi_rw/model/ReportModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ReportServices extends ReportModel {
  factory ReportServices.create(Map<String, dynamic> item) {
    return ReportModel(
      noTicket: item['id'].toString(),
      urlImageReport: item['thumbnailUrl'],
      location: item['title'],
      status: item['title'],
      time: item['title'],
      description: item['title'],
    ) as ReportModel;
  }

  static Future<List<ReportModel>> getDataApi(int start, int limit) async {
    var data = {'id_user': '50', 'start': start, 'limit': limit};

    String apiUrl = 'http://192.168.43.122/nextg_mobileapp/src/report.php';
    // ambil data dari api
    var apiResult = await http.post(apiUrl, body: json.encode(data));
    // ubah jadi json dan casting ke list
    var jsonObject = json.decode(apiResult.body) as List;
    return jsonObject
        .map<ReportModel>((item) => ReportModel(
              noTicket: item['no_ticket'].toString(),
              urlImageReport: item['url_image'],
              location: item['no_ticket'],
              status: item['status'].toString(),
              time: '${item['date']}*${item['time']}',
              description: item['description'],
              additionalInformation: item['additional_information'],
              category: item['category']
            ))
        .toList();
  }
}
