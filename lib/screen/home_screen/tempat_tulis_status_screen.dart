import 'dart:io';
import 'package:aplikasi_rw/bloc/status_user_bloc.dart';
import 'package:aplikasi_rw/bloc/tempat_tulis_status_bloc.dart';
import 'package:aplikasi_rw/screen/loading_send_screen.dart';
import 'package:aplikasi_rw/server-app.dart';
import 'package:aplikasi_rw/services/status_user_services.dart';
import 'package:aplikasi_rw/utils/UserSecureStorage.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TempatTulisStatus extends StatefulWidget {
  String fotoProfile, username, rt, rw;

  TempatTulisStatus({
    this.fotoProfile,
    this.username,
    this.rt,
    this.rw,
  });

  @override
  State<TempatTulisStatus> createState() => _TempatTulisStatusState(
      fotoProfile: this.fotoProfile,
      rt: this.rt,
      rw: this.rw,
      username: this.username);
}

//ignore: must_be_immutable
class _TempatTulisStatusState extends State<TempatTulisStatus> {
  _TempatTulisStatusState({
    this.fotoProfile,
    this.username,
    this.rt,
    this.rw,
  });
  final _picker = ImagePicker();
  // app bar disimpan ke variabel untuk diambil tingginya
  AppBar appBar;
  // field untuk data user
  String fotoProfile, username, rt, rw;
  TempatTulisStatusBloc bloc;
  StatusUserBloc statusBloc;
  final TextEditingController controllerStatus = TextEditingController();
  PickedFile pickedFile;

