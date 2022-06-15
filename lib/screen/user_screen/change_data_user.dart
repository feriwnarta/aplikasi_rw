import 'dart:io';
import 'package:aplikasi_rw/server-app.dart';
import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change data'),
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
                                            : FileImage(
                                                File(widget.urlProfilePath))))),
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
                          Text('${snapshot.data.username}')
                        ],
                      ),
                      trailing: Icon(
                        FontAwesomeIcons.pen,
                        size: 2.0.h,
                      ),
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
                          Text('${snapshot.data.fullname}')
                        ],
                      ),
                      trailing: Icon(
                        FontAwesomeIcons.pen,
                        size: 2.0.h,
                      ),
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
                          Text('${snapshot.data.email}')
                        ],
                      ),
                      trailing: Icon(
                        FontAwesomeIcons.pen,
                        size: 2.0.h,
                      ),
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
                          Text('${snapshot.data.noPhone}')
                        ],
                      ),
                      trailing: Icon(
                        FontAwesomeIcons.pen,
                        size: 2.0.h,
                      ),
                    ),

                    SizedBox(
                      height: 1.0.h,
                    ),

                  ],
                )
              : Center(child: CircularProgressIndicator())),
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
}
