import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    // media query hanya body saja
    final mediaSizeHeight = MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top;

    final mediaSizeWidth = MediaQuery.of(context).size.width;

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
                                Icons.photo_size_select_actual_rounded,
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
                height: mediaSizeHeight * 0.3,
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
              )
            ],
          ),
        ]));
  }
}
