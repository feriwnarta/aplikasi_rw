import 'package:aplikasi_rw/screen/bills_screen/event_bill_screen.dart';
import 'package:aplikasi_rw/utils/UserSecureStorage.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class BillTab {
  Tab tab;
  Widget screen;
  Color colorsAppBar;
  Color colorsText;

  BillTab({this.tab, this.screen, this.colorsAppBar, this.colorsText});
}

class BillTabModel {

  static List<BillTab> tabs() {
    return [
      BillTab(
        colorsAppBar: Colors.red,
        tab: Tab(child: Text('Event 17 August', style: TextStyle(fontSize: 12.0.sp))),
        screen: EventBillScrenn(
          urlHeroImage: 'https://asset.kompas.com/crops/wvIJirTN7tp9S7AQ4mmlkdkMk0o=/0x0:780x520/750x500/data/photo/2020/08/13/5f354e00ebe40.jpg',
          titleEvent: 'citizen dues for the 17 august 2022',
          price: '200.000',
          dueDate: 'due date 7 agustus',
          background: Colors.red,
        ),
        colorsText: Colors.white
      ),
      BillTab(
        colorsAppBar: Colors.blue,
        tab: Tab(child: Text('Event idul adha', style: TextStyle(fontSize: 12.0.sp),),),
        screen: EventBillScrenn(
          urlHeroImage: 'https://kemenkumham.go.id/images/foto/2019/8_Agustus/2019-08-11_-_Idul_Adha_1.jpg',
          titleEvent: 'cost to buy sacrificial animals',
          price: '200.000',
          dueDate: 'due date 7 agustus',
          background: Colors.blue,
        ),
        colorsText: Colors.white,
      )
    ];
  }
}

// class BillEventServices {
//   static Future<List<BillTabModel>> getCategoryDetail(String idCategory) async {
//     String idUser = await UserSecureStorage.getIdUser();
//     String url = '${ServerApp.url}src/category/category_detail.php';
//     var data = {'id_user': idUser, 'id_category' : idCategory};

//     http.Response response = await http.post(url, body: jsonEncode(data));
//     var obj = jsonDecode(response.body) as List;
//     return obj
//         .map((item) => CategoryDetailModel(
//             idCategory: item['id_category'],
//             idCategoryDetail: item['id_category_detail'],
//             iconDetail: item['icon_detail'],
//             namecategoryDetail: item['name_category_detail']))
//         .toList();
//   }
// }