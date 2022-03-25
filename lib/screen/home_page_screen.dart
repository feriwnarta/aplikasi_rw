import 'package:aplikasi_rw/screen/tempat_tulis_status.dart';
import 'package:aplikasi_rw/status_item_warga/status_warga.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePageScreen extends StatefulWidget {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  HomePageScreen(this.scaffoldKey);

  @override
  State<HomePageScreen> createState() => _HomePageScreenState(this.scaffoldKey);
}

class _HomePageScreenState extends State<HomePageScreen> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  _HomePageScreenState(this.scaffoldKey);

  // tinggi utuk app bar
  double heightBackgroundRounded;
  //  posisi dari atas untuk card status
  double positionedCardStatus;
  // tinggi card status
  double heightCardStatus;
  // color rounded
  var colorRoundedCircle = Color(0xff8CBBF1);
  // warna card
  var colorCard = Color(0xffFCEECB);

  // demo user
  String userName = 'Citra susanti';
  String rt = 'RT 02';
  String rw = 'RW 07';
  String fotoProfile =
      'http://rawakalong.desa.id/wp-content/uploads/2019/02/person2.jpg';

  double mediaSizeHeight;

  // boolean untuk mengecek apakah keyboard terbuka atau tidak
  bool isKeyboardOpen;
  double keyboardOpenHeight;

  @override
  Widget build(BuildContext context) {
    keyboardOpenHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;

    // boolean untuk mengecek apakah keyboard terbuka atau tidak
    isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom != 0;

    mediaSizeHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    final mediaSizeWidth = MediaQuery.of(context).size.width;

    // ukuran media query dikurangin dengan tinggi status
    heightBackgroundRounded = mediaSizeHeight * 0.25;
    positionedCardStatus = mediaSizeHeight * 0.1;
    heightCardStatus = mediaSizeHeight * 0.24;

    return Scaffold(
      // resizeToAvoidBottomInset: false,

      body: Container(
        color: Colors.white,
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                Stack(children: [
                  // Rounded circle background
                  roundedCircleBackground(mediaSizeWidth),

                  /**
                   * card status berisi avatar, container untuk membuat status
                   * dan informasi nama user serta rt rw
                   */

                  // cardStatus(context)
                ]),
              ],
            ),

            // status dari warga
            Column(children: listStatus),
          ],
        ),
      ),
    );
  }

  Container roundedCircleBackground(double mediaSizeWidth) {
    return Container(
        width: mediaSizeWidth,
        // height: heightBackgroundRounded,
        color: Colors.white,
        // decoration: BoxDecoration(
        //     gradient: LinearGradient(
        //         colors: [Color(0xff2196F3), Colors.lightBlueAccent],
        //         begin: Alignment.topLeft,
        //         end: Alignment.topRight),

        //     // color: Color(0xff2196F3),
        //     // shadow untuk belakang rounded circle
        //     // boxShadow: [
        //     //   BoxShadow(color: Colors.lightBlue, blurRadius: 20)
        //     // ],
        //     borderRadius: BorderRadius.only(
        //       bottomLeft: Radius.circular(20),
        //     )),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 5),
                  child: RotatedBox(
                    quarterTurns: 1,
                    child: IconButton(
                        icon: Icon(
                          Icons.bar_chart_sharp,
                          color: Colors.black,
                          size: mediaSizeWidth * 0.085,
                        ),
                        onPressed: () => scaffoldKey.currentState.openDrawer()),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 25, top: 15),
                  child: Text(
                    'NEXT G - RW',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 19,
                      fontFamily: 'poppins',
                    ),
                  ),
                  //Image(
                  //   image: AssetImage('assets/img/logo.png'),
                  //   fit: BoxFit.cover,
                  //   repeat: ImageRepeat.noRepeat,
                  // )
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 20, top: 10),
                  child: Text(
                    '$userName, BLOK XY 9 NO 21',
                    style: TextStyle(
                      fontSize: 19,
                      fontFamily: 'poppins',
                    ),
                  ),
                )
              ],
            ),
            cardStatus(context),
            Padding(
              padding: const EdgeInsets.only(left: 15, top: 10),
              child: Text(
                'Kabar Hari ini',
                style: TextStyle(fontFamily: 'poppins', fontSize: 15),
              ),
            ),
          ],
        ));
  }

  // versi update
  Padding cardStatus(BuildContext context) {
    double paddingHeightCard =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;

    //height: heightCardStatus,
    //width: MediaQuery.of(context).size.width * 0.95,

    return Padding(
      padding: EdgeInsets.only(top: paddingHeightCard * 0.02),
      child: Align(
        alignment: Alignment.center,
        child: SizedBox(
          height: heightCardStatus,
          width: MediaQuery.of(context).size.width * 0.95,
          child: Card(
            elevation: 10,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  gradient: LinearGradient(
                      colors: [Color(0xff2297F4), Color(0xff3ABBFD)])),
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
                              fotoProfile),
                        ),
                      ),

                      // container ini berisi tempat menulis status
                      // gesture detector jika tulis status diklik
                      GestureDetector(
                        onTap: () {
                          // Navigator.of(context).push(MaterialPageRoute(
                          //     builder: (context) => TempatTulisStatus(
                          //           fotoProfile: fotoProfile,
                          //           nama: userName,
                          //           rt: rt,
                          //           rw: rw,
                          //         )));

                          showModalBottomSheet(
                              isScrollControlled: true,
                              context: context,
                              builder: (builder) => TempatTulisStatus(
                                    fotoProfile: fotoProfile,
                                    nama: userName,
                                    rt: rt,
                                    rw: rw,
                                    mediaSizeHeightParent: mediaSizeHeight,
                                  ));
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: 20, left: 10),
                          padding: EdgeInsets.only(top: 10),
                          height: 40,
                          width: MediaQuery.of(context).size.width * 0.58,
                          child: Text(
                            'Apa yang anda sedang pikirkan ?',
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.035),
                            textAlign: TextAlign.center,
                          ),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(40)),
                        ),
                      )
                    ],
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Divider(
                      color: Colors.white,
                      thickness: 1,
                      indent: 20,
                      endIndent: 20,
                    ),
                  ),

                  IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FlatButton.icon(
                            onPressed: () {},
                            icon: Icon(
                              FontAwesomeIcons.camera,
                              color: Colors.white,
                            ),
                            label: Text(
                              'Camera',
                              style: TextStyle(color: Colors.white),
                            )),
                        VerticalDivider(
                          color: Colors.white,
                          width: 50,
                          thickness: 1,
                          indent: 15,
                          endIndent: 10,
                        ),
                        FlatButton.icon(
                            onPressed: () {},
                            icon: Icon(
                              FontAwesomeIcons.solidImage,
                              color: Colors.white,
                              size: 32,
                            ),
                            label: Text(
                              'Gallery',
                              style: TextStyle(color: Colors.white),
                            )),
                      ],
                    ),
                  )

                  // Row(
                  //   children: [
                  //     Expanded(
                  //         child: Padding(
                  //       padding: EdgeInsets.only(left: 20, right: 20, top: 15),
                  //       child: Text(
                  //         '$userName $rt $rw',
                  //         style: TextStyle(
                  //           color: Colors.teal,
                  //           fontWeight: FontWeight.w700,
                  //         ),
                  //         maxLines: 2,
                  //       ),
                  //     ))
                  //   ],
                  // )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /**
   * versi Sebelumnya
   */

  // Padding cardStatus(BuildContext context) {
  //   return Padding(
  //     padding: EdgeInsets.only(top: positionedCardStatus),
  //     child: Align(
  //       alignment: Alignment.center,
  //       child: Stack(children: [
  //         SizedBox(
  //           height: heightCardStatus,
  //           width: MediaQuery.of(context).size.width * 0.95,
  //           child: Card(
  //             elevation: 10,
  //             color: Colors.white,
  //             shape: RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.circular(20)),
  //             child: Column(
  //               children: [
  //                 /**
  //                            * bagian dalam card status yang isinya dapat berubah
  //                            * mulai dari avatar, nama user, dan rw user
  //                            */
  //                 Row(
  //                   children: [
  //                     Padding(
  //                       padding: EdgeInsets.only(left: 20, top: 20),
  //                       child: CircleAvatar(
  //                         radius: 35,
  //                         backgroundImage: NetworkImage(
  //                             // gambar profile user
  //                             fotoProfile),
  //                       ),
  //                     ),

  //                     // container ini berisi tempat menulis status
  //                     // gesture detector jika tulis status diklik
  //                     GestureDetector(
  //                       onTap: () {
  //                         // Navigator.of(context).push(MaterialPageRoute(
  //                         //     builder: (context) => TempatTulisStatus(
  //                         //           fotoProfile: fotoProfile,
  //                         //           nama: userName,
  //                         //           rt: rt,
  //                         //           rw: rw,
  //                         //         )));

  //                         showModalBottomSheet(
  //                             isScrollControlled: true,
  //                             context: context,
  //                             builder: (builder) => TempatTulisStatus(
  //                                   fotoProfile: fotoProfile,
  //                                   nama: userName,
  //                                   rt: rt,
  //                                   rw: rw,
  //                                   mediaSizeHeightParent: mediaSizeHeight,
  //                                 ));
  //                       },
  //                       child: Container(
  //                         margin: EdgeInsets.only(top: 20, left: 10),
  //                         padding: EdgeInsets.only(top: 10),
  //                         height: 40,
  //                         width: MediaQuery.of(context).size.width * 0.58,
  //                         child: Text(
  //                           'Apa yang anda sedang pikirkan ?',
  //                           style: TextStyle(
  //                               color: Colors.black,
  //                               fontSize:
  //                                   MediaQuery.of(context).size.width * 0.035),
  //                           textAlign: TextAlign.center,
  //                         ),
  //                         decoration: BoxDecoration(
  //                             color: Colors.grey[200],
  //                             borderRadius: BorderRadius.circular(40)),
  //                       ),
  //                     )
  //                   ],
  //                 ),
  //                 Row(
  //                   children: [
  //                     Expanded(
  //                         child: Padding(
  //                       padding: EdgeInsets.only(left: 20, right: 20, top: 15),
  //                       child: Text(
  //                         '$userName $rt $rw',
  //                         style: TextStyle(
  //                           color: Colors.teal,
  //                           fontWeight: FontWeight.w700,
  //                         ),
  //                         maxLines: 2,
  //                       ),
  //                     ))
  //                   ],
  //                 )
  //               ],
  //             ),
  //           ),
  //         ),
  //       ]),
  //     ),
  //   );
  // }

  // list berisi status warga
  // setiap data didatabase akan disimpan dalam template container yang sudah dibikin
  List<Widget> listStatus = [
    // data url
    // String namaUser, rw, waktuUpload, urlFotoStatus, fotoProfile, caption, jumlahLike, jumlahKomen;

    StatusWarga(
      namaUser: 'Siti',
      rw: 'RW 07',
      waktuUpload: '15 menit',
      urlFotoStatus:
          'https://lovelybogor.com/wp-content/uploads/2016/02/Pedagang-Kumang-Di-Bogor-Fotografi-Jalanan-01.jpg',
      fotoProfile:
          'https://media.suara.com/pictures/653x366/2021/09/18/26068-jung-ho-yeong.jpg',
      caption:
          'pedagang kumang berjualan dipinggir jalan deket rumah pak RT pedagang kumang berjualan dipinggir jalan deket rumah pak RT pedagang kumang berjualan dipinggir jalan deket rumah pak RT pedagang kumang berjualan dipinggir jalan deket rumah pak RT pedagang kumang berjualan dipinggir jalan deket rumah pak RT pedagang kumang berjualan dipinggir jalan deket rumah pak RT pedagang kumang berjualan dipinggir jalan deket rumah pak RT pedagang kumang berjualan dipinggir jalan deket rumah pak RT',
      jumlahKomen: '12',
      jumlahLike: '19',
    ),
    StatusWarga(
      namaUser: 'Joko',
      rw: 'RW 07',
      waktuUpload: '30 menit',
      urlFotoStatus:
          'https://asset-a.grid.id/crop/0x0:0x0/780x800/photo/bobofoto/original/17852_bagaimana-air-hujan-bisa-merusak-jalanan-aspal.jpg',
      fotoProfile:
          'https://akcdn.detik.net.id/visual/2022/02/04/ainun-najib-1_169.jpeg?w=650',
      caption: 'Jalanan rusak di RT 07 ',
      jumlahKomen: '15',
      jumlahLike: '21',
    ),

    StatusWarga(
        namaUser: 'Susanto',
        rw: 'RW 07',
        waktuUpload: '1 jam',
        urlFotoStatus:
            'https://cdn-2.tstatic.net/kaltim/foto/bank/images/jalan-asmawarman1_20160202_133513.jpg',
        fotoProfile:
            'https://disk.mediaindonesia.com/thumbs/600x400/news/2020/10/fe8644c762c90d7b7ff16ed49786cd96.jpg',
        caption: 'Lampu jalanan kurang penerangan',
        jumlahKomen: '11',
        jumlahLike: '19'),

    StatusWarga(
        namaUser: 'Yani',
        rw: 'RW 07',
        waktuUpload: '2 jam yang lalu',
        urlFotoStatus:
            'https://media.suara.com/pictures/653x366/2020/10/03/28146-hobi-tanaman-hias.jpg',
        fotoProfile:
            'https://www.superprof.co.id/gambar/guru/rumah-guru-saya-orang-indonesia-asli-menawarkan-belajar-bahasa-indonesia-simple-untuk-orang-asing.jpg',
        caption: 'Dijual tanaman hias hubungi saya segera..',
        jumlahKomen: '19',
        jumlahLike: '25'),
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
