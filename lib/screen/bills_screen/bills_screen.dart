import 'package:aplikasi_rw/screen/bills_screen/bills_reguler_screen.dart';
import 'package:flutter/material.dart';

class BillsScreen extends StatelessWidget {
  double mediaSizeHeight;

  @override
  Widget build(BuildContext context) {
    mediaSizeHeight = MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(mediaSizeHeight * 0.18),
          child: AppBar(
            brightness: Brightness.light,
            backgroundColor: Colors.white,
            flexibleSpace: Container(
              padding: EdgeInsets.only(bottom: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 20, top: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      Text(
                        'Bills',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 32,
                            fontFamily: 'poppins'),
                      ),
                      Text(
                        'citizen dues',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ]),
                  ),
                  Divider(
                    thickness: 1,
                  )
                ],
              ),
            ),
            bottom: TabBar(
              labelColor: Colors.black,
              labelStyle: TextStyle(
                fontWeight: FontWeight.bold
              ),
              tabs: [
                Tab(
                  text: '17 Agustusan',
                ),
                Tab(
                  text: 'Reguler',
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            Text('page 1'),
            BillsRegulerScreen()
          ],
        )
      ),
    );
  }
}
