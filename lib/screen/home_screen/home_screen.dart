import 'package:aplikasi_rw/bloc/carousel_bloc.dart';
import 'package:aplikasi_rw/bloc/status_user_bloc.dart';
import 'package:aplikasi_rw/bloc/tempat_tulis_status_bloc.dart';
import 'package:aplikasi_rw/model/card_news.dart';
import 'package:aplikasi_rw/screen/home_screen/status_warga.dart';
import 'package:aplikasi_rw/screen/home_screen/tempat_tulis_status.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

//ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  HomeScreen(this.scaffoldKey);

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
  final _picker = ImagePicker();
  String imagePath = '';
  PickedFile imageFile;

  // bloc
  CarouselBloc blocColor;
  TempatTulisStatusBloc blocTulisStatus;
  StatusUserBloc blocStatusUser;

  // scroll controller
  ScrollController controller = ScrollController();

  void onScroll() {
    if (controller.position.maxScrollExtent == controller.position.pixels) {
      blocStatusUser.add(StatusUserEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    blocColor = BlocProvider.of<CarouselBloc>(context);
    blocTulisStatus = BlocProvider.of<TempatTulisStatusBloc>(context);
    blocStatusUser = BlocProvider.of<StatusUserBloc>(context);

    controller.addListener(onScroll);

    mediaSizeHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    final mediaSizeWidth = MediaQuery.of(context).size.width;

    // ukuran media query dikurangin dengan tinggi status
    heightBackgroundRounded = mediaSizeHeight * 0.25;
    positionedCardStatus = mediaSizeHeight * 0.1;
    heightCardStatus = mediaSizeHeight * 0.24;

    return Scaffold(
      // resizeToAvoidBottomInset: false,

      // container yang membukus list view
      body: ListView(
        controller: controller,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Stack(children: [
                // header app
                headerBackground(mediaSizeWidth, context),
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
              buildCarouselSliderNews(mediaSizeWidth),
              SizedBox(
                height: 17,
              ),
              Center(
                child: BlocBuilder<CarouselBloc, int>(
                  builder: (context, index) => AnimatedSmoothIndicator(
                    activeIndex: index,
                    count: CardNews.getCardNews.length,
                    effect: ExpandingDotsEffect(
                        dotWidth: 10,
                        dotHeight: 10,
                        activeDotColor: Colors.lightBlue,
                        dotColor: Colors.grey[350]),
                  ),
                ),
              )
            ],
          ),

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
              BlocBuilder<StatusUserBloc, StatusUserState>(
                builder: (context, state) {
                  if (state is StatusUserUnitialized) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: SizedBox(
                          width: 30,
                          height: 30,
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    );
                  } else {
                    StatusUserLoaded statusLoaded = state as StatusUserLoaded;
                    return ListView.builder(
                      physics: ScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: (statusLoaded.isMaxReached)
                          ? statusLoaded.listStatusUser.length
                          : statusLoaded.listStatusUser.length + 1,
                      itemBuilder: (context, index) => (index <
                              statusLoaded.listStatusUser.length)
                          ? StatusWarga(
                              namaUser:
                                  statusLoaded.listStatusUser[index].userName,
                              caption:
                                  statusLoaded.listStatusUser[index].caption,
                              fotoProfile:
                                  'https://akcdn.detik.net.id/visual/2022/02/04/ainun-najib-1_169.jpeg?w=650',
                              urlFotoStatus:
                                  'https://asset-a.grid.id/crop/0x0:0x0/780x800/photo/bobofoto/original/17852_bagaimana-air-hujan-bisa-merusak-jalanan-aspal.jpg',
                              jumlahKomen: '12',
                              lamaUpload: '12 menit',
                              jumlahLike: '10',
                            )
                          : Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              child: Center(
                                child: SizedBox(
                                  width: 30,
                                  height: 30,
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                            ),
                    );
                  }
                },
              )
            ],
          )

          // status dari warga
          // Column(children: listStatus),
        ],
      ),
    );
  }

  CarouselSlider buildCarouselSliderNews(double mediaSizeWidth) {
    return CarouselSlider.builder(
      options: CarouselOptions(
          // height: 180,
          height: mediaSizeHeight * 0.24,
          enlargeCenterPage: true,
          // disableCenter: true,
          viewportFraction: 0.6,
          onPageChanged: (index, _) => blocColor.add(index)),
      itemCount: CardNews.getCardNews.length,
      itemBuilder: (context, index, realIndex) {
        return SingleChildScrollView(
          child: Card(
            color: Colors.blue[50],
            elevation: 1.5,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
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
                        child: CachedNetworkImage(
                          imageUrl: CardNews.getCardNews[index].urlImageNews,
                          fit: BoxFit.cover,
                          placeholder: (context, _) => Container(
                            color: Colors.grey,
                          ),
                          errorWidget: (context, url, _) => Container(
                            color: Colors.grey,
                            child: Icon(
                              Icons.error,
                              color: Colors.red,
                            ),
                          ),
                        ))),
                Container(
                  padding: EdgeInsets.only(left: 10, top: 5, bottom: 10),
                  // margin: EdgeInsets.only(left: 10, top: 5),
                  width: 220,
                  child: Text(
                    CardNews.getCardNews[index].caption,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                    style: TextStyle(fontFamily: 'poppins', fontSize: 12),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Container headerBackground(double mediaSizeWidth, BuildContext context) {
    return Container(
        width: mediaSizeWidth,
        // height: heightBackgroundRounded,
        color: Colors.white,
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
              child: SingleChildScrollView(
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
                            backgroundImage: CachedNetworkImageProvider(fotoProfile),
                          ),
                        ),

                        // container ini berisi tempat menulis status
                        // gesture detector jika tulis status diklik
                        GestureDetector(
                          onTap: () {
                            showModalBottomStatus(context);
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
                                    showModalBottomStatus(context);
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
                                    showModalBottomStatus(context);
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
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future showModalBottomStatus(BuildContext context) {
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (builder) => TempatTulisStatus(
              fotoProfile: fotoProfile,
              nama: userName,
              rt: rt,
              rw: rw,
              mediaSizeHeightParent: mediaSizeHeight,
            ));
  }

  Future getImage(ImageSource source) async {
    final pickedFile = await _picker.getImage(source: source);
    if (pickedFile != null) {
      blocTulisStatus
          .add(TulisStatusEvent(imageFile: pickedFile, isVisibility: true));
      statusPicker = true;
    }
  }
}
