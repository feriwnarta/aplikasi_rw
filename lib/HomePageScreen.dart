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

  @override
  Widget build(BuildContext context) {
    heightAppBar = MediaQuery.of(context).size.height * 0.15;
    positionedCardStatus = MediaQuery.of(context).size.height * 0.05;
    heightCardStatus = MediaQuery.of(context).size.height * 0.2;

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
                              )
                            ],
                          ),
                        ),
                      ),
                    ]),
                  ),
                )
              ])
            ],
          ),
        ],
      ),
    );
  }
}
