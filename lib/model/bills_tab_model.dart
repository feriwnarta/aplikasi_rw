import 'package:aplikasi_rw/screen/bills_screen/bills_reguler_screen.dart';
import 'package:aplikasi_rw/screen/bills_screen/event_bill_screen.dart';
import 'package:flutter/material.dart';

class BillTab {
  Tab tab;
  Widget screen;
  Color colorsAppBar;
  Color colorsText;

  BillTab({this.tab, this.screen, this.colorsAppBar, this.colorsText});
}

class BillTabModel {

  static List<BillTab> tabs() {
    return [
      BillTab(
        colorsAppBar: Colors.white,
        tab: Tab(text: 'Reguler',),
        screen: BillsRegulerScreen(),
        colorsText: Colors.black
      ),
      BillTab(
        colorsAppBar: Colors.red,
        tab: Tab(text: 'Event 17 August'),
        screen: EventBillScrenn(
          urlHeroImage: 'https://asset.kompas.com/crops/wvIJirTN7tp9S7AQ4mmlkdkMk0o=/0x0:780x520/750x500/data/photo/2020/08/13/5f354e00ebe40.jpg',
          titleEvent: 'citizen dues for the 17 august 2022',
          price: '200.000',
          dueDate: 'due date 7 agustus',
          background: Colors.red,
        ),
        colorsText: Colors.white
      ),
      BillTab(
        colorsAppBar: Colors.blue,
        tab: Tab(text: 'Event idul adha',),
        screen: EventBillScrenn(
          urlHeroImage: 'https://kemenkumham.go.id/images/foto/2019/8_Agustus/2019-08-11_-_Idul_Adha_1.jpg',
          titleEvent: 'cost to buy sacrificial animals',
          price: '200.000',
          dueDate: 'due date 7 agustus',
          background: Colors.blue,
        ),
        colorsText: Colors.white,
      )
    ];
  }
}