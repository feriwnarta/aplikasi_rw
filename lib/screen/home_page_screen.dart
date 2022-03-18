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
  String userName = 'Citra susanti'.toUpperCase();
  String rw = 'RW 007';

  @override
  Widget build(BuildContext context) {
    heightAppBar = MediaQuery.of(context).size.height * 0.15;
    positionedCardStatus = MediaQuery.of(context).size.height * 0.03;
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
                      // shadow untuk belakang rounded circle
                      boxShadow: [
                        BoxShadow(color: Colors.lightBlue, blurRadius: 20)
                      ],
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
                        width: MediaQuery.of(context).size.width * 0.95,
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
                                        color: Colors.grey[200],
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
                                        color: Colors.teal,
                                        fontWeight: FontWeight.w700,
                                      ),
                                      maxLines: 2,
                                    ),
                                  ))
                                ],
                              )
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
          Column(children: listStatus),
        ],
      ),
    );
  }

  // list berisi status warga
  // setiap data didatabase akan disimpan dalam template container yang sudah dibikin
  List<Widget> listStatus = [
    // data url
    // String namaUser, rw, waktuUpload, urlFotoStatus, fotoProfile, caption, jumlahLike, jumlahKomen;
    StatusWarga(
        'Siti',
        'RW 07',
        '15 menit',
        'https://lovelybogor.com/wp-content/uploads/2016/02/Pedagang-Kumang-Di-Bogor-Fotografi-Jalanan-01.jpg',
        'https://media.suara.com/pictures/653x366/2021/09/18/26068-jung-ho-yeong.jpg',
        'pedagang kumang berjualan dipinggir jalan deket rumah pak RT',
        '12',
        '11'),
    StatusWarga(
      'Joko',
      'RW 07',
      '30 menit',
      'https://asset-a.grid.id/crop/0x0:0x0/780x800/photo/bobofoto/original/17852_bagaimana-air-hujan-bisa-merusak-jalanan-aspal.jpg',
      'https://akcdn.detik.net.id/visual/2022/02/04/ainun-najib-1_169.jpeg?w=650',
      'Jalanan rusak di RT 07 ',
      '15',
      '21',
    ),
    StatusWarga(
        'Susanto',
        'RW 07',
        '1 jam',
        'https://cdn-2.tstatic.net/kaltim/foto/bank/images/jalan-asmawarman1_20160202_133513.jpg',
        'https://disk.mediaindonesia.com/thumbs/600x400/news/2020/10/fe8644c762c90d7b7ff16ed49786cd96.jpg',
        'Lampu jalanan kurang penerangan',
        '11',
        '19'),

    StatusWarga(
        'Yani',
        'RW 07',
        '2 jam yang lalu',
        'https://media.suara.com/pictures/653x366/2020/10/03/28146-hobi-tanaman-hias.jpg',
        'https://www.superprof.co.id/gambar/guru/rumah-guru-saya-orang-indonesia-asli-menawarkan-belajar-bahasa-indonesia-simple-untuk-orang-asing.jpg',
        'Dijual tanaman hias hubungi saya segera..',
        '19',
        '25'),
    // StatusWarga(),
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
}
