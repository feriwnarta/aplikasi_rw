import 'package:aplikasi_rw/server-app.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CordinatorReportModel {
  String idReport,
      urlImage,
      title,
      description,
      time,
      address,
      latitude,
      longitude;
  List<String> categoryDetail;

  CordinatorReportModel(
      {this.idReport,
      this.urlImage,
      this.title,
      this.description,
      this.time,
      this.address,
      this.latitude,
      this.categoryDetail,
      this.longitude});
}

class CordinatorReportServices {
  static Future<List<CordinatorReportModel>> getReportCordinator(
      String idCordinator, int start, int limit) async {
    String url = '${ServerApp.url}src/cordinator/report_pull/report_pull.php';
    var data = {'id_cordinator': idCordinator, 'start': start, 'limit': limit};
    http.Response response = await http.post(url, body: jsonEncode(data));
    if (response.statusCode >= 200 && response.statusCode <= 299) {
      if (response.body.isNotEmpty) {
        var message = jsonDecode(response.body) as List;
        return message
            .map((item) => CordinatorReportModel(
                description: item['description'],
                idReport: item['id_report'],
                latitude: item['latitude'],
                longitude: item['longitude'],
                urlImage: item['url_image'],
                time: item['time_post'],
                title: item['category_detail'],
                address: item['address']))
            .toList();
      } else {
        return [];
      }
    }
  }

  static Future<List<CordinatorReportModel>> getReportCordinatorProcess(
      String idCordinator, int start, int limit) async {
    String url =
        '${ServerApp.url}src/cordinator/report_pull/report_pull_process.php';
    var data = {'id_cordinator': idCordinator, 'start': start, 'limit': limit};
    http.Response response = await http.post(url, body: jsonEncode(data));
    if (response.statusCode >= 200 && response.statusCode <= 299) {
      if (response.body.isNotEmpty) {
        var message = jsonDecode(response.body) as List;
        return message
            .map((item) => CordinatorReportModel(
                description: item['description'],
                idReport: item['id_report'],
                latitude: item['latitude'],
                longitude: item['longitude'],
                urlImage: item['url_image'],
                time: item['time_post'],
                title: item['category_detail'],
                address: item['address']))
            .toList();
      } else {
        return [];
      }
    }
  }

  static Future<List<CordinatorReportModel>> getReportCordinatorFinish(
      String idCordinator, int start, int limit) async {
    String url =
        '${ServerApp.url}src/cordinator/report_pull/report_pull_finish.php';
    var data = {'id_cordinator': idCordinator, 'start': start, 'limit': limit};
    http.Response response = await http.post(url, body: jsonEncode(data));
    if (response.statusCode >= 200 && response.statusCode <= 299) {
      if (response.body.isNotEmpty) {
        var message = jsonDecode(response.body) as List;
        return message
            .map((item) => CordinatorReportModel(
                description: item['description'],
                idReport: item['id_report'],
                latitude: item['latitude'],
                longitude: item['longitude'],
                urlImage: item['url_image'],
                time: item['time_post'],
                title: item['category_detail'],
                address: item['address']))
            .toList();
      } else {
        return [];
      }
    }
  }
}
