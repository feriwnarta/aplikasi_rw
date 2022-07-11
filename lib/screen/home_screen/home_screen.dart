import 'dart:async';

import 'package:aplikasi_rw/bloc/carousel_bloc.dart';
import 'package:aplikasi_rw/bloc/status_user_bloc.dart';
import 'package:aplikasi_rw/bloc/tempat_tulis_status_bloc.dart';
import 'package:aplikasi_rw/controller/status_user_controller.dart';
import 'package:aplikasi_rw/model/card_news.dart';
import 'package:aplikasi_rw/screen/home_screen/news_screen/news_screen.dart';
import 'package:aplikasi_rw/screen/home_screen/status_warga.dart';
import 'package:aplikasi_rw/screen/home_screen/tempat_tulis_status_screen.dart';
import 'package:aplikasi_rw/server-app.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:sizer/sizer.dart';

//ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  String userName, urlProfile;
  HomeScreen({
    Key key,
    this.scaffoldKey,
    this.idUser,
    this.userName,
    this.urlProfile,
  }) : super(key: key);
  // HomeScreen(
  //     {this.scaffoldKey, this.idUser, this.userName, this.urlProfile, Key key});
  String idUser;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  String rt, rw, fotoProfile;
  double mediaSizeHeight;
  bool statusPicker = false;
  final _picker = ImagePicker();
  String imagePath = '';
  PickedFile imageFile;
  CarouselBloc blocColor;
  TempatTulisStatusBloc blocTulisStatus;
  final controllerStatus = Get.put(StatusUserController());
  ScrollController controller = ScrollController(keepScrollOffset: true);

  Timer _timer;

  void onScroll() {
    if (controller.position.haveDimensions) {
      if (controller.position.maxScrollExtent == controller.position.pixels) {
        controllerStatus.getDataFromDb();
      }
    }
  }

  final key = GlobalKey();

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    blocColor = BlocProvider.of<CarouselBloc>(context);
    blocTulisStatus = BlocProvider.of<TempatTulisStatusBloc>(context);
    // blocStatusUser = BlocProvider.of<StatusUserBloc>(context);
    controller.addListener(onScroll);

    _timer = Timer.periodic(Duration(seconds: 5), (duration) async {
      print(duration);
      controllerStatus.realtimeData();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    controller.dispose();
    blocColor.close();
    controllerStatus.dispose();
    blocTulisStatus.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    // blocColor = BlocProvider.of<CarouselBloc>(context);
    // blocTulisStatus = BlocProvider.of<TempatTulisStatusBloc>(context);
    // blocStatusUser = BlocProvider.of<StatusUserBloc>(context);
    // controller.addListener(onScroll);
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async => loadStatus(),
          child: SingleChildScrollView(
              key: key,
              physics: ClampingScrollPhysics(),
              controller: controller,
              child: Column(
                children: <Widget>[
                  Stack(children: [
                    headerBackground(
                        context, widget.urlProfile, widget.userName)
                  ]),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15, top: 10, bottom: 10),
                        child: Text(
                          'News',
                          style: TextStyle(
                              fontFamily: 'poppins', fontSize: 11.0.sp),
                        ),
                      ),
                      buildCarouselSliderNews(),
                      SizedBox(
                        height: 17,
                      ),
                      StreamBuilder<List<CardNews>>(
                          stream: NewsServices.getNews(widget.idUser),
                          builder: (context, snapshot) => (snapshot.hasData)
                              ? (snapshot.data.length > 0)
                                  ? Center(
                                      child: BlocBuilder<CarouselBloc, int>(
                                        builder: (context, index) =>
                                            AnimatedSmoothIndicator(
                                          activeIndex: index,
                                          count: snapshot.data.length,
                                          effect: ExpandingDotsEffect(
                                              dotWidth: 10,
                                              dotHeight: 10,
                                              activeDotColor: Colors.lightBlue,
                                              dotColor: Colors.grey[350]),
                                        ),
                                      ),
                                    )
                                  : Container()
                              : Container())
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15, top: 10),
                        child: Text(
                          "Today's Status",
                          style: TextStyle(
                            fontFamily: 'poppins',
                            fontSize: 11.0.sp,
                          ),
                        ),
                      ),
                      ListViewStatusWarga(widget: widget)
                    ],
                  )
                  // status dari warga
                  // Column(children: listStatus),
                ],
              )),
        ),
      ),
    );
  }

  StreamBuilder buildCarouselSliderNews() {
    return StreamBuilder<List<CardNews>>(
      stream: NewsServices.getNews(widget.idUser),
      builder: (context, snapshot) => (snapshot.hasData)
          ? (snapshot.data.length > 0)
              ? CarouselSlider.builder(
                  options: CarouselOptions(
                      // height: 180,
                      height: 25.0.h,
                      enlargeCenterPage: kDebugMode ? false : true,
                      disableCenter: true,
                      viewportFraction: 0.6,
                      autoPlay: true,
                      autoPlayInterval: Duration(seconds: 2),
                      onPageChanged: (index, _) => blocColor.add(index)),
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index, realIndex) {
                    return SingleChildScrollView(
                      child: GestureDetector(
                        child: Card(
                          color: Colors.blue[50],
                          elevation: 1.5,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          margin: EdgeInsets.only(right: 1.0.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  height: 17.0.h,
                                  width: 60.0.w,
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(15),
                                          topRight: Radius.circular(15)),
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            '${ServerApp.url}${snapshot.data[index].urlImageNews}',
                                        fit: BoxFit.cover,
                                        placeholder: (context, _) => Container(
                                          color: Colors.grey,
                                        ),
                                        errorWidget: (context, url, _) =>
                                            Container(
                                          color: Colors.grey,
                                          child: Icon(
                                            Icons.error,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ))),
                              Container(
                                padding: EdgeInsets.only(
                                    left: 1.0.w, top: 0.5.h, bottom: 1.0.h),
                                // margin: EdgeInsets.only(left: 10, top: 5),
                                width: 90.0.w,
                                child: Text(
                                  snapshot.data[index].caption,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: true,
                                  style: TextStyle(
                                      fontFamily: 'poppins', fontSize: 9.5.sp),
                                ),
                              )
                            ],
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => NewsScreen(
                                    urlImage:
                                        '${ServerApp.url}${snapshot.data[index].urlImageNews}',
                                    caption: snapshot.data[index].caption,
                                    content: snapshot.data[index].content,
                                    writerAndTime:
                                        snapshot.data[index].writerAndTime,
                                  )));
                        },
                      ),
                    );
                  },
                )
              : Center(
                  child: Text(
                    'No News',
                    style: TextStyle(fontSize: 11.0.sp),
                  ),
                )
          : SizedBox(
              height: 20.0.h,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: 5,
                scrollDirection: Axis.horizontal,
                // padding: EdgeInsets.only(right: 2.0.w),
                physics: ScrollPhysics(),
                itemBuilder: (context, index) => Container(
                  width: 60.0.w,
                  height: 17.0.h,
                  margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  child: Shimmer.fromColors(
                      baseColor: Colors.grey[300],
                      highlightColor: Colors.grey[200],
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(10)),
                        width: double.infinity,
                        height: 50,
                      )),
                ),
              ),
            ),
    );
  }

  Container headerBackground(
      BuildContext context, String fotoProfile, String username) {
    return Container(
        child: Column(
      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 1.0.h,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 1.0.w, top: 0.5.h),
              child: RotatedBox(
                quarterTurns: 1,
                child: IconButton(
                    icon: Icon(
                      Icons.bar_chart_sharp,
                      color: Colors.black,
                      size: 8.0.w,
                    ),
                    onPressed: () =>
                        widget.scaffoldKey.currentState.openDrawer()),
              ),
            ),
            Padding(
                padding: EdgeInsets.only(right: 4.0.w, top: 1.5.h),
                child: Image(
                  width: 20.0.w,
                  image: AssetImage('assets/img/logo.png'),
                  fit: BoxFit.cover,
                  repeat: ImageRepeat.noRepeat,
                ))
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 4.0.w, top: 1.0.h),
              child: Text(
                '$username, BLOK XY 9 NO 21',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14.0.sp,
                  fontFamily: 'poppins',
                ),
              ),
            )
          ],
        ),
        cardStatus(context, fotoProfile, username),
      ],
    ));
  }

  Padding cardStatus(
      BuildContext context, String fotoProfile, String username) {
    return Padding(
      padding: EdgeInsets.only(top: 1.0.h),
      // padding: EdgeInsets.only(top: 10),
      child: Align(
        alignment: Alignment.center,
        child: SizedBox(
          // height: 23.7.h,
          width: 95.0.w,
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
                          padding: EdgeInsets.only(left: 5.5.w, top: 3.0.h),
                          child: CircleAvatar(
                              radius: 4.0.h,
                              backgroundImage: CachedNetworkImageProvider(
                                  '${ServerApp.url}${fotoProfile}')),
                        ),

                        // container ini berisi tempat menulis status
                        // gesture detector jika tulis status diklik
                        GestureDetector(
                          onTap: () {
                            // showModalBottomStatus(
                            //     context, fotoProfile, username);
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => TempatTulisStatus(
                                fotoProfile: fotoProfile,
                                username: username,
                                rt: rt,
                                rw: rw,
                              ),
                            ));
                          },
                          child: Container(
                            margin: EdgeInsets.only(top: 2.3.h, left: 5.0.w),
                            height: 6.0.h,
                            width: 58.0.w,
                            child: Center(
                              child: Text(
                                'Apa yang anda sedang pikirkan ?',
                                style: TextStyle(
                                    color: Colors.grey,
                                    // fontSize: MediaQuery.of(context).size.width *
                                    //     0.035
                                    fontSize: 10.0.sp),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(40)),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 1.0.h),
                    Divider(
                      color: Colors.white,
                      thickness: 1,
                      indent: 20,
                      endIndent: 20,
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
                                        context, fotoProfile, username);
                                });
                              },
                              icon: Icon(
                                FontAwesomeIcons.camera,
                                color: Colors.white,
                                size: 4.0.h,
                              ),
                              label: Text(
                                'Camera',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 11.0.sp),
                              )),
                          VerticalDivider(
                            color: Colors.white,
                            width: 10.0.w,
                            thickness: 1,
                            indent: 15,
                            endIndent: 10,
                          ),
                          FlatButton.icon(
                              onPressed: () {
                                getImage(ImageSource.gallery).then((value) {
                                  if (statusPicker)
                                    showModalBottomStatus(
                                        context, fotoProfile, username);
                                });
                              },
                              icon: Icon(
                                FontAwesomeIcons.solidImage,
                                color: Colors.white,
                                size: 4.0.h,
                              ),
                              label: Text(
                                'Gallery',
                                style: TextStyle(color: Colors.white),
                              )),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 1.0.h,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future showModalBottomStatus(
      BuildContext context, String fotoProfile, String username) {
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (builder) => TempatTulisStatus(
              fotoProfile: fotoProfile,
              username: username,
              rt: rt,
              rw: rw,
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

  Future loadStatus() async {
    await Future.delayed(Duration(seconds: 2));
    // blocStatusUser.add(StatusUserEventRefresh());
  }

  @override
  bool get wantKeepAlive => true;
}

class ListViewStatusWarga extends StatelessWidget {
  ListViewStatusWarga({
    Key key,
    @required this.widget,
  }) : super(key: key);

  final HomeScreen widget;
  final contol = Get.put(StatusUserController());

  @override
  Widget build(BuildContext context) {
    return GetX<StatusUserController>(
        init: StatusUserController(),
        initState: (state) => contol.getDataFromDb(),
        dispose: (state) => contol.dispose(),
        builder: (controller) {
          if (controller.isLoading.value) {
            // _refreshIndicatorKey.currentState.show();
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
            // return Container();
          } else {
            return ListView.builder(
              physics: ClampingScrollPhysics(),
              addAutomaticKeepAlives: true,
              shrinkWrap: true,
              itemCount: (controller.isMaxReached.value)
                  ? controller.listStatus.length
                  : controller.listStatus.length + 1,
              itemBuilder: (context, index) => (index <
                      controller.listStatus.length)
                  ? StatusWarga(
                      userName: controller.listStatus[index].userName,
                      caption: controller.listStatus[index].caption,
                      fotoProfile: controller.listStatus[index].urlProfile,
                      urlStatusImage:
                          controller.listStatus[index].urlStatusImage,
                      numberOfComments:
                          controller.listStatus[index].numberOfComments,
                      uploadTime: controller.listStatus[index].uploadTime,
                      numberOfLikes: controller.listStatus[index].numberOfLikes,
                      idStatus: controller.listStatus[index].idStatus,
                      idUser: widget.idUser,
                    )
                  : (controller.listStatus.length == index)
                      ? Center(
                          child: Padding(
                          padding: EdgeInsets.only(top: 3.0.h),
                          child: Text('No Status'),
                        ))
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
        });
  }
}
