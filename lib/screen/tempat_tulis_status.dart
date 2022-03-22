import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class TempatTulisStatus extends StatefulWidget {
  // field untuk data user
  String fotoProfile, nama, rt, rw;

  TempatTulisStatus({this.fotoProfile, this.nama, this.rt, this.rw});

  @override
  State<TempatTulisStatus> createState() => _TempatTulisStatusState(
      fotoProfile: fotoProfile, nama: this.nama, rt: this.rt, rw: this.rw);
}

class _TempatTulisStatusState extends State<TempatTulisStatus> {
  _TempatTulisStatusState({this.fotoProfile, this.nama, this.rt, this.rw});

  /**
     * field untuk menyimpan image picker
     */
  PickedFile _imageFile;
  final _picker = ImagePicker();

  // app bar disimpan ke variabel untuk diambil tingginya
  var appBar = AppBar(
    backgroundColor: Colors.lightBlue,
    title: Text('Buat Postingan',
        style: TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.bold,
            fontFamily: 'saira condensed')),
  );

  // field untuk data user
  String fotoProfile, nama, rt, rw;

  // height bottom image picker
  double heightBottomImagePicker;

  // field untuk visibility container hapus gambar
  bool isVisible = false;

  bool isDelete = false;
  
  @override
  Widget build(BuildContext context) {
    // media query hanya body saja
    final mediaSizeHeight = MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top;

    final mediaSizeWidth = MediaQuery.of(context).size.width;

    heightBottomImagePicker = MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top;

    return Scaffold(
        appBar: appBar,
        body: ListView(children: [
          Column(
            children: [
              // header informasi user
              SizedBox(
                width: mediaSizeWidth,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                          top: BorderSide(color: Colors.grey[200]),
                          bottom: BorderSide(color: Colors.grey[200]))),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            // avatar
                            CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage(fotoProfile),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(
                                    children: [
                                      // Icon(
                                      //   Icons.person_sharp,
                                      //   color: Colors.blueGrey,
                                      // ),
                                      Text(
                                        nama,
                                        style: TextStyle(fontFamily: 'poppins'),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      // Icon(
                                      //   Icons.home_filled,
                                      //   color: Colors.blueGrey,
                                      // ),
                                      Text(
                                        '$rt $rw',
                                        style: TextStyle(
                                            fontFamily: 'poppins',
                                            color: Colors.lightBlue),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.image,
                                color: Colors.green[400],
                              ),
                              onPressed: () {},
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: mediaSizeHeight * 0.4,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border:
                          Border(bottom: BorderSide(color: Colors.grey[200]))),
                  child: Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: TextField(
                      maxLines: 9,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Apa yang anda pikirkan ?'),
                    ),
                  ),
                ),
              ),

              // gambar jika diupload
              Visibility(
                visible: isVisible,
                child: Container(
                  width: mediaSizeWidth,
                  color: Colors.white,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Image(
                          alignment: Alignment.topLeft,
                          repeat: ImageRepeat.noRepeat,
                          image: (_imageFile != null && !isDelete)
                              ? FileImage(File(_imageFile.path))
                              : AssetImage(''),
                          height: mediaSizeHeight * 0.09,
                          // width: mediaSizeWidth * 0.1,
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
                                isDelete = !isDelete;
                              });
                            }),
                      ),
                    ],
                  ),
                ),
              ),

              // divider untuk memberikan batas antara container gambar yg di upload dengan button bawahnya
              Divider(
                height: 2,
              ),

              // button untuk upload gambar
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: Size.fromHeight(mediaSizeHeight * 0.07),
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
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        'Pilih gambar',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    )
                  ],
                ),
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      builder: ((builder) =>bottomImagePicker(context)));
                  // untuk menguabh is delete menjadi false, sehingga gambar akan kembali muncul
                  // saat dipilih ulang
                  if(isDelete) 
                  isDelete = !isDelete;

                },
              ),

              // button untuk kirim posting status
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: Size.fromHeight(mediaSizeHeight * 0.08),
                    primary: Colors.lightBlue,
                    onPrimary: Colors.white,
                    textStyle:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
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
              )
            ],
          ),
        ]));
  }

  Widget bottomImagePicker(BuildContext context) => Container(
        margin: EdgeInsets.only(top: 20),
        width: MediaQuery.of(context).size.width,
        height: heightBottomImagePicker * 0.18,
        child: Column(
          children: [
            Text(
              'Pilih gambar',
              style: TextStyle(fontSize: 20, fontFamily: 'Pt Sans Narrow'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FlatButton.icon(
                    icon: Icon(Icons.camera_alt),
                    label: Text(
                      'Kamera',
                      style:
                          TextStyle(fontSize: 18, fontFamily: 'Pt Sans Narrow'),
                    ),
                    onPressed: () {
                      getImage(ImageSource.camera);
                      Navigator.of(context).pop(); // -> digunakan untuk menutup show modal bottom sheet secara programatic
                    }),
                FlatButton.icon(
                  icon: Icon(Icons.image),
                  label: Text(
                    'Galery',
                    style:
                        TextStyle(fontSize: 18, fontFamily: 'Pt Sans Narrow'),
                  ),
                  onPressed: () {
                    getImage(ImageSource.gallery);
                    Navigator.of(context).pop(); // -> digunakan untuk menutup show modal bottom sheet secara programatic
                  },
                )
              ],
            )
          ],
        ),
      );

  void getImage(ImageSource source) async {
    final pickedFile = await _picker.getImage(source: source);
    setState(() {
      if (pickedFile != null) {
        _imageFile = pickedFile;
        isVisible = true;
      }
    });
  }
}
