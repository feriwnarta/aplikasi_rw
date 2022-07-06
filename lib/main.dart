import 'package:aplikasi_rw/bloc/bills_reguler_screen_bloc.dart';
import 'package:aplikasi_rw/bloc/bills_tab_bloc.dart';
import 'package:aplikasi_rw/bloc/carousel_bloc.dart';
import 'package:aplikasi_rw/bloc/comment_bloc.dart';
import 'package:aplikasi_rw/bloc/google_map_bloc.dart';
import 'package:aplikasi_rw/bloc/like_status_bloc.dart';
import 'package:aplikasi_rw/bloc/payment_bloc.dart';
import 'package:aplikasi_rw/bloc/report_bloc.dart';
import 'package:aplikasi_rw/bloc/report_cordinator_bloc.dart';
import 'package:aplikasi_rw/bloc/shimmer_loading_bloc.dart';
import 'package:aplikasi_rw/bloc/tempat_tulis_status_bloc.dart';
import 'package:aplikasi_rw/bloc/user_loading_bloc.dart';
import 'package:aplikasi_rw/model/bills_history_model.dart';
import 'package:aplikasi_rw/screen/bills_screen/bills_screen.dart';
import 'package:aplikasi_rw/screen/cordinator/screen/home_screen_cordinator.dart';
import 'package:aplikasi_rw/screen/home_screen/home_screen.dart';
import 'package:aplikasi_rw/screen/login_screen/onboarding/onboarding_screen.dart';
import 'package:aplikasi_rw/screen/report_screen2/report_screen_2.dart';
import 'package:aplikasi_rw/screen/user_screen/change_data_user.dart';
import 'package:aplikasi_rw/server-app.dart';
import 'package:aplikasi_rw/services/check_session.dart';
import 'package:aplikasi_rw/utils/UserSecureStorage.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';
import 'bloc/count_comment_bloc.dart';
import 'bloc/status_user_bloc.dart';

void main() {
  // runApp(DevicePreview(enabled: !kReleaseMode, builder: (context) => MyApp()));
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyApp();
}

class _MyApp extends State<MyApp> {
  final CheckSession checkSession = CheckSession();
  String initalState = '/';

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CarouselBloc>(
          create: (context) => CarouselBloc(0),
        ),
        BlocProvider<TempatTulisStatusBloc>(
          create: (context) => TempatTulisStatusBloc(
              TempatTulisStatusState(imageFile: null, isVisible: false)),
        ),
        BlocProvider<StatusUserBloc>(
          create: (context) =>
              StatusUserBloc(StatusUserUnitialized())..add(StatusUserEvent()),
        ), // fungsi ..add akan langusung menjalankan blocnya
        BlocProvider<ReportBloc>(
          create: (context) =>
              ReportBloc(ReportUnitialized())..add(ReportEvent2()),
        ),
        BlocProvider<BillTabColorBloc>(
          create: (context) => BillTabColorBloc(TabState()),
        ),
        BlocProvider<BillRegulerBloc>(
          create: (context) =>
              BillRegulerBloc(BillsHistoryModel.getBillsHistory()),
        ),
        BlocProvider<PaymentBloc>(
          create: (context) => PaymentBloc(true),
        ),
        BlocProvider<ShimmerLoadingBloc>(
          create: (context) => ShimmerLoadingBloc(true),
        ),
        BlocProvider<CommentBloc>(
          create: (context) =>
              CommentBloc(CommentBlocUnitialized())..add(CommentBlocEvent()),
        ),
        BlocProvider<CommentCountBloc>(
          create: (context) =>
              CommentCountBloc(CommentCountBlocState(countComment: '0')),
        ),
        BlocProvider<LikeStatusBloc>(
          create: (context) => LikeStatusBloc(LikeStatusState(
              colorButton: Colors.black, isLike: false, numberLike: '0')),
        ),
        BlocProvider<UserLoadingBloc>(
            create: (context) => UserLoadingBloc(UserLoadingUnitialized())
              ..add(UserLoadingEvent())),
        BlocProvider<GoogleMapBloc>(
          create: (context) => GoogleMapBloc(GoogleMapState()),
        ),
        BlocProvider<ReportCordinatorBloc>(
          create: (context) =>
              ReportCordinatorBloc(ReportCordinatorUnitialized())
                ..add(ReportCordinatorEvent()),
        ),
      ],
      child: LayoutBuilder(builder: (context, constraints) {
        return OrientationBuilder(builder: (context, orientation) {
          SizerUtil().init(constraints, orientation);
          return ScreenUtilInit(
            designSize: Size(360, 800),
            allowFontScaling: false,
            builder: () => MaterialApp(
              debugShowCheckedModeBanner: false,
              initialRoute: '/',
              routes: routes,
              // home: MapSample(),
              theme: ThemeData(
                  fontFamily: 'open sans',
                  scaffoldBackgroundColor:
                      Colors.white), // set background color theme
            ),
          );
        });
      }),
    );
  }

  final routes = {
    '/': (BuildContext context) =>
        BlocBuilder<UserLoadingBloc, UserLoadingState>(
          builder: (context, state) {
            if (state is UserNotLogin) {
              return OnboardingScreen();
            } else if (state is UserLoadingUnitialized) {
              return Container(color: Colors.white);
            } else if (state is CordinatorInitialized) {
              CordinatorInitialized cordinator = state as CordinatorInitialized;
              return HomeScreenCordinator(
                name: cordinator.nameCordinator,
              );
            } else {
              UserLoadingInitialized userLogin =
                  state as UserLoadingInitialized;
              return MainApp(
                idUser: userLogin.idUser,
                urlProfile: userLogin.urlProfile,
                username: userLogin.username,
              );
            }
          },
        ),
  };
}

