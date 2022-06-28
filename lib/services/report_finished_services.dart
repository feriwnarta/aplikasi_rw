import 'package:aplikasi_rw/model/ReportModel.dart';
import 'package:aplikasi_rw/utils/UserSecureStorage.dart';
import '../server-app.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ReportFinishedModel {
  String total;
  List<ReportModel> listReportFinish;

  ReportFinishedModel({this.total, this.listReportFinish});
}

class ReportFinishedServices {
  static Future<List<ReportFinishedModel>> getDataApi() async {
    String idUser = await UserSecureStorage.getIdUser();
    var data = {'id_user': idUser};
    String apiUrl = '${ServerApp.url}/src/report/report_finished.php';
    // ambil data dari api
    var apiResult = await http.post(apiUrl, body: json.encode(data));
    // ubah jadi json dan casting ke list
    List<ReportModel> listReportModel = [];
    var jsonObject = json.decode(apiResult.body) as List;
    return jsonObject.map<ReportFinishedModel>((item) {
      listReportModel.add(ReportModel(
          noTicket: item['no_ticket'].toString(),
          urlImageReport: '${ServerApp.url}' + item['url_image'],
          location: item['no_ticket'],
          status: item['status'].toString(),
          time: '${item['date_post']} : ${item['time_post']}',
          description: item['description'],
          category: item['category'],
          iconCategory: item['icon_category'],
          latitude: item['latitude'],
          idReport: item['id_report'],
          idUser: item['id_user'],
          longitude: item['longitude'],
          dataKlasifikasi: item['category_detail']));
      return ReportFinishedModel(
          listReportFinish: listReportModel, total: item['total']);
    }).toList();
  }
}
