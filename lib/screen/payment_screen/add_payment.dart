import 'dart:io';

import 'package:aplikasi_rw/bloc/tempat_tulis_status_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

class AddPayment extends StatelessWidget {
  PickedFile imageFile; // akan dikirim kedatabase
  final _picker = ImagePicker();
  double mediaSizeHeight, mediaSizeWidth;

  TempatTulisStatusBloc bloc;
  @override
  Widget build(BuildContext context) {
    mediaSizeHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    mediaSizeWidth = MediaQuery.of(context).size.width;

    bloc = BlocProvider.of<TempatTulisStatusBloc>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Payment')),
      body: BlocBuilder<TempatTulisStatusBloc, TempatTulisStatusState>(
        builder: (context, state) => Container(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: TextField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                            borderRadius: BorderRadius.circular(10)),
                        hintText: 'name payment'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: TextField(
                    maxLines: 10,
                    decoration: InputDecoration(
                        hintText: 'description',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Text(
                    'Upload proof of transfer',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                Visibility(
                  visible: state.isVisible,
                  child: Column(
                    children: [
                      Divider(
                        thickness: 1,
                        height: 5,
                      ),
                      Container(
                        width: mediaSizeWidth,
                        color: Colors.white,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Image(
                                alignment: Alignment.center,
                                repeat: ImageRepeat.noRepeat,
                                image: (state.imageFile != null)
                                    ? FileImage(File(state.imageFile.path))
                                    : AssetImage(''),
                                height: mediaSizeHeight * 0.08,
                                width: mediaSizeWidth * 0.2,
                              ),
                            ),

                            //  button hapus gambar
                            Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: RaisedButton(
                                  elevation: 0,
                                  color: Colors.blueGrey[100],
                                  child: Text(
                                    'Hapus',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500),
                                  ),
                                  onPressed: () {
                                    // url foto dari container foto status dikosongin
                                    // widget container ini akan di hide
                                    // setState(() {
                                    //   isVisible = false;
                                    //   imageFile = null;
                                    // });
                                    bloc.add(TulisStatusEvent(
                                        isVisibility: false, imageFile: null));
                                  }),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        thickness: 1,
                        height: 10,
                      ),
                    ],
                  ),
                ),
                IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FlatButton.icon(
                          icon: Icon(
                            FontAwesomeIcons.camera,
                            color: Colors.blue,
                          ),
                          label: Text(''),
                          onPressed: () {
                            getImage(ImageSource.camera);
                          }),
                      VerticalDivider(
                        color: Colors.grey,
                        width: 50,
                        thickness: 1,
                        indent: 15,
                        endIndent: 10,
                      ),
                      FlatButton.icon(
                          icon: Icon(
                            FontAwesomeIcons.solidImage,
                            color: Colors.blue,
                          ),
                          label: Text(''),
                          onPressed: () {
                            getImage(ImageSource.gallery);
                          })
                    ],
                  ),
                ),
                SizedBox(
                  height: (state.isVisible) ? mediaSizeHeight * 0.2 : mediaSizeHeight * 0.3,
                ),
                Center(
                  child: SizedBox(
                    width: mediaSizeWidth * 0.9,
                    height: mediaSizeHeight * 0.06,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10)))),
                      child: Text('Post'),
                      onPressed: () {
                        // mengirim title report
                        // mengirim content report
                        // mengirim gambar report
                        // generate notickets (bulan, tanggal, urutan ticket)

                        // status yang dikirim pertama kali adalah listed
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void getImage(ImageSource source) async {
    final pickedFile = await _picker.getImage(source: source);

    if (pickedFile != null) {
      bloc.add(TulisStatusEvent(isVisibility: true, imageFile: pickedFile));
    }
  }
}
