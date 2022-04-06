import 'package:aplikasi_rw/support_screen/card_laporan_warga.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ReportScreen extends StatefulWidget {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  ReportScreen(this.scaffoldKey);

  @override
  State<ReportScreen> createState() => ReportScreeneState(scaffoldKey);
}

class ReportScreeneState extends State<ReportScreen> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  double mediaSizeHeight;
  double mediaSizeWidth;

  ReportScreeneState(this.scaffoldKey);

  @override
  Widget build(BuildContext context) {
    mediaSizeHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    mediaSizeWidth = MediaQuery.of(context).size.height;

    return Scaffold(
      body: ListView(
        children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20, top: 20),
                    child: Text(
                      'Laporan',
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'poppins',
                          fontSize: 29),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 15, right: 15),
                    width: mediaSizeWidth * 0.46,
                    height: mediaSizeHeight * 0.07,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(20)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Laporan Saya',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        Row(
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(right: 10),
                                  child: Text(
                                    '5',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  ),
                                ),
                                Icon(
                                  FontAwesomeIcons.clipboard,
                                  size: 19,
                                  color: Colors.white,
                                )
                              ],
                            ),
                            Row(
                              children: [
                                VerticalDivider(
                                  color: Colors.white,
                                  width: 50,
                                  thickness: 1,
                                  indent: 17,
                                  endIndent: 17,
                                ),
                                Icon(
                                  FontAwesomeIcons.angleUp,
                                  size: 29,
                                  color: Colors.white,
                                )
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                width: mediaSizeWidth * 0.42,
                decoration: BoxDecoration(
                    color: Colors.yellow[700],
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Quick Guide',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        Icon(
                          Icons.clear_rounded,
                          color: Colors.white,
                        ),
                      ],
                    ),
                    Divider(
                      color: Colors.white,
                      thickness: 1.2,
                    ),
                    Column(
                      children: [
                        Text(
                          'Ini adalah bagian untuk membuat laporan, silahkan klik tombol add (+) masukan judul, dan isi laporan beserta gambar kemudian laporan akan segera kami proses.',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 10,
                        )
                      ],
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('No tickets', style: TextStyle(fontSize: 10, color: Colors.grey),),
                    Text('Title', style: TextStyle(fontSize: 10, color: Colors.grey),),
                    Text('Status', style: TextStyle(fontSize: 10, color: Colors.grey),),
                  ],
                ),
              ),

                  
              CardLaporanWarga(
                // 7 digit kode
                noTicket: '0522001',
                judul: 'Kehilangan kembang janda bolong',
                status: 'Listed',
              ),
              CardLaporanWarga(
                noTicket: '0522003',
                judul: 'Kehilangan motor',
                status: 'Clear',
              ),
              CardLaporanWarga(
                noTicket: '0522009',
                judul: 'Orang tidak dikenal mondar mandir',
                status: 'Noticed',
              ),
              CardLaporanWarga(
                noTicket: '0522009',
                judul: 'Orang tidak dikenal mondar mandir',
                status: 'Noticed',
              ),
              
              

              // Card(
              //   shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(20)),
              //   elevation: 2,
              //   child: ListTile(
              //     contentPadding: EdgeInsets.only(left: 20, right: 20),
              //     leading: Text(
              //       '1#',
              //       style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
              //     ),
              //     title: Text(
              //       // 36 kata
              //       'Kehilangan Kembang Janda bolong',
              //       maxLines: 1,
              //       overflow: TextOverflow.ellipsis,
              //       style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
              //     ),
              //     trailing: Text(
              //       'Listed',
              //       style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.grey),
              //     ),
              //   ),
              // )
            ],
          )
        ],
      ),
    );
  }
}

// Padding(
//                     padding: EdgeInsets.only(left: 10, right: 10),
//                     child: ListTileTheme(
//                       tileColor: Colors.lightBlue,
//                       iconColor: Colors.white,
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.circular(20),
//                         child: ExpansionTile(
//                           leading: Padding(
//                             padding: const EdgeInsets.only(top: 4.0),
//                             child: Text(
//                               'My Report',
//                               style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.bold),
//                             ),
//                           ),
//                           trailing: Icon(
//                             Icons.keyboard_arrow_down,
//                             color: Colors.white,
//                           ),
//                           title: null,
//                           children: [
//                             Padding(
//                                 padding: EdgeInsets.only(top: 40),
//                                 child: Row(
//                                   children: [
//                                     Text('No Tickets'),
//                                     Text('title'),
//                                     Text('status'),
//                                   ],
//                                 ))
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
