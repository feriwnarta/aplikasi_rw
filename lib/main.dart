import 'package:aplikasi_rw/screen/home_page_screen.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

  // tinggi bottom tab bar
  double heightTabBar;

  // Item untuk tab bar bawah
  final itemsTabBottomBar = <Widget>[
    Icon(
      Icons.home_filled,
      size: 30,
    ),
    Icon(
      Icons.report,
      size: 30,
    ),
    Icon(
      Icons.payment,
      size: 30,
    ),
    Icon(Icons.recommend, size: 30),
  ];

  // tinggi app bar
  double heightAppBar;

  // warna tab bar
  // var colorTabBar = Color(0xff8CBBF1);
  var colorTabBar = Color(0xff2196F3);

  @override
  Widget build(BuildContext context) {
    

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.lightBlue
    ));

    heightTabBar = MediaQuery.of(context).size.height * 0.2;

    return Scaffold(
        key: scaffoldKey,
        extendBody: true,
        // appBar: PreferredSize(
        //   // tinggi app bar
        //   preferredSize:
        //       Size.fromHeight(MediaQuery.of(context).size.height * 0.065),
        //   child: AppBar(
        //     // Mengganti icon drawer sidebar menjadi icon person
        //     leading: Builder(
        //       builder: (context) {
        //         return IconButton(
        //             iconSize: MediaQuery.of(context).size.height * 0.040,
        //             icon: Icon(Icons.person),
        //             onPressed: () => Scaffold.of(context).openDrawer());
        //       },
        //     ),
        //     elevation: 0,
        //     backgroundColor: colorTabBar,
        //     title: Align(
        //       alignment: Alignment.topRight,
        //       child: Text('NEXT G - RW',
        //           style: TextStyle(
        //             fontWeight: FontWeight.bold,
        //           )),
        //     ),
        //   ),
        // ),

        // Membuat sidebar dengan drawer widget
        drawer: Drawer(
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
        ),
        body: HomePageScreen(scaffoldKey),

        // bottom navigation bar
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
            iconTheme: IconThemeData(color: Colors.white),
          ),
          child: CurvedNavigationBar(
            height: MediaQuery.of(context).size.height * 0.1 / 1.7,
            items: itemsTabBottomBar,
            color: Colors.blue[400],
            // color: Colors.blueGrey,
            buttonBackgroundColor: Colors.blueAccent[200],
            backgroundColor: Colors.transparent,
            animationDuration: Duration(milliseconds: 300),
          ),
        ));
  }
}

// body: Container(
//   color: Colors.grey[200],
//   child: ListView(
//     children: <Widget>[
//       Column(
//         children: <Widget>[
//           Stack(children: [
//             Container(
//               height: heightAppBar,
//               decoration: BoxDecoration(
//                   color: Color(0xff4dff88),
//                   borderRadius: BorderRadius.only(
//                     bottomLeft: Radius.circular(40),
//                     bottomRight: Radius.circular(40),
//                   )),
//             ),
//           ])
//         ],
//       ),
//     ],
//   ),
// ),
