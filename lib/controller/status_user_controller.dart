import 'package:aplikasi_rw/model/status_user_model.dart';
import 'package:aplikasi_rw/services/status_user_services.dart';
import 'package:aplikasi_rw/utils/UserSecureStorage.dart';
import 'package:get/get.dart';

class StatusUserController extends GetxController {
  List<StatusUserModel> listStatus = <StatusUserModel>[].obs;
  var isLoading = true.obs;
  var isMaxReached = false.obs;
  var data = 0.obs;
  List<StatusUserModel> listStatusNew = <StatusUserModel>[].obs;

  void increment() {
    data++;
  }

  void realtimeData() async {
    String idUser = await UserSecureStorage.getIdUser();
    List<StatusUserModel> listBaru =
        await StatusUserServices.getDataApi(idUser, 0, 10);

    if (listStatus.length <= 10) {
      listStatus.assignAll(listBaru);
    } else {
      var getLength10 = listStatus.getRange(0, 10);
      List<StatusUserModel> convert = getLength10.toList();

      bool el;
      int dt = 0;
      convert.forEach((element) {
        if (listBaru[dt].idStatus == element.idStatus) {
          el = true;
        } else {
          el = false;
        }
        dt++;
      });
      print(el);
    }
  }

  void addStatus() async {
    String idUser = await UserSecureStorage.getIdUser();
    List<StatusUserModel> lisStatusBru =
        await StatusUserServices.getDataApi(idUser, 0, 1);
    lisStatusBru.addAll(listStatus);
    listStatus.assignAll(lisStatusBru);
  }

  void getDataFromDb() async {
    String idUser = await UserSecureStorage.getIdUser();
    if (isLoading.value) {
      listStatus.assignAll(await StatusUserServices.getDataApi(idUser, 0, 10));
      if (listStatus.isNotEmpty) {
        isLoading.value = false;
      }
    } else {
      listStatusNew.assignAll(
          await StatusUserServices.getDataApi(idUser, listStatus.length, 10));
      if (listStatusNew.isEmpty) {
        isMaxReached.value = true;
        // isLoading.value = true;
      } else {
        listStatus.addAll(listStatusNew);
        // print(listStatus.length);
        // (listStatus + listStatusNew);
        // listStatus.assignAll(listStatusNew);
      }
    }
  }
}
