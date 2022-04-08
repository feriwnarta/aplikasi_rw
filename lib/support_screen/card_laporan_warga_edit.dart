import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

class CardLaporanWargaEdit extends StatefulWidget {
  final String noTickets;

  CardLaporanWargaEdit({this.noTickets});

  @override
  State<CardLaporanWargaEdit> createState() =>
      _CardLaporanWargaEditState(noTickects: noTickets);
}

class _CardLaporanWargaEditState extends State<CardLaporanWargaEdit> {
  // data laporan
  final String noTickects;
  String imageReportUrl =
      'https://cloud.jpnn.com/photo/arsip/normal/2021/12/25/jalan-protokol-di-jalan-basuki-rahmad-kota-palembang-sumsel-2ris.jpg';

  _CardLaporanWargaEditState({this.noTickects});

  PickedFile imageFile;
  final _picker = ImagePicker();
  bool isVisible = false;
  double mediaSizeWidth, mediaSizeHeigth;
  final appBar = AppBar(
    brightness: Brightness.light,
    title: Text('Edit View'),
  );

  @override
  Widget build(BuildContext context) {
    mediaSizeHeigth = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        appBar.preferredSize.height;
    mediaSizeWidth =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;

    isVisible = true;

    return Scaffold(
      appBar: appBar,
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: SizedBox(
                  height: mediaSizeHeigth * 0.06,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Card(
                      elevation: 2,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Text(
                              'No tickets',
                              style: TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Text(noTickects,
                              style: TextStyle(
                                  color: Colors.indigo,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.circular(10)),
                      hintText: 'title'),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: TextField(
                  maxLines: 10,
                  decoration: InputDecoration(
                      hintText: 'contents of the report',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
              ),
              Divider(
                thickness: 1,
              ),
              Visibility(
                visible: true,
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
                              image: (imageFile != null)
                                  ? FileImage(File(imageFile.path))
                                  : NetworkImage(imageReportUrl),
                              height: mediaSizeHeigth * 0.08,
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
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                ),
                                onPressed: () {
                                  // url foto dari container foto status dikosongin
                                  // widget container ini akan di hide
                                  setState(() {
                                    isVisible = false;
                                    imageFile = null;
                                  });
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
              Divider(
                thickness: 1,
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: SizedBox(
                  width: mediaSizeWidth * 0.9,
                  height: mediaSizeHeigth * 0.06,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)))),
                    child: Text('Post'),
                    onPressed: () {
                      // mengirim title report
                      // mengirim content report
                      // mengirim gambar report
                      // generate notickets (bulan, tanggal, urutan ticket)

                      // ambil banyak tiket yang sudah dibuat untuk dimasukan keurutan ticket
                      // status yang dikirim pertama kali adalah listed
                    },
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  void getImage(ImageSource source) async {
    final pickedFile = await _picker.getImage(source: source);
    setState(() {
      if (pickedFile != null) {
        imageFile = pickedFile;
        isVisible = true;
      }
    });
  }
}
