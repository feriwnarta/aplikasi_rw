import 'package:aplikasi_rw/model/ReportModel.dart';
import 'package:aplikasi_rw/server-app.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ReportServices extends ReportModel {
  static Future<List<ReportModel>> getDataApi(
      String idUser, int start, int limit) async {
    var data = {'id_user': idUser, 'start': start, 'limit': limit};
    String apiUrl = '${ServerApp.url}/src/report/report.php';
    // ambil data dari api
    var apiResult = await http.post(apiUrl, body: json.encode(data));
    // ubah jadi json dan casting ke list
    var jsonObject = json.decode(apiResult.body) as List;
    return jsonObject
        .map<ReportModel>((item) => ReportModel(
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
            dataKlasifikasi: item['category_detail']))
        .toList();
  }

  static Future<http.MultipartRequest> sendDataReport(
      {String idUser,
      String description,
      String additionalLocation,
      String feedback,
      String category,
      String imgPath,
      String status,
      String idCategory,
      String latitude,
      String longitude,
      String address,
      String idCategoryDetail,
      String idKlasifikasiCategory}) async {
    String uri = '${ServerApp.url}/src/report/add_report.php';
    var request = http.MultipartRequest('POST', Uri.parse(uri));

    print('imagepath : ' + imgPath);

    if (imgPath != null && imgPath.isNotEmpty) {
      var pic = await http.MultipartFile.fromPath('image', imgPath);
      request.files.add(pic);
      request.fields['id_user'] = idUser;
      request.fields['description'] = description;
      request.fields['category'] = category;
      request.fields['status'] = status;
      request.fields['id_category'] = idCategory;
      request.fields['latitude'] = latitude;
      request.fields['longitude'] = longitude;
      request.fields['address'] = address;
      request.fields['id_klasifikasi_category'] = idKlasifikasiCategory;

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

  static Future<List<ReportModel>> search(String query) async {
    var data = {'query': query};
    String apiUrl = '${ServerApp.url}/src/report/search_report.php';
    // ambil data dari api
    var apiResult = await http.post(apiUrl, body: json.encode(data));
    // ubah jadi json dan casting ke list
    if (apiResult != null && apiResult.body.isNotEmpty) {
      var jsonObject = json.decode(apiResult.body) as List;
      return jsonObject
          .map<ReportModel>((item) => ReportModel(
              noTicket: item['no_ticFket'].toString(),
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
              dataKlasifikasi: item['category_detail']))
          .toList();
    }
  }
}
