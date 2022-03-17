import 'package:aplikasi_rw/status_item_warga/status_warga.dart';
import 'package:flutter/material.dart';

class HomePageScreen extends StatefulWidget {
  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  // tinggi utuk app bar
  double heightAppBar;
  //  posisi dari atas untuk card status
  double positionedCardStatus;
  // tinggi card status
  double heightCardStatus;
  // color rounded
  var colorRoundedCircle = Color(0xff8CBBF1);
  // warna card
  var colorCard = Color(0xffFCEECB);

  // demo user
  String userName = 'feri winarta'.toUpperCase();
  String rw = 'RW 007';

  // objek status warga
  StatusWarga statusWarga = StatusWarga();

  @override
  Widget build(BuildContext context) {
    heightAppBar = MediaQuery.of(context).size.height * 0.15;
    positionedCardStatus = MediaQuery.of(context).size.height * 0.05;
    heightCardStatus = MediaQuery.of(context).size.height * 0.2;

    // test ambil data status warga
    List<Widget> cardStatusSampel = cardStatusWarga(sampelStatus());

    return Container(
      color: Colors.grey[200],
      child: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              Stack(children: [
                // Rounded bottom circle
                Container(
                  height: heightAppBar,
                  decoration: BoxDecoration(
                      color: Color(0xff2196F3),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(40),
                        bottomRight: Radius.circular(40),
                      )),
                ),

                // bagian card status
                Padding(
                  padding: EdgeInsets.only(top: positionedCardStatus),
                  child: Align(
                    alignment: Alignment.center,
                    child: Stack(children: [
                      SizedBox(
                        height: heightCardStatus,
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: Card(
                          elevation: 10,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          child: Column(
                            children: [
                              /**
                               * bagian dalam card status yang isinya dapat berubah
                               * mulai dari avatar, nama user, dan rw user
                               */
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: 20, top: 20),
                                    child: CircleAvatar(
                                      radius: 35,
                                      backgroundImage: NetworkImage(
                                          // gambar profile user
                                          'http://rawakalong.desa.id/wp-content/uploads/2019/02/person2.jpg'),
                                    ),
                                  ),

                                  // container ini berisi tempat menulis status
                                  Container(
                                    margin: EdgeInsets.only(top: 20, left: 10),
                                    padding: EdgeInsets.only(top: 10),
                                    height: 40,
                                    width: MediaQuery.of(context).size.width *
                                        0.58,
                                    child: Text(
                                      'Apa yang anda sedang pikirkan ?',
                                      style: TextStyle(color: Colors.black),
                                      textAlign: TextAlign.center,
                                    ),
                                    decoration: BoxDecoration(
                                        color: Colors.grey[300],
                                        borderRadius:
                                            BorderRadius.circular(40)),
                                  )
                                ],
                              ),

                              Row(
                                children: [
                                  Expanded(
                                      child: Padding(
                                    padding: EdgeInsets.only(
                                        left: 20, right: 20, top: 15),
                                    child: Text(
                                      '$userName $rw',
                                      style: TextStyle(
                                        color: Colors.deepOrange,
                                        fontWeight: FontWeight.w700,
                                      ),
                                      maxLines: 2,
                                    ),
                                  ))
                                ],
                              )

                              /// backup nama dan rw
                              // Container(
                              //   decoration: BoxDecoration(
                              //       color: Colors.cyan[300],
                              //       borderRadius: BorderRadius.circular(7)),
                              //   margin: EdgeInsets.only(
                              //       top: 10, left: 10, right: 10),
                              //   child: Row(
                              //     children: [
                              //       Padding(
                              //         padding: EdgeInsets.all(5),
                              //         child: Text(
                              //           'aaaaaa',
                              //           textAlign: TextAlign.left,
                              //           maxLines: 2,
                              //           softWrap: true,
                              //         ),
                              //       ),
                              //     ],
                              //   ),
                              // )
                            ],
                          ),
                        ),
                      ),
                    ]),
                  ),
                )
              ]),
            ],
          ),

          // status dari warga
          Column(
            children: listStatus
          ),
        ],
      ),
    );
  }

  // list berisi status warga
  // setiap data didatabase akan disimpan dalam template container yang sudah dibikin
  List<Widget> listStatus = [
    StatusWarga(),
    StatusWarga(),
    StatusWarga(),
    StatusWarga(),
    StatusWarga(),
    StatusWarga(),
  ];

  List<Widget> cardStatusWarga(List<Widget> isiStatus) {
    List<Widget> cardStatus = [];

    for (var item in isiStatus) {
      var data = Card(
        color: Colors.red,
        child: item,
      );
      cardStatus.add(data);
    }

    return cardStatus;
  }

  List<Widget> sampelStatus() {
    return <Widget>[
      Text('Status 1'),
      Text('Status 2'),
      Text('Status 3'),
      Text('Status 4'),
      Text('Status 5'),
      Text('Status 6'),
      Text('Status 7'),
      Text('Status 8'),
      Text('Status 2'),
      Text('Status 3'),
      Text('Status 4'),
      Text('Status 5'),
      Text('Status 6'),
      Text('Status 7'),
      Text('Status 8'),
      Text('Status 2'),
      Text('Status 3'),
      Text('Status 4'),
      Text('Status 5'),
      Text('Status 6'),
      Text('Status 7'),
      Text('Status 8'),
    ];
  }
}
