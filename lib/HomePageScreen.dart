import 'package:flutter/material.dart';

class HomePageScreen extends StatefulWidget {
  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  // tinggi utnuk app bar hijau
  double heightAppBar;
  //  posisi dari atas untuk card status
  double positionedCardStatus;
  // tinggi card status
  double heightCardStatus;

  // demo user
  String userName = 'feri winarta';
  String rw = 'RW 007';

  @override
  Widget build(BuildContext context) {
    heightAppBar = MediaQuery.of(context).size.height * 0.15;
    positionedCardStatus = MediaQuery.of(context).size.height * 0.05;
    heightCardStatus = MediaQuery.of(context).size.height * 0.2;

    return Container(
      color: Colors.grey[200],
      child: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              Stack(children: [
                // Rounded bottom circle
                Container(
                  height: heightAppBar,
                  decoration: BoxDecoration(
                      color: Color(0xff4dff88),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(40),
                        bottomRight: Radius.circular(40),
                      )),
                ),

                // bagian card status
                Padding(
                  padding: EdgeInsets.only(top: positionedCardStatus),
                  child: Align(
                    alignment: Alignment.center,
                    child: Stack(children: [
                      SizedBox(
                        height: heightCardStatus,
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                        ),
                      ),

                      /**
                       * bagian dalam card status yang isinya dapat berubah
                       * mulai dari avatar, nama user, dan rw user
                       */
                      
                      // Text('$userName $rw')
                    ]),
                  ),
                )
              ])
            ],
          ),
        ],
      ),
    );
  }
}
