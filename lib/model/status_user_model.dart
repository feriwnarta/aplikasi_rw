class StatusUserModel {
  final String urlProfile,
      userName,
      lamaUpload,
      urlFotoStatus,
      caption,
      jumlahLike,
      jumlahKomen;

  StatusUserModel(
      {this.userName,
      this.lamaUpload,
      this.urlProfile,
      this.urlFotoStatus,
      this.caption,
      this.jumlahLike,
      this.jumlahKomen});

  static List<StatusUserModel> getAllStatus = [
    StatusUserModel(
        userName: 'Siti',
        lamaUpload: '15 menit',
        urlProfile: 'https://media.suara.com/pictures/653x366/2021/09/18/26068-jung-ho-yeong.jpg',
        urlFotoStatus: 'https://lovelybogor.com/wp-content/uploads/2016/02/Pedagang-Kumang-Di-Bogor-Fotografi-Jalanan-01.jpg',
        caption:'pedagang kumang berjualan dipinggir jalan deket rumah pak RT pedagang kumang berjualan dipinggir jalan deket rumah pak RT pedagang kumang berjualan dipinggir jalan deket rumah pak RT pedagang kumang berjualan dipinggir jalan deket rumah pak RT pedagang kumang berjualan dipinggir jalan deket rumah pak RT pedagang kumang berjualan dipinggir jalan deket rumah pak RT pedagang kumang berjualan dipinggir jalan deket rumah pak RT pedagang kumang berjualan dipinggir jalan deket rumah pak RT',
        jumlahKomen: '12',
        jumlahLike: '19'        
    ),

    StatusUserModel(
      userName: 'joko',
      lamaUpload: '30 menit',
      urlProfile: 'https://akcdn.detik.net.id/visual/2022/02/04/ainun-najib-1_169.jpeg?w=650',
      urlFotoStatus: 'https://asset-a.grid.id/crop/0x0:0x0/780x800/photo/bobofoto/original/17852_bagaimana-air-hujan-bisa-merusak-jalanan-aspal.jpg',
      caption: 'Jalanan rusak di RT 07',
      jumlahKomen: '15',
      jumlahLike: '21'
    ),

    StatusUserModel(
      userName: 'Susanto',
      lamaUpload: '1 jam',
      urlProfile: 'https://disk.mediaindonesia.com/thumbs/600x400/news/2020/10/fe8644c762c90d7b7ff16ed49786cd96.jpg',
      urlFotoStatus: 'https://cdn-2.tstatic.net/kaltim/foto/bank/images/jalan-asmawarman1_20160202_133513.jpg',
      caption: 'Lampu jalanan kurang penerangan' ,
      jumlahKomen: '11',
      jumlahLike: '19'
    ),

  StatusUserModel(
    userName: 'Yani',
    lamaUpload: '2 jam',
    urlProfile: 'https://www.superprof.co.id/gambar/guru/rumah-guru-saya-orang-indonesia-asli-menawarkan-belajar-bahasa-indonesia-simple-untuk-orang-asing.jpg',
    urlFotoStatus: 'https://media.suara.com/pictures/653x366/2020/10/03/28146-hobi-tanaman-hias.jpg',
    caption: 'Dijual tanaman hias hubungi saya segera..',
    jumlahKomen: '19',
    jumlahLike: '25'
  )
  ];

}
