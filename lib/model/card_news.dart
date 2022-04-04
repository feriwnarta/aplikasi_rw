import 'package:flutter/material.dart';

class CardNews {
  final String urlImageNews, caption;

  CardNews({this.urlImageNews, this.caption});

  static List<CardNews> getCardNews = [
      CardNews(
        urlImageNews: 'https://cms.depok.go.id/upload/c98ba2e10dde03333b150ab4cd514823.jpeg',
        caption: 'Vaksin booster Pfizer terbaru, Daftar segeraa'
      ),
      CardNews(
        urlImageNews: 'https://disk.mediaindonesia.com/thumbs/1800x1200/news/2021/04/1ebba27ef1df8c02a33e10e9704a6bc1.jpg',
        caption: 'Jadwal Bukber Dirumah Pak Sumardin'
      ),
      CardNews(
        urlImageNews: 'https://news.maranatha.edu/wp-content/uploads/2021/03/photo_2021-03-12_15-14-48.jpg',
        caption: 'Update Protokol Kesehatan RW 05 BGM PIK'
      ),
      CardNews(
        urlImageNews: 'https://cdn-2.tstatic.net/jabar/foto/bank/images/e-ktp-illustrasi.jpg',
        caption: 'Sekarang buat KTP Prosesnya tambah cepat'
      ),

  ];

}