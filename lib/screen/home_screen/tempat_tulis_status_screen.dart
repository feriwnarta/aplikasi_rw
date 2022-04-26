import 'dart:io';

import 'package:aplikasi_rw/bloc/tempat_tulis_status_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

//ignore: must_be_immutable
class TempatTulisStatus extends StatelessWidget {
  TempatTulisStatus(
      {this.fotoProfile,
      this.nama,
      this.rt,
      this.rw,
      });

  /*
   * field untuk menyimpan image picker
   */
  final _picker = ImagePicker();

  // app bar disimpan ke variabel untuk diambil tingginya
  AppBar appBar;

  // field untuk data user
  String fotoProfile, nama, rt, rw;
  

  TempatTulisStatusBloc bloc;

  Widget build(BuildContext context) {
    bloc = BlocProvider.of<TempatTulisStatusBloc>(context);

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
        height: (state.isVisible)
            ? 70.0.h
            : 62.0.h,
        child: Scaffold(
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
                        padding: EdgeInsets.symmetric(horizontal: 1.0.w, vertical: 1.0.h),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                // avatar
                                CircleAvatar(
                                  radius: 4.0.h,
                                  backgroundImage: NetworkImage(fotoProfile),
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
                  buttonPosting()
                ],
              ),
            ])),
      ),
    );
  }

  ElevatedButton buttonPosting() {
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
      onPressed: () {},
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
                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 10.0.sp),
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
  Container textFieldTulisStatus() {
    return Container(
      height: 30.0.h,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(color: Colors.grey[200]))),
      child: Padding(
        padding: EdgeInsets.only(left: 1.0.w),
        child: TextField(
          maxLines: 10,
          decoration: InputDecoration(
              border: InputBorder.none, hintText: 'Apa yang anda pikirkan ?', hintStyle: TextStyle(fontSize: 11.0.sp)),
        ),
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
                nama,
                style: TextStyle(fontFamily: 'poppins', fontSize: 10.0.sp),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                '$rt $rw',
                style:
                    TextStyle(fontFamily: 'poppins', color: Colors.lightBlue, fontSize: 10.0.sp),
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
                      style:
                          TextStyle(fontSize: 13.0.sp, fontFamily: 'Pt Sans Narrow'),
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
                    style:
                        TextStyle(fontSize: 13.0.sp, fontFamily: 'Pt Sans Narrow'),
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
    final pickedFile = await _picker.getImage(source: source);
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
