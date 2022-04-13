import 'package:aplikasi_rw/screen/bills_screen/bills_reguler_screen.dart';
import 'package:flutter/material.dart';

class BillTab {
  Tab tab;
  Widget screen;
  Color colorsAppBar;

  BillTab({this.tab, this.screen, this.colorsAppBar});
}

class BillTabModel {

  static List<BillTab> tabs() {
    return [
      BillTab(
        colorsAppBar: Colors.red,
        tab: Tab(text: '17 Agustus 2022',),
        screen: Text('17 agustus')
      ),
      BillTab(
        colorsAppBar: Colors.white,
        tab: Tab(text: 'Reguler',),
        screen: BillsRegulerScreen()
      ),
      BillTab(
        colorsAppBar: Colors.blue,
        tab: Tab(text: 'Idul adha',),
        screen: Text('tagihan idul adha')
      )
    ];
  }
}