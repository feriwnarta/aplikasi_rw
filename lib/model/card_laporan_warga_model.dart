class CardLaporanWargaModel {
  final String noTicket, judul, status;

  CardLaporanWargaModel({this.noTicket, this.judul, this.status});

  static List<CardLaporanWargaModel> getAllLaporan = [
    CardLaporanWargaModel(
      // 7 digit kode
      noTicket: '0522001',
      judul: 'Kehilangan kembang janda bolong',
      status: 'Clear',
    ),
    CardLaporanWargaModel(
      noTicket: '0522003',
      judul: 'Kehilangan motor',
      status: 'Noticed',
    ),
    CardLaporanWargaModel(
      noTicket: '0522009',
      judul: 'Orang tidak dikenal mondar mandir',
      status: 'Clear',
    ),
    CardLaporanWargaModel(
      noTicket: '0522010',
      judul: 'Sampah berantakan',
      status: 'Noticed',
    ),
    CardLaporanWargaModel(
      noTicket: '0522016',
      judul: 'Selokan mampet',
      status: 'Listed',
    ),
  ];
}