  Widget build(BuildContext context) {
    bloc = BlocProvider.of<TempatTulisStatusBloc>(context);
    statusBloc = BlocProvider.of<StatusUserBloc>(context);

    appBar = AppBar(
      leading: IconButton(
        icon: Icon(
          Icons.clear_rounded,
          color: Colors.white,
          size: 4.0.h,
        ),
        onPressed: () {
          bloc.add(TulisStatusEvent(imageFile: null, isVisibility: false));
          Navigator.of(context).pop();
        },
      ),
      backgroundColor: Colors.lightBlue,
      title: Text('Buat Postingan',
          style: TextStyle(
              fontSize: 14.0.sp,
              fontWeight: FontWeight.bold,
              fontFamily: 'saira condensed')),
    );

    return BlocBuilder<TempatTulisStatusBloc, TempatTulisStatusState>(
      builder: (context, state) => Container(
        height: (state.isVisible) ? 70.0.h : 61.0.h,
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            resizeToAvoidBottomPadding: false,
            appBar: appBar,
            body: ListView(children: [
              Column(
                children: [
                  SizedBox(
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border(
                              top: BorderSide(color: Colors.grey[200]),
                              bottom: BorderSide(color: Colors.grey[200]))),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 1.0.w, vertical: 1.0.h),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                // avatar
                                CircleAvatar(
                                  radius: 3.5.h,
                                  backgroundImage: (fotoProfile == 'default_pp')
                                      ? AssetImage(fotoProfile)
                                      : CachedNetworkImageProvider('${ServerApp.url}${fotoProfile}'),
                                ),
                                headerName(),
                                Material(
                                  color: Colors.transparent,
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.image,
                                      size: 4.0.h,
                                      color: Colors.green[400],
                                    ),
                                    onPressed: () {
                                      showModalBottomSheet(
                                          context: context,
                                          builder: (context) =>
                                              bottomImagePicker(context));
                                    },
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  textFieldTulisStatus(),
                  // gambar jika diupload
                  gambarUploadStatus(),

                  // divider untuk memberikan batas antara container gambar yg di upload dengan button bawahnya
                  Divider(
                    height: 2,
                  ),

                  // button untuk upload gambar / pilih gambar
                  buttonPilihGambar(context),

                  // button untuk kirim posting status
                  buttonPosting(pickedFile, state, context)
                ],
              ),
            ])),
      ),
    );
  }

  ElevatedButton buttonPosting(PickedFile pickedFile,
      TempatTulisStatusState tsstate, BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          minimumSize: Size.fromHeight(7.0.h),
          primary: Colors.lightBlue,
          onPrimary: Colors.white,
          textStyle: TextStyle(fontSize: 13.0.sp, fontWeight: FontWeight.bold)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 10),
            child: Text('Posting'),
          )
        ],
      ),
      onPressed: () async {
        String idUser = await UserSecureStorage.getIdUser();
        // String imgPath = (tsstate.imageFile.path == null && tsstate.imageFile == null) ? 'no_image' : tsstate.imageFile.path;
        String imgPath = (pickedFile != null && pickedFile.path.isNotEmpty) ? pickedFile.path : 'no_image';
        StatusUserServices.sendDataStatus(
                username: username,
                idUser: idUser,
                imgPath: imgPath,
                caption: controllerStatus.text,
                foto_profile: fotoProfile)
            .then((value) {
          showLoading(context);
          value.send().then((value) {
            http.Response.fromStream(value).then((value) {
              String message = json.decode(value.body);
              if (message != null && message.isNotEmpty) {
                Navigator.of(context)..pop()..pop();
                statusBloc.add(StatusUserEventRefresh());
              }
            });
          });
        });
      },
    );
  }

  ElevatedButton buttonPilihGambar(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          minimumSize: Size.fromHeight(6.0.h),
          primary: Colors.white,
          onPrimary: Colors.green // splash color
          ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(
            Icons.image_outlined,
            color: Colors.green[700],
          ),
          Padding(
            padding: EdgeInsets.only(left: 1.0.w),
            child: Text(
              'Pilih gambar',
              style: TextStyle(color: Colors.grey[600], fontSize: 11.0.sp),
            ),
          )
        ],
      ),
      onPressed: () {
        showModalBottomSheet(
            context: context,
            builder: ((builder) => bottomImagePicker(context)));
      },
    );
  }

  BlocBuilder gambarUploadStatus() {
    return BlocBuilder<TempatTulisStatusBloc, TempatTulisStatusState>(
      builder: (context, state) => Visibility(
        visible: state.isVisible,
        child: Container(
          // width: mediaSizeWidth,
          color: Colors.white,
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 2.0.w),
                child: Image(
                  alignment: Alignment.topLeft,
                  repeat: ImageRepeat.noRepeat,
                  image: (state.imageFile != null)
                      ? FileImage(File(state.imageFile.path))
                      : AssetImage(''),
                  // image: (imageFile != null)
                  //     ? FileImage(File(imageFile.path))
                  //     : AssetImage(''),
                  height: 8.0.h,
                  width: 20.0.w,
                ),
              ),

              //  button hapus gambar
              Padding(
                padding: EdgeInsets.only(left: 1.5.w),
                child: RaisedButton(
                    elevation: 0,
                    color: Colors.blueGrey[100],
                    child: Text(
                      'Hapus',
                      style: TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 10.0.sp),
                    ),
                    onPressed: () {
                      // url foto dari container foto status dikosongin
                      // widget container ini akan di hide
                      // setState(() {
                      //   isVisible = false;
                      //   imageFile = null;
                      // });
                      bloc.add(TulisStatusEvent(
                          imageFile: null, isVisibility: false));
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // sebelumnya pake sizebox
  Padding textFieldTulisStatus() {
    return Padding(
      padding: EdgeInsets.only(left: 1.0.w),
      child: TextField(
        controller: controllerStatus,
        maxLines: 10,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Apa yang anda pikirkan ?',
            hintStyle: TextStyle(fontSize: 11.0.sp)),
      ),
    );
  }

  Padding headerName() {
    return Padding(
      padding: EdgeInsets.only(left: 1.5.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            children: [
              Text(
                username,
                style: TextStyle(fontFamily: 'poppins', fontSize: 10.0.sp),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                '$rt $rw',
                style: TextStyle(
                    fontFamily: 'poppins',
                    color: Colors.lightBlue,
                    fontSize: 10.0.sp),
              )
            ],
          )
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
    pickedFile = await _picker.getImage(source: source, imageQuality: 50);
    // setState(() {
    //   if (pickedFile != null) {
    //     imageFile = pickedFile;
    //     isVisible = true;
    //   }
    // });

    if (pickedFile != null) {
      bloc.add(TulisStatusEvent(imageFile: pickedFile, isVisibility: true));
    }
  }
}
