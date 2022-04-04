import 'package:aplikasi_rw/model/card_news.dart';
import 'package:aplikasi_rw/model/status_user_model.dart';
import 'package:aplikasi_rw/screen/tempat_tulis_status.dart';
import 'package:aplikasi_rw/status_item_warga/status_warga.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

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

  // boolean status untuk mengecek image picker sudah memilih / memfoto gambar apa belum
  bool statusPicker = false;

  // untuk image picker
  PickedFile _imageFile;
  final _picker = ImagePicker();
  String imagePath = '';
  bool isVisible;
  PickedFile imageFile;

  // index active untuk indicator news
  int _activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    mediaSizeHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    final mediaSizeWidth = MediaQuery.of(context).size.width;

    // ukuran media query dikurangin dengan tinggi status
    heightBackgroundRounded = mediaSizeHeight * 0.25;
    positionedCardStatus = mediaSizeHeight * 0.1;
    heightCardStatus = mediaSizeHeight * 0.24;

    return Scaffold(
      // resizeToAvoidBottomInset: false,

      // sebelumnya ada container yang membukus list view
      body: ListView(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Stack(children: [
                // header app
                headerBackground(mediaSizeWidth),
              ]),
            ],
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15, top: 5, bottom: 5),
                child: Text(
                  'News',
                  style: TextStyle(fontFamily: 'poppins', fontSize: 15),
                ),
              ),
              CarouselSlider.builder(
                options: CarouselOptions(
                    // height: 180,
                    height: mediaSizeHeight * 0.24,
                    enlargeCenterPage: true,
                    disableCenter: false,
                    viewportFraction: 0.6,
                    onPageChanged: (index, _) =>
                        setState(() => _activeIndex = index)),
                itemCount: CardNews.getCardNews.length,
                itemBuilder: (context, index, realIndex) {
                  return ListView(children: [
                    Card(
                      color: Colors.blue[50],
                      elevation: 1.5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      margin: EdgeInsets.only(right: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              height: mediaSizeHeight * 0.17,
                              width: mediaSizeWidth * 0.6,
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    topRight: Radius.circular(15)),
                                child: Image(
                                  fit: BoxFit.cover,
                                  repeat: ImageRepeat.noRepeat,
                                  image: NetworkImage(
                                      CardNews.getCardNews[index].urlImageNews),
                                ),
                              )),
                          Container(
                            padding:
                                EdgeInsets.only(left: 10, top: 5, bottom: 10),
                            // margin: EdgeInsets.only(left: 10, top: 5),
                            width: 220,
                            child: Text(
                              CardNews.getCardNews[index].caption,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              softWrap: true,
                              style: TextStyle(
                                  fontFamily: 'poppins', fontSize: 12),
                            ),
                          )
                        ],
                      ),
                    ),
                  ]);
                },
              ),
              SizedBox(
                height: 17,
              ),
              Center(
                child: AnimatedSmoothIndicator(
                  activeIndex: _activeIndex,
                  count: CardNews.getCardNews.length,
                  effect: ExpandingDotsEffect(
                      dotWidth: 10,
                      dotHeight: 10,
                      activeDotColor: Colors.lightBlue,
                      dotColor: Colors.grey[350]),
                ),
              )
            ],
          ),

          // Column(
          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: [
          //     Padding(
          //       padding: const EdgeInsets.only(left: 15, top: 5),
          //       child: Text(
          //         'News',
          //         style: TextStyle(fontFamily: 'poppins', fontSize: 15),
          //       ),
          //     ),
          //     Container(
          //       margin: EdgeInsets.only(top: 10, left: 10),
          //       height: 180,
          //       child: ListView.builder(
          //         physics: ScrollPhysics(),
          //         scrollDirection: Axis.horizontal,
          //         shrinkWrap: true,
          //         itemCount: CardNews.getCardNews.length,
          //         itemBuilder: (context, index) {
          //           return Card(
          //             color: Colors.blue[50],
          //             elevation: 0,
          //             shape: RoundedRectangleBorder(
          //                 borderRadius: BorderRadius.circular(15)),
          //             margin: EdgeInsets.only(right: 10),
          //             child: Column(
          //               crossAxisAlignment: CrossAxisAlignment.start,
          //               children: [
          //                 Container(
          //                     height: 130,
          //                     width: 220,
          //                     child: ClipRRect(
          //                       borderRadius: BorderRadius.only(
          //                           topLeft: Radius.circular(15),
          //                           topRight: Radius.circular(15)),
          //                       child: Image(
          //                         width: 200,
          //                         fit: BoxFit.cover,
          //                         repeat: ImageRepeat.noRepeat,
          //                         image: NetworkImage(
          //                             CardNews.getCardNews[index].urlImageNews),
          //                       ),
          //                     )),
          //                 Container(
          //                   padding: EdgeInsets.only(left: 10, top: 2),
          //                   // margin: EdgeInsets.only(left: 10, top: 5),
          //                   width: 220,
          //                   child: Text(
          //                     CardNews.getCardNews[index].caption,
          //                     maxLines: 2,
          //                     overflow: TextOverflow.ellipsis,
          //                     softWrap: true,
          //                     style: TextStyle(
          //                         fontFamily: 'poppins', fontSize: 12),
          //                   ),
          //                 )
          //               ],
          //             ),
          //           );
          //         },
          //       ),
          //     ),
          //   ],
          // ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15, top: 10),
                child: Text(
                  "Today's Status",
                  style: TextStyle(fontFamily: 'poppins', fontSize: 15),
                ),
              ),
              ListView.builder(
                physics: ScrollPhysics(),
                shrinkWrap: true,
                itemCount: StatusUserModel.getAllStatus.length,
                itemBuilder: (context, index) {
                  return StatusWarga(
                    namaUser: StatusUserModel.getAllStatus[index].userName,
                    fotoProfile: StatusUserModel.getAllStatus[index].urlProfile,
                    urlFotoStatus:
                        StatusUserModel.getAllStatus[index].urlFotoStatus,
                    caption: StatusUserModel.getAllStatus[index].caption,
                    lamaUpload: StatusUserModel.getAllStatus[index].lamaUpload,
                    jumlahKomen:
                        StatusUserModel.getAllStatus[index].jumlahKomen,
                    jumlahLike: StatusUserModel.getAllStatus[index].jumlahLike,
                  );
                },
              ),
            ],
          )

          // status dari warga
          // Column(children: listStatus),
        ],
      ),
    );
  }

  Container headerBackground(double mediaSizeWidth) {
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
              child: ListView(children: [
                Column(
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

                            showModalBottomStatus(context, _imageFile, false);
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
                                  fontSize: MediaQuery.of(context).size.width *
                                      0.035),
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
                              onPressed: () {
                                getImage(ImageSource.camera).then((value) {
                                  if (statusPicker)
                                    showModalBottomStatus(
                                        context, imageFile, isVisible);
                                });
                              },
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
                              onPressed: () {
                                getImage(ImageSource.gallery).then((value) {
                                  if (statusPicker)
                                    showModalBottomStatus(
                                        context, imageFile, isVisible);
                                });
                              },
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
                  ],
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }

  Future showModalBottomStatus(
      BuildContext context, PickedFile imageFile, bool isVisible) {
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (builder) => TempatTulisStatus(
              fotoProfile: fotoProfile,
              nama: userName,
              rt: rt,
              rw: rw,
              mediaSizeHeightParent: mediaSizeHeight,
              imageFile: _imageFile,
              isVisible: isVisible,
            ));
  }

  Future getImage(ImageSource source) async {
    final pickedFile = await _picker.getImage(source: source);
    setState(() {
      if (pickedFile != null) {
        _imageFile = pickedFile;
        isVisible = true;
        statusPicker = true;
      }
    });
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

}
