import 'package:aplikasi_rw/bloc/bills_reguler_screen_bloc.dart';
import 'package:aplikasi_rw/bloc/bills_tab_bloc.dart';
import 'package:aplikasi_rw/bloc/carousel_bloc.dart';
import 'package:aplikasi_rw/bloc/comment_bloc.dart';
import 'package:aplikasi_rw/bloc/login_bloc.dart';
import 'package:aplikasi_rw/bloc/payment_bloc.dart';
import 'package:aplikasi_rw/bloc/report_bloc.dart';
import 'package:aplikasi_rw/bloc/report_screen_bloc.dart';
import 'package:aplikasi_rw/bloc/tempat_tulis_status_bloc.dart';
import 'package:aplikasi_rw/model/bills_history_model.dart';
import 'package:aplikasi_rw/screen/bills_screen/bills_screen.dart';
import 'package:aplikasi_rw/screen/home_screen/home_screen.dart';
import 'package:aplikasi_rw/screen/login_screen/login_screen.dart';
import 'package:aplikasi_rw/screen/login_screen/onboarding/onboarding_screen.dart';
import 'package:aplikasi_rw/screen/login_screen/register_screen.dart';
import 'package:aplikasi_rw/screen/payment_screen/payment_screen.dart';
import 'package:aplikasi_rw/screen/report_screen2/card_laporan_view.dart';
import 'package:aplikasi_rw/screen/report_screen/report_screen.dart';
import 'package:aplikasi_rw/screen/report_screen2/ReportScreen2.dart';
import 'package:aplikasi_rw/services/check_session.dart';
import 'package:aplikasi_rw/utils/UserSecureStorage.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';
import 'bloc/status_user_bloc.dart';

void main() async {
  // runApp(DevicePreview(enabled: !kReleaseMode, builder: (context) => MyApp()));
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyApp();
}

class _MyApp extends State<MyApp> {
  final CheckSession checkSession = CheckSession();

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
        // BlocProvider<ReportScreenBloc>(
        //   create: (context) => ReportScreenBloc(ReportState()),
        // ),
        BlocProvider<ReportBloc>(
          create: (context) =>
              ReportBloc(ReportUnitialized())..add(ReportEvent2()),
        ),
        BlocProvider<BillTabColorBloc>(
          create: (context) => BillTabColorBloc(TabState())..add(0),
        ),
        BlocProvider<BillRegulerBloc>(
          create: (context) =>
              BillRegulerBloc(BillsHistoryModel.getBillsHistory()),
        ),
        BlocProvider<PaymentBloc>(
          create: (context) => PaymentBloc(true),
        ),
        BlocProvider<CommentBloc>(
          create: (context) =>
              CommentBloc(CommentBlocUnitialized())..add(CommentBlocEvent()),
        ),
        BlocProvider<LoginBloc>(
          create: (context) =>
              LoginBloc(LoginState(idUser: '0', isLogin: false)),
        ),
      ],
      child: LayoutBuilder(builder: (context, constraints) {
        return OrientationBuilder(builder: (context, orientation) {
          SizerUtil().init(constraints, orientation);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            initialRoute: '/',
            routes: routes,
            // home: ReportScreen2(),
            theme: ThemeData(
                fontFamily: 'open sans',
                scaffoldBackgroundColor:
                    Colors.white), // set background color theme
            // ),
          );
        });
      }),
    );
  } 

  final routes = {
    '/': (BuildContext context) => FutureBuilder<String>(
          future: UserSecureStorage.getIdUser(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                return (snapshot.data != null && snapshot.data.isNotEmpty)
                    ? MainApp()
                    : OnboardingScreen();
              default:
                return Container(
                  color: Colors.white,
                );
            }
          },
        ),
  };
}

class MainApp extends StatefulWidget {
  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  int _index = 0;
  var colorTabBar = Color(0xff2196F3);
  ReportBloc bloc;

  // list screen untuk menu
  List<Widget> screens;

  // @override
  // void initState() {
  //   super.initState();
  //   // checkIsLogin();
  // }

  @override
  Widget build(BuildContext context) {
    bloc = BlocProvider.of<ReportBloc>(context);

    screens = [
      HomeScreen(scaffoldKey),
      ReportScreen2(),
      BillScreen(),
      PaymentScreen()
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
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.black54,
          currentIndex: _index,
          onTap: (index) {
            setState(() {
              _index = index;
              if(index == 1) {
                bloc.add(ReportEventRefresh());
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
                icon: Icon(FontAwesomeIcons.fileInvoiceDollar), label: 'Bills'),
            BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.wallet), label: 'Payment'),
            BottomNavigationBarItem(
                icon: Icon(Icons.thumb_up), label: 'Recomendation'),
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
                    backgroundImage: NetworkImage(
                        'http://rawakalong.desa.id/wp-content/uploads/2019/02/person2.jpg'),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    child: Text(
                      'Nama user',
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
            title: Text('Ganti Data'),
            onTap: () {},
          ),
          ListTile(
            title: Text('item 2'),
            onTap: () {},
          ),
          ListTile(
            title: Text('item 3'),
            onTap: () {},
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
