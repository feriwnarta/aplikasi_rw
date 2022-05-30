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

  static Future<List<ReportModel>> getDataApi(
      String idUser, int start, int limit) async {
    var data = {'id_user': idUser, 'start': start, 'limit': limit};
    String apiUrl = 'http://192.168.3.19/nextg_mobileapp/src/report.php';
    // ambil data dari api
    var apiResult = await http.post(apiUrl, body: json.encode(data));
    // ubah jadi json dan casting ke list
    var jsonObject = json.decode(apiResult.body) as List;
    return jsonObject
        .map<ReportModel>((item) => ReportModel(
            noTicket: item['no_ticket'].toString(),
            urlImageReport: 'http://192.168.3.19/nextg_mobileapp/'+item['url_image'],
            location: item['no_ticket'],
            status: item['status'].toString(),
            time: '${item['date_post']} : ${item['time_post']}',
            description: item['description'],
            additionalInformation: item['feedback'],
            category: item['category']))
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
      }) async {
    String uri = 'http://192.168.3.19/nextg_mobileapp/src/add_report.php';
    var request = http.MultipartRequest('POST', Uri.parse(uri));

    print('imagepath : ' + imgPath);

    if (imgPath != null && imgPath.isNotEmpty) {
      var pic = await http.MultipartFile.fromPath('image', imgPath);
      request.files.add(pic);
      request.fields['id_user'] = idUser;
      request.fields['description'] = description;
      request.fields['additional_location'] = additionalLocation;
      request.fields['feedback'] = feedback;
      request.fields['category'] = category;
      request.fields['status'] = status;

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
}