//ignore: must_be_immutable
class MainApp extends StatefulWidget {
  String idUser, username, urlProfile;
  MainApp({this.idUser, this.username, this.urlProfile});
  @override
  State<MainApp> createState() =>
      _MainAppState(idUser: idUser, urlProfile: urlProfile, username: username);
}

class _MainAppState extends State<MainApp> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  int _index = 0;
  var colorTabBar = Color(0xff2196F3);
  ReportBloc _reportBloc;
  // list screen untuk menu
  List<Widget> screens;
  String idUser, username, urlProfile;

  _MainAppState({this.idUser, this.username, this.urlProfile});

  @override
  void initState() {
    super.initState();
  }

  UserLoadingBloc bloc;

  @override
  Widget build(BuildContext context) {
    _reportBloc = BlocProvider.of<ReportBloc>(context);
    bloc = BlocProvider.of<UserLoadingBloc>(context);
    screens = [
      HomeScreen(
        scaffoldKey: scaffoldKey,
        idUser: idUser,
        urlProfile: urlProfile,
        userName: username,
      ),
      ReportScreen2(),
      BillScreen(),
      // PaymentScreen()
    ];

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));

    return Scaffold(
      key: scaffoldKey,
      // membuat sidebar dan drawer
      drawer: drawerSideBar(),
      body: IndexedStack(
        children: screens,
        index: _index,
      ),

      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 5)]),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          iconSize: 6.0.w,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.black54,
          currentIndex: _index,
          onTap: (index) {
            setState(() {
              _index = index;
              if (index == 1) {
                print('ini ke2');
                _reportBloc.add(ReportEventRefresh());
              }
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.clipboardList), label: 'Report'),
            BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.solidCalendarCheck),
                label: 'Event'),
            // BottomNavigationBarItem(
            //     icon: Icon(FontAwesomeIcons.wallet), label: 'Payment'),
            BottomNavigationBarItem(
                icon: Icon(Icons.thumb_up), label: 'Recomen'),
          ],
        ),
      ),
    );
  }

  Drawer drawerSideBar() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Align(
              alignment: Alignment.topLeft,
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage:
                        NetworkImage('${ServerApp.url}$urlProfile'),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    child: Text(
                      username,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  Text(
                    'Alamat user',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.person,
              color: Colors.blue,
            ),
            title: Text('Ganti Data'),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(
                builder: (context) => ChangeDataUser(
                  urlProfile: urlProfile,
                  idUser: idUser,
                ),
              ))
                  .then((value) {
                if (value == 'refresh') {
                  bloc.add(UserLoadingRefresh());
                }
              });
            },
          ),
          // ListTile(
          //   title: Text('item 2'),
          //   onTap: () {},
          // ),
          ListTile(
            leading: Icon(Icons.logout, color: Colors.blue),
            title: Text('Log Out'),
            onTap: () async {
              await UserSecureStorage.deleteIdUser();
              await UserSecureStorage.deleteStatus();
              Navigator.of(context)
                  .pushReplacement(MaterialPageRoute(
                    builder: (context) => OnboardingScreen(),
                  ))
                  .then((value) => setState(() {}));
            },
          ),
        ],
      ),
    );
  }

  Future checkIsLogin() async {
    String idUser = await UserSecureStorage.getIdUser();
    if (idUser == null && idUser.isEmpty) {
      Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
    }
  }
}
