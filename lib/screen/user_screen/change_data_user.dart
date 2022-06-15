import 'dart:io';
import 'package:aplikasi_rw/bloc/user_loading_bloc.dart';
import 'package:aplikasi_rw/server-app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ChangeDataUser extends StatefulWidget {
  String urlProfile;
  String username;
  String urlProfilePath, idUser;

  ChangeDataUser({this.urlProfile, this.idUser});

  @override
  _ChangeDataUserState createState() => _ChangeDataUserState();
}

class _ChangeDataUserState extends State<ChangeDataUser> {
  ImagePicker _picker = ImagePicker();

  TextEditingController controllerUsername = TextEditingController();
  TextEditingController controllerFullName = TextEditingController();
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controller = TextEditingController();
  TextEditingController controllerPhone = TextEditingController();

  String status;
  UserLoadingBloc bloc;

  @override
  Widget build(BuildContext context) {
    bloc = BlocProvider.of<UserLoadingBloc>(context);
    return WillPopScope(
      onWillPop: () async {
        if (status != null && status == 'refresh') {
          Navigator.of(context).pop('refresh');
          return true;
        }
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Ganti data'),
        ),
        body: FutureBuilder<UserChangeModel>(
            future: UserChangeServices.getDataUser(widget.idUser),
            builder: (context, snapshot) => (snapshot.hasData)
                ? Column(
                    children: [
                      SizedBox(
                        height: 1.5.h,
                      ),
                      Center(
                        child: Stack(
                          children: [
                            GestureDetector(
                              child: Container(
                                  height: 15.0.h,
                                  width: 30.0.w,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(color: Colors.blue),
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          repeat: ImageRepeat.noRepeat,
                                          image: (widget.urlProfilePath == null)
                                              ? NetworkImage(
                                                  '${ServerApp.url}${widget.urlProfile}')
                                              : FileImage(File(
                                                  widget.urlProfilePath))))),
                              onTap: () => showModalBottomSheet(
                                  context: context,
                                  builder: ((builder) =>
                                      bottomImagePicker(context))),
                            ),
                            Positioned(
                              right: -2.7.w,
                              bottom: -1.5.h,
                              child: IconButton(
                                icon: Icon(
                                  Icons.image,
                                  color: Colors.blue[800],
                                ),
                                onPressed: () {
                                  showModalBottomSheet(
                                      context: context,
                                      builder: ((builder) =>
                                          bottomImagePicker(context)));
                                },
                                iconSize: 5.0.h,
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 3.0.h,
                      ),
                      ListTile(
                        leading: Icon(Icons.person),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 1.0.h),
                            Text(
                              'username',
                              style: TextStyle(
                                  color: Colors.grey, fontSize: 10.0.sp),
                            ),
                            SizedBox(height: 1.0.h),
                            Text('${snapshot.data.username}'),
                            SizedBox(height: 1.0.h),
                          ],
                        ),
                        trailing: Icon(
                          FontAwesomeIcons.pen,
                          size: 2.0.h,
                        ),
                        onTap: () => showModalBottomSheet(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(15.0))),
                            context: context,
                            isScrollControlled: true,
                            builder: (context) => buildPaddingChangeData(
                                context, 'masukan username', 'username')),
                      ),
                      SizedBox(
                        height: 2.0.h,
                      ),
                      ListTile(
                        leading: Icon(Icons.person_pin_rounded),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 1.0.h),
                            Text(
                              'full name',
                              style: TextStyle(
                                  color: Colors.grey, fontSize: 10.0.sp),
                            ),
                            SizedBox(height: 1.0.h),
                            Text('${snapshot.data.fullname}'),
                            SizedBox(height: 1.0.h),
                          ],
                        ),
                        trailing: Icon(
                          FontAwesomeIcons.pen,
                          size: 2.0.h,
                        ),
                        onTap: () => showModalBottomSheet(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(15.0))),
                            context: context,
                            isScrollControlled: true,
                            builder: (context) => buildPaddingChangeData(
                                context, 'masukan full name', 'fullname')),
                      ),
                      SizedBox(
                        height: 2.0.h,
                      ),
                      ListTile(
                        leading: Icon(Icons.email),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 1.0.h),
                            Text(
                              'email',
                              style: TextStyle(
                                  color: Colors.grey, fontSize: 10.0.sp),
                            ),
                            SizedBox(height: 1.0.h),
                            Text('${snapshot.data.email}'),
                            SizedBox(height: 1.0.h),
                          ],
                        ),
                        trailing: Icon(
                          FontAwesomeIcons.pen,
                          size: 2.0.h,
                        ),
                        onTap: () => showModalBottomSheet(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(15.0))),
                            context: context,
                            isScrollControlled: true,
                            builder: (context) => buildPaddingChangeData(
                                context, 'masukan email', 'email')),
                      ),
                      SizedBox(
                        height: 2.0.h,
                      ),
                      ListTile(
                        leading: Icon(Icons.phone_android),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 1.0.h),
                            Text(
                              'Phone number',
                              style: TextStyle(
                                  color: Colors.grey, fontSize: 10.0.sp),
                            ),
                            SizedBox(height: 1.0.h),
                            Text('${snapshot.data.noPhone}'),
                            SizedBox(height: 1.0.h),
                          ],
                        ),
                        trailing: Icon(
                          FontAwesomeIcons.pen,
                          size: 2.0.h,
                        ),
                        onTap: () => showModalBottomSheet(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(15.0))),
                            context: context,
                            isScrollControlled: true,
                            builder: (context) => buildPaddingChangeData(
                                context, 'masukan nomor telepon', 'phone')),
                      ),
                      SizedBox(
                        height: 1.0.h,
                      ),
                    ],
                  )
                : Center(child: CircularProgressIndicator())),
      ),
    );
  }

  Padding buildPaddingChangeData(
      BuildContext context, String label, String dataKolom) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(
            height: 1.0.h,
          ),
          Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              children: [
                TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    labelText: label,
                  ),
                  autofocus: true,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      child: Text('Batal'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    TextButton(
                      child: Text('Simpan'),
                      onPressed: () async {
                        if (dataKolom == 'username') {
                          String rs = await UserChangeServices.editData(
                              widget.idUser, controller.text, 'username');
                          if (rs == 'OK') {
                            Navigator.of(context).pop();
                            status = 'refresh';
                          }
                        } else if (dataKolom == 'fullname') {
                          String rs = await UserChangeServices.editData(
                              widget.idUser, controller.text, 'fullname');
                          if (rs == 'OK') {
                            Navigator.of(context).pop();
                            status = 'refresh';
                          }
                        } else if (dataKolom == 'email') {
                          String rs = await UserChangeServices.editData(
                              widget.idUser, controller.text, 'email');
                          if (rs == 'OK') {
                            Navigator.of(context).pop();
                            status = 'refresh';
                          }
                        } else if (dataKolom == 'phone') {
                          String rs = await UserChangeServices.editData(
                              widget.idUser, controller.text, 'phone');
                          if (rs == 'OK') {
                            Navigator.of(context).pop();
                            status = 'refresh';
                          }
                        }
                        controller.clear();
                      },
                    )
                  ],
                )
              ],
            ),
          ),
          SizedBox(height: 1.0.h),
        ],
      ),
    );
  }

  Widget bottomImagePicker(BuildContext context) => Container(
        margin: EdgeInsets.only(top: 20),
        width: MediaQuery.of(context).size.width,
        height: 18.0.h,
        child: Column(
          children: [
            Text(
              'Pilih gambar',
              style: TextStyle(fontSize: 13.0.sp, fontFamily: 'Pt Sans Narrow'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FlatButton.icon(
                    icon: Icon(Icons.camera_alt),
                    label: Text(
                      'Kamera',
                      style: TextStyle(
                          fontSize: 13.0.sp, fontFamily: 'Pt Sans Narrow'),
                    ),
                    onPressed: () {
                      getImage(ImageSource.camera);
                      Navigator.of(context)
                          .pop(); // -> digunakan untuk menutup show modal bottom sheet secara programatic
                    }),
                FlatButton.icon(
                  icon: Icon(Icons.image),
                  label: Text(
                    'Gallery',
                    style: TextStyle(
                        fontSize: 13.0.sp, fontFamily: 'Pt Sans Narrow'),
                  ),
                  onPressed: () {
                    getImage(ImageSource.gallery);
                    Navigator.of(context)
                        .pop(); // -> digunakan untuk menutup show modal bottom sheet secara programatic
                  },
                )
              ],
            )
          ],
        ),
      );

  void getImage(ImageSource source) async {
    final pickedFile = await _picker.getImage(source: source, imageQuality: 50);
    setState(() {
      if (pickedFile != null) {
        setState(() {
          widget.urlProfilePath = pickedFile.path;
        });
        UserChangeServices.changeFoto(widget.idUser, pickedFile.path);
        status = 'refresh';
      }
    });
  }
}

