import 'package:aplikasi_rw/screen/home_page_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // debug banner
      debugShowCheckedModeBanner: false,
      home: TemplateScreen(),
      theme: ThemeData(
      
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

  // Item untuk tab bar bawah
  // final itemsTabBottomBar = <Widget>[
  //   Icon(
  //     Icons.home_filled,
  //     size: 30,
  //   ),
  //   Icon(
  //     Icons.report,
  //     size: 30,
  //   ),
  //   Icon(
  //     Icons.payment,
  //     size: 30,
  //   ),
  //   Icon(Icons.recommend, size: 30),
  // ];

  // tinggi app bar
  double heightAppBar;

  // warna tab bar
  // var colorTabBar = Color(0xff8CBBF1);
  var colorTabBar = Color(0xff2196F3);

  @override
  Widget build(BuildContext context) {
    

    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //   statusBarColor: Colors.lightBlue
    // ));

    heightTabBar = MediaQuery.of(context).size.height * 0.2;

    return Scaffold(
      // resizeToAvoidBottomInset: false,
        key: scaffoldKey,
        // membuat bottomNavigationBar transparent
        // extendBody: true,

        // membuat sidebar dan drawer
        drawer: drawerSideBar(),
        body: HomePageScreen(scaffoldKey),

        // bottom navigation bar
        bottomNavigationBar: Container(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          margin: EdgeInsets.symmetric(vertical: 2),
          decoration: BoxDecoration(  
            color: Colors.white,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 5,
              )
            ]
          ),
          child: GNav(
            curve: Curves.easeInOut,
            duration: Duration(milliseconds: 250),
            iconSize: 24,
            gap: 8,
            // rippleColor: Colors.purpleAccent, // splash color / riple
            color: Colors.blueGrey.withOpacity(0.6), // warna icon dan text yang tidak aktif
            activeColor: Colors.white, // warna icon dan text jika aktif
            // hoverColor: Colors.green,
            // haptic: true,
            // tabBorderRadius: 100, // border radius untuk tab belakang icon dan text
            // tabShadow: [BoxShadow(color: Colors.grey.withOpacity(0.5), blurRadius: 8)],
            //tabBackgroundColor: Colors.lightBlue.withOpacity(0.8), // background color
            tabBackgroundColor: Color(0xff2297F4).withOpacity(0.9),
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),  
            tabs: [
              GButton(
                icon: FontAwesomeIcons.home,
                text: 'Home',
                // iconSize: 25,
              ),
              GButton(
                icon: FontAwesomeIcons.clipboardList,
                text: 'Report',
              ),
              GButton(
                icon: FontAwesomeIcons.wallet,
                text: 'Payment',
              ),
              GButton(
                icon: FontAwesomeIcons.fileInvoiceDollar,
                text: 'Bills',
              ),
              GButton(
                icon:Icons.thumb_up,
                text: 'Recommen',
              )
            ],
            selectedIndex: _index,
            onTabChange: (index) {
              setState(() {
                _index = index;
              });
            },
          ),
        ),
      );
  }

  // Theme bottomNavigationBarCurved(BuildContext context) {
  //   return Theme(
  //       data: Theme.of(context).copyWith(
  //         iconTheme: IconThemeData(color: Colors.white),
  //       ),
  //       child: CurvedNavigationBar(
  //         height: MediaQuery.of(context).size.height * 0.1 / 1.7,
  //         items: itemsTabBottomBar,
  //         color: Colors.blue[400],
  //         // color: Colors.blueGrey,
  //         buttonBackgroundColor: Colors.blueAccent[200],
  //         backgroundColor: Colors.transparent,
  //         animationDuration: Duration(milliseconds: 300),
  //       ),
  //     );
  // }

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