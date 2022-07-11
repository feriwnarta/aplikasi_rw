import 'package:aplikasi_rw/model/comment_model.dart';
import 'package:aplikasi_rw/services/comment_services.dart';
import 'package:get/get.dart';

class CommentUserController extends GetxController {
  List<CommentModel> listComment = <CommentModel>[].obs;
  var isLoading = true.obs;
  var isMaxReached = false.obs;
  var isAdd = false.obs;

  void afterComment(String idStatus) async {
    List<CommentModel> baru =
        await CommentService.getDataApi(int.parse(idStatus), 0, 1);
    baru.addAll(listComment);
    listComment.assignAll(baru);
    isAdd.value = true;
    isMaxReached.value = false;
  }

  void getComment({String idStatus}) async {
    if (isLoading.value) {
      listComment.assignAll(
          await CommentService.getDataApi(int.parse(idStatus), 0, 10));
      if (listComment.isNotEmpty) {
        isLoading.value = false;
      } else {
        isLoading.value = false;
      }
    } else {
      List<CommentModel> listStatusNew = await CommentService.getDataApi(
          int.parse(idStatus), listComment.length, 10);
      if (listStatusNew.isEmpty) {
        isMaxReached.value = true;
      } else {
        listComment.addAll(listStatusNew);
      }
    }
  }
}
