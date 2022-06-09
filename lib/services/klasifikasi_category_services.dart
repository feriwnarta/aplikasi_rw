import '../server-app.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class KlasifikasiCategory {
  String idKlasifikasi, idCategoryDetail, klasifikasi;

  KlasifikasiCategory(
      {this.idCategoryDetail, this.idKlasifikasi, this.klasifikasi});
}

class KlasifikasiCategoryServices {
  static Future<List<KlasifikasiCategory>> getKlasifikasiCategory(
      String idCategoryDetail) async {
    String url = '${ServerApp.url}src/category/klasifikasi_category.php';
    var data = {'id_category_detail': idCategoryDetail};

    http.Response response = await http.post(url, body: jsonEncode(data));
    var obj = jsonDecode(response.body) as List;
    return obj
        .map((item) => KlasifikasiCategory(
            idCategoryDetail: item['id_category_detail'],
            idKlasifikasi: item['id_klasifikasi'],
            klasifikasi: item['klasifikasi']))
        .toList();
  }
}
