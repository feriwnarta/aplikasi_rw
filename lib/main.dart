import 'package:aplikasi_rw/screen/home_page_screen.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

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
    );
  }
}

class TemplateScreen extends StatefulWidget {
  @override
  State<TemplateScreen> createState() => _TemplateScreenState();
}

class _TemplateScreenState extends State<TemplateScreen> {
  // tinggi bottom tab bar
  double heightTabBar;

  // Item untuk tab bar bawah
  final itemsTabBottomBar = <Widget>[
    Icon(Icons.home,size: 30,),
    Icon(Icons.report,size: 30,),
    Icon(Icons.payment,size: 30,),
    Icon(Icons.recommend, size: 30),
  ];

  // tinggi app bar
  double heightAppBar;

  // warna tab bar
  // var colorTabBar = Color(0xff8CBBF1);
  var colorTabBar = Color(0xff2196F3);

  @override
  Widget build(BuildContext context) {
    heightTabBar = MediaQuery.of(context).size.height * 0.2;

    return Scaffold(
      extendBody: true,
        appBar: AppBar(
          // Mengganti icon drawer sidebar menjadi icon person
          leading: Builder(
            builder: (context) {
              return IconButton(
                  icon: Icon(Icons.person),
                  onPressed: () => Scaffold.of(context).openDrawer());
            },
          ),
          elevation: 0,
          backgroundColor: colorTabBar,
          title: Text(
            'NEXT G - RW',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),

        // Membuat sidebar dengan drawer widget
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(color: Colors.blue),
                child: Text('Drawer header'),
              ),
              ListTile(
                title: Text('item1'),
                onTap: () {},
              ),
              ListTile(
                title: Text('item1'),
                onTap: () {},
              ),
              ListTile(
                title: Text('item1'),
                onTap: () {},
              ),
            ],
          ),
        ),
        body: HomePageScreen(),

        // bottom navigation bar
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
            iconTheme: IconThemeData(color: Colors.white),
          ),
          child: CurvedNavigationBar(
            height: MediaQuery.of(context).size.height * 0.1 / 1.6,
            items: itemsTabBottomBar,
            color: Colors.blue[500],
            buttonBackgroundColor: Colors.blue,
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
