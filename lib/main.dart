import 'package:aplikasi_rw/HomePageScreen.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TemplateScreen(),
    );
  }
}

class TemplateScreen extends StatefulWidget {
  @override
  State<TemplateScreen> createState() => _TemplateScreenState();
}

class _TemplateScreenState extends State<TemplateScreen> {
  // Item untuk tab bar bawah
  final itemsTabBottomBar = <Widget>[
    Icon(
      Icons.home,
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
    Icon(Icons.recommend, size: 30)
  ];

  // tinggi app bar
  double heightAppBar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          backgroundColor: Color(0xff4dff88),
          title: Text('NEXT G - RW'),
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
        bottomNavigationBar: CurvedNavigationBar(
          items: itemsTabBottomBar,
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