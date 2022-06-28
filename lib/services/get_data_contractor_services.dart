import 'package:aplikasi_rw/model/contractor_model.dart';
import 'package:aplikasi_rw/server-app.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GetDataContractorService {
  static Future<ContractorModel> getDataContractor(String idContractor) async {
    String url = '${ServerApp.url}src/contractor/contractor.php';
    var data = {"id_contractor": idContractor};
    var response = await http.post(url, body: jsonEncode(data));
    if (response.statusCode >= 200 && response.body.isNotEmpty) {
      var result = jsonDecode(response.body);
      print(result['username']);
      ContractorModel model = ContractorModel(
        idContractor: result['id_contractor'],
        nameContractor: result['name_contractor']
      );
      return model;
    }
  }
}