class UserChangeModel {
  String email;
  String username;
  String fullname;
  String noPhone;

  UserChangeModel({this.email, this.username, this.fullname, this.noPhone});
}

class UserChangeServices {
  static Future<UserChangeModel> getDataUser(String idUser) async {
    String url = '${ServerApp.url}src/user/user.php';
    var data = {"id_user": idUser};
    var response = await http.post(url, body: jsonEncode(data));
    if (response.statusCode >= 200 && response.body.isNotEmpty) {
      var result = jsonDecode(response.body);
      print(result['username']);
      UserChangeModel model = UserChangeModel(
          email: result['email'],
          fullname: result['fullname'],
          noPhone: result['phone'],
          username: result['username']);
      return model;
    }
  }

  static Future<String> editData(
      String idUser, String initData, String kolom) async {
    String url = '${ServerApp.url}src/user/update_user.php';
    var data = {'id_user': idUser, 'kolom': kolom, 'data': initData};
    http.Response response = await http.post(url, body: jsonEncode(data));
    var result = jsonDecode(response.body);
    return result;
  }

  static Future changeFoto(String idUser, String imgPath) async {
    String uri = '${ServerApp.url}/src/user/update_user.php';
    var request = http.MultipartRequest('POST', Uri.parse(uri));

    if (imgPath != null && imgPath.isNotEmpty) {
      var pic = await http.MultipartFile.fromPath('image', imgPath);
      request.files.add(pic);
      request.fields['id_user'] = idUser;

      await request.send().then((value) {
        http.Response.fromStream(value).then((value) {
          String message = json.decode(value.body);
          print(message);
        });
      });
    }
  }
}
