import 'package:aplikasi_rw/bloc/bills_reguler_screen_bloc.dart';
import 'package:aplikasi_rw/bloc/bills_tab_bloc.dart';
import 'package:aplikasi_rw/bloc/carousel_bloc.dart';
import 'package:aplikasi_rw/bloc/payment_bloc.dart';
import 'package:aplikasi_rw/bloc/report_screen_bloc.dart';
import 'package:aplikasi_rw/bloc/tempat_tulis_status_bloc.dart';
import 'package:aplikasi_rw/model/bills_history_model.dart';
import 'package:aplikasi_rw/screen/bills_screen/bills_screen.dart';
import 'package:aplikasi_rw/screen/home_screen/home_screen.dart';
import 'package:aplikasi_rw/screen/payment_screen/payment_screen.dart';
import 'package:aplikasi_rw/screen/report_screen/report_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'bloc/status_user_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
        BlocProvider<ReportScreenBloc>(
          create: (context) => ReportScreenBloc(ReportState()),
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
      ],
      child: MaterialApp(
        // debug banner
        debugShowCheckedModeBanner: false,
        home: TemplateScreen(),
        theme: ThemeData(
            fontFamily: 'open sans',
            scaffoldBackgroundColor:
                Colors.white), // set background color theme
      ),
    );
  }
}

class TemplateScreen extends StatefulWidget {
  @override
  State<TemplateScreen> createState() => _TemplateScreenState();
}

class _TemplateScreenState extends State<TemplateScreen> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  int _index = 0;
  // tinggi bottom tab bar
  double heightTabBar;
  // tinggi app bar
  double heightAppBar;
  // warna tab bar
  var colorTabBar = Color(0xff2196F3);
  // padding tinggi dan lebar bottom menu Gnav
  double heightPaddingGnav, widthPaddingGnav;

  // list screen untuk menu

  List<Widget> screens;

  @override
  Widget build(BuildContext context) {
    screens = [
      HomeScreen(scaffoldKey),
      ReportScreen(scaffoldKey),
      BillScreen(),
      PaymentScreen()
    ];

    heightPaddingGnav =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    widthPaddingGnav = MediaQuery.of(context).size.width;

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));

    return Scaffold(
      // resizeToAvoidBottomInset: false,
      key: scaffoldKey,
      // membuat bottomNavigationBar transparent
      // extendBody: true,

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
          iconSize: 25,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.black54,
          currentIndex: _index,
          onTap: (index) {
            setState(() {
              _index = index;
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

      // bottom navigation bar
      // bottomNavigationBar: Container(
      //   padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      //   margin: EdgeInsets.symmetric(vertical: 2),
      //   decoration: BoxDecoration(
      //       color: Colors.white,
      //       borderRadius: BorderRadius.only(
      //           topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      //       boxShadow: [
      //         BoxShadow(
      //           color: Colors.grey,
      //           blurRadius: 5,
      //         )
      //       ]),
      //   child: GNav(
      //     curve: Curves.easeIn,
      //     duration: Duration(microseconds: 50),
      //     iconSize: 24,
      //     gap: 8,
      //     color: Colors.blueGrey
      //         .withOpacity(0.6), // warna icon dan text yang tidak aktif
      //     activeColor: Colors.white, // warna icon dan text jika aktif
      //     tabBackgroundColor: Color(0xff2297F4).withOpacity(0.9),
      //     padding: EdgeInsets.symmetric(
      //         vertical: heightPaddingGnav * 0.019,
      //         horizontal: widthPaddingGnav * 0.04),
      //     tabs: <GButton>[
      //       GButton(
      //         icon: FontAwesomeIcons.home,
      //         // text: 'Home',
      //         // iconSize: 25,
      //       ),
      //       GButton(
      //         icon: FontAwesomeIcons.clipboardList,
      //         // text: 'Report',
      //       ),
      //       GButton(
      //         icon: FontAwesomeIcons.wallet,
      //         // text: 'Payment',
      //       ),
      //       GButton(
      //         icon: FontAwesomeIcons.fileInvoiceDollar,
      //         // text: 'Bills',
      //       ),
      //       GButton(
      //         icon: Icons.thumb_up,
      //         // text: 'Recommen',
      //       )
      //     ],
      //     selectedIndex: _index,
      //     onTabChange: (index) {
      //       setState(() {
      //         _index = index;
      //       });
      //     },
      //   ),
      // ),
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
}
