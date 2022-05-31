class StatusUserModel {
  final String urlProfile,
      userName,
      uploadTime,
      urlStatusImage,
      caption,
      numberOfLikes,
      numberOfComments;

  StatusUserModel(
      {this.userName,
      this.uploadTime,
      this.urlProfile,
      this.urlStatusImage,
      this.caption,
      this.numberOfLikes,
      this.numberOfComments});

  static List<StatusUserModel> getAllStatus = [
    StatusUserModel(
        userName: 'Siti',
        uploadTime: '15 menit',
        urlProfile: 'https://media.suara.com/pictures/653x366/2021/09/18/26068-jung-ho-yeong.jpg',
        urlStatusImage: 'https://adekinan.files.wordpress.com/2015/02/wpid-wp-1424086946141.jpeg',
        caption:'pedagang kumang berjualan dipinggir jalan deket rumah pak RT pedagang kumang berjualan dipinggir jalan deket rumah pak RT pedagang kumang berjualan dipinggir jalan deket rumah pak RT pedagang kumang berjualan dipinggir jalan deket rumah pak RT pedagang kumang berjualan dipinggir jalan deket rumah pak RT pedagang kumang berjualan dipinggir jalan deket rumah pak RT pedagang kumang berjualan dipinggir jalan deket rumah pak RT pedagang kumang berjualan dipinggir jalan deket rumah pak RT',
        numberOfComments: '12',
        numberOfLikes: '19'        
    ),

    StatusUserModel(
      userName: 'joko',
      uploadTime: '30 menit',
      urlProfile: 'https://akcdn.detik.net.id/visual/2022/02/04/ainun-najib-1_169.jpeg?w=650',
      urlStatusImage: 'https://asset-a.grid.id/crop/0x0:0x0/780x800/photo/bobofoto/original/17852_bagaimana-air-hujan-bisa-merusak-jalanan-aspal.jpg',
      caption: 'Jalanan rusak di RT 07',
      numberOfComments: '15',
      numberOfLikes: '21'
    ),

    StatusUserModel(
      userName: 'Susanto',
      uploadTime: '1 jam',
      urlProfile: 'https://disk.mediaindonesia.com/thumbs/600x400/news/2020/10/fe8644c762c90d7b7ff16ed49786cd96.jpg',
      urlStatusImage: 'https://cdn-2.tstatic.net/kaltim/foto/bank/images/jalan-asmawarman1_20160202_133513.jpg',
      caption: 'Lampu jalanan kurang penerangan' ,
      numberOfComments: '11',
      numberOfLikes: '19'
    ),

  StatusUserModel(
    userName: 'Yani',
    uploadTime: '2 jam',
    urlProfile: 'https://cdn0-production-images-kly.akamaized.net/CZ4JB-nS0u8xiMTfTEPaGuaRWAw=/640x360/smart/filters:quality(75):strip_icc():format(jpeg)/kly-media-production/medias/2715477/original/040195000_1548741244-Dx95B_oUUAANtWV.jpg',
    urlStatusImage: 'https://media.suara.com/pictures/653x366/2020/10/03/28146-hobi-tanaman-hias.jpg',
    caption: 'Dijual tanaman hias hubungi saya segera..',
    numberOfComments: '19',
    numberOfLikes: '25'
  )
  ];

}
