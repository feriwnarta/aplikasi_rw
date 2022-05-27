import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';
import 'package:timeline_tile/timeline_tile.dart';

//ignore: must_be_immutable
class CardLaporanView extends StatelessWidget {
  String urlImage,
      description,
      additionalInformation,
      noTicket,
      status,
      time,
      category;

  CardLaporanView(
      {this.urlImage,
      this.description,
      this.additionalInformation,
      this.noTicket,
      this.status,
      this.time,
      this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          brightness: Brightness.light,
          title: Text(''),
          elevation: 0,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        body: SafeArea(
          child: ListView(
            children: [
              Container(
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // image
                    SizedBox(
                      height: 30.0.h,
                      width: 100.0.w,
                      child: Image(
                        fit: BoxFit.cover,
                        image: NetworkImage(urlImage),
                      ),
                    ),
                    SizedBox(
                      height: 3.0.h,
                    ),
                    Container(
                        margin: EdgeInsets.only(left: 4.0.w),
                        width: 90.0.w,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'description',
                              style: TextStyle(
                                  fontSize: 11.0.sp, fontFamily: 'poppins'),
                            ),
                            SizedBox(
                              height: 0.5.h,
                            ),
                            Text(
                              description,
                              style: TextStyle(
                                  fontSize: 11.0.sp, fontFamily: 'Montserrat'),
                            ),
                          ],
                        )),
                    SizedBox(
                      height: 2.0.h,
                    ),
                    Container(
                        width: 90.0.w,
                        margin: EdgeInsets.only(left: 4.0.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Feedback',
                              style: TextStyle(
                                  fontSize: 11.0.sp, fontFamily: 'poppins'),
                            ),
                            SizedBox(
                              height: 0.5.h,
                            ),
                            Text(
                              additionalInformation,
                              style: TextStyle(
                                  fontSize: 11.0.sp, fontFamily: 'Montserrat'),
                            ),
                          ],
                        )),
                    SizedBox(
                      height: 2.0.h,
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: 2.0.h,
              ),

              // detail laporan
              buildContainerDetailLaporan(),
              SizedBox(
                height: 2.0.h,
              ),

              Container(
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 4.0.w, top: 2.0.h),
                      child: Text(
                        'Location',
                        style:
                            TextStyle(fontSize: 12.0.sp, fontFamily: 'poppins'),
                      ),
                    ),
                    SizedBox(height: 2.0.h),
                    Container(
                      height: 40.0.h,
                      // color: Colors.grey,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/img/lokasi.jpg'),
                              fit: BoxFit.cover,
                              repeat: ImageRepeat.noRepeat)),
                    ),
                    SizedBox(height: 1.0.h),
                    buildContainerHistoryReport(),
                  ],
                ),
              ),

              SizedBox(
                height: 2.0.h,
              ),

              Container(
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 2.0.h),
                    Row(
                      children: [
                        SizedBox(width: 4.0.w),
                        Text(
                          'Review',
                          style: TextStyle(
                              fontSize: 12.0.sp, fontFamily: 'poppins'),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 2.0.h,
                    ),
                    Row(
                      children: [
                        SizedBox(width: 4.0.w),
                        Icon(
                          Icons.star,
                          color: Colors.yellow[700],
                          size: 4.0.h,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.yellow[700],
                          size: 4.0.h,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.yellow[700],
                          size: 4.0.h,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.yellow[700],
                          size: 4.0.h,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.yellow[700],
                          size: 4.0.h,
                        ),
                      ],
                    ),
                    SizedBox(height: 1.0.h),
                    Center(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 2.0.w, vertical: 2.0.h),
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(10)),
                        width: 90.0.w,
                        child: Text(
                          'Komentar Pelapor',
                          style: TextStyle(fontSize: 12.0.sp),
                        ),
                      ),
                    ),
                    SizedBox(height: 1.0.h),
                    Row(
                      children: [
                        SizedBox(width: 4.5.w),
                        Text(
                          '19 Mei 2022 : 14:55',
                          style:
                              TextStyle(fontSize: 9.0.sp, color: Colors.grey),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 2.0.h,
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }

  Container buildContainerHistoryReport() {
    return Container(
      color: Colors.white,
      child: Theme(
        data: ThemeData().copyWith(
            dividerColor: Colors.transparent, accentColor: Colors.black),
        child: ExpansionTile(
          expandedAlignment: Alignment.centerLeft,
          title: Text(
            'History Report',
            style: TextStyle(fontSize: 12.0.sp, fontFamily: 'poppins'),
          ),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 4.0.h,
                width: 20.0.w,
                decoration: BoxDecoration(
                    color: (status.toLowerCase() == 'listed')
                        ? Colors.red
                        : (status.toLowerCase() == 'noticed')
                            ? Colors.yellow[900]
                            : (status.toLowerCase() == 'process')
                                ? Colors.yellow[600]
                                : Colors.green,
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                    child: Text(
                  status,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                )),
              ),
              SizedBox(
                width: 2.0.w,
              ),
              Text(
                'Laporan Diproses',
                style: TextStyle(fontSize: 11.0.sp),
              )
            ],
          ),
          children: [
            Container(
              margin: EdgeInsets.only(left: 4.0.w),
              height: 10.0.h,
              child: TimelineTile(
                endChild: Container(
                  margin: EdgeInsets.only(left: 20),
                  child: ListTile(
                    title: Text('Laporan ditanggapi'),
                    subtitle: Text('19 Mei 2022 : 19.00'),
                  ),
                ),
                isFirst: true,
                afterLineStyle:
                    LineStyle(color: Colors.blueAccent, thickness: 1),
                indicatorStyle: IndicatorStyle(
                  color: Colors.green,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 4.0.w),
              height: 10.0.h,
              child: TimelineTile(
                endChild: Container(
                  margin: EdgeInsets.only(left: 20),
                  child: ListTile(
                    title: Text('Laporan diproses'),
                    subtitle: Text('19 Mei 2022 : 19.00'),
                  ),
                ),
                beforeLineStyle:
                    LineStyle(color: Colors.blueAccent, thickness: 1),
                // isFirst: true,
                afterLineStyle:
                    LineStyle(color: Colors.blueAccent, thickness: 1),
                indicatorStyle: IndicatorStyle(
                  color: Colors.green,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Container buildContainerDetailLaporan() {
    return Container(
      color: Colors.white,
      child: Theme(
        data: ThemeData().copyWith(
            dividerColor: Colors.transparent, accentColor: Colors.black),
        child: ExpansionTile(
          expandedAlignment: Alignment.centerLeft,
          title: Text(
            'Detail Report',
            style: TextStyle(fontSize: 12.0.sp, fontFamily: 'poppins'),
          ),
          children: [
            Padding(
              padding: EdgeInsets.only(left: 4.0.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'No Tickets',
                    style: TextStyle(fontSize: 11.0.sp),
                  ),
                  SizedBox(
                    height: 0.5.h,
                  ),
                  Text(noTicket,
                      style: TextStyle(
                          fontSize: 11.0.sp,
                          fontFamily: 'Montserrat',
                          color: Colors.indigo)),
                  SizedBox(
                    height: 2.0.h,
                  ),
                  Text('Entry Time', style: TextStyle(fontSize: 11.0.sp)),
                  SizedBox(
                    height: 0.5.h,
                  ),
                  Text(
                    time,
                    style:
                        TextStyle(fontSize: 11.0.sp, fontFamily: 'Montserrat'),
                  ),
                  SizedBox(
                    height: 2.0.h,
                  ),
                  Text('Category', style: TextStyle(fontSize: 11.0.sp)),
                  SizedBox(
                    height: 0.5.h,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.waves,
                        color: Colors.red,
                      ),
                      SizedBox(
                        width: 5.0.w,
                      ),
                      Text(category,
                          style: TextStyle(
                              fontSize: 11.0.sp, fontFamily: 'Montserrat')),
                    ],
                  ),
                  SizedBox(
                    height: 2.0.h,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
