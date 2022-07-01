import 'dart:async';

import 'package:aplikasi_rw/screen/report_screen2/view_image.dart';
import 'package:aplikasi_rw/server-app.dart';
import 'package:aplikasi_rw/services/history_report_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:timeline_tile/timeline_tile.dart';

//ignore: must_be_immutable
class CardLaporanView extends StatelessWidget {
  bool isVisibilityExpansion = false;
  String urlImage,
      description,
      additionalInformation,
      noTicket,
      status,
      time,
      category,
      categoryIcon,
      latitude,
      idReport,
      idUser,
      longitude;
  List<dynamic> dataKlasifikasi;

  CardLaporanView(
      {this.urlImage,
      this.description,
      this.additionalInformation,
      this.noTicket,
      this.status,
      this.time,
      this.category,
      this.categoryIcon,
      this.latitude,
      this.idReport,
      this.idUser,
      this.dataKlasifikasi,
      this.longitude});

  @override
  Widget build(BuildContext context) {
    print(latitude);
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
                    GestureDetector(
                        child: SizedBox(
                          height: 50.0.h,
                          width: 100.0.w,
                          child: Image(
                            fit: BoxFit.cover,
                            image: NetworkImage(urlImage),
                          ),
                        ),
                        onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) =>
                                    ViewImage(urlImage: urlImage)))),
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
                              'problem',
                              style: TextStyle(
                                  fontSize: 11.0.sp, fontFamily: 'poppins'),
                            ),
                            SizedBox(height: 1.0.h),
                            ListView.builder(
                              itemCount: dataKlasifikasi.length,
                              physics: ScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) => Column(
                                children: [
                                  Row(
                                    children: [
                                      Icon(FontAwesomeIcons.exclamationCircle,
                                          color: Colors.blue),
                                      SizedBox(
                                        width: 4.0.w,
                                      ),
                                      Text(
                                        '${dataKlasifikasi[index]}',
                                        style: TextStyle(
                                            fontSize: 11.0.sp,
                                            fontFamily: 'Montserrat'),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 1.0.h)
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 0.5.h,
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
                    GoogleMapViewReport(
                        latitude: latitude, longitude: longitude),
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
        child: FutureBuilder<List<HistoryReportModel>>(
            future: HistoryReportServices.getHistoryProcess(idReport, idUser),
            builder: (context, snapshot) => (snapshot.hasData)
                ? ExpansionTile(
                    expandedAlignment: Alignment.centerLeft,
                    initiallyExpanded: true,
                    onExpansionChanged: (value) =>
                        isVisibilityExpansion = value,
                    title: Text(
                      'History Report',
                      style:
                          TextStyle(fontSize: 12.0.sp, fontFamily: 'poppins'),
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
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )),
                        ),
                        SizedBox(
                          width: 2.0.w,
                        ),
                        Visibility(
                          visible: isVisibilityExpansion,
                          child: Expanded(
                            child: Text(
                              '${snapshot.data.last.statusProcess}',
                              maxLines: 2,
                              style: TextStyle(fontSize: 11.0.sp),
                            ),
                          ),
                        )
                      ],
                    ),
                    children: [
                      (snapshot.hasData)
                          ? (snapshot.data.length > 0)
                              ? ListView.builder(
                                  itemCount: snapshot.data.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) => Container(
                                    margin: EdgeInsets.only(left: 4.0.w),
                                    height: 10.0.h,
                                    child: TimelineTile(
                                      endChild: Container(
                                        margin: EdgeInsets.only(left: 20),
                                        child: ListTile(
                                          title: Text(
                                            '${snapshot.data[index].statusProcess}',
                                            style: TextStyle(fontSize: 12.0.sp),
                                          ),
                                          subtitle: Text(
                                            '${snapshot.data[index].time}',
                                            style: TextStyle(fontSize: 10.0.sp),
                                          ),
                                        ),
                                      ),
                                      isFirst: index == 0 ? true : false,
                                      beforeLineStyle: LineStyle(
                                          color: Colors.blueAccent,
                                          thickness: 1),
                                      afterLineStyle: LineStyle(
                                          color: Colors.blueAccent,
                                          thickness: 1),
                                      indicatorStyle: IndicatorStyle(
                                        color: Colors.green,
                                      ),
                                    ),
                                  ),
                                )
                              : Center(child: Text('history kosong'))
                          : Container()
                    ],
                  )
                : Container()),
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
          initiallyExpanded: true,
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
                      Image.network(
                        '${ServerApp.url}icon/${categoryIcon}',
                        height: 4.5.h,
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

class GoogleMapViewReport extends StatefulWidget {
  const GoogleMapViewReport({
    Key key,
    @required this.latitude,
    @required this.longitude,
  }) : super(key: key);

  final String latitude;
  final String longitude;

  @override
  _GoogleMapViewReportState createState() => _GoogleMapViewReportState();
}

class _GoogleMapViewReportState extends State<GoogleMapViewReport> {
  GoogleMapController _controller;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.0.h,
      child: GoogleMap(
        initialCameraPosition: CameraPosition(
            bearing: 192.8334901395799,
            target: LatLng(
                double.parse(widget.latitude), double.parse(widget.longitude)),
            tilt: 0,
            zoom: 12.151926040649414),
        zoomControlsEnabled: false,
        zoomGesturesEnabled: false,
        onMapCreated: (controller) => _controller = controller,
        mapType: MapType.normal,
        markers: {
          Marker(
              markerId: MarkerId('1'),
              position: LatLng(double.parse(widget.latitude),
                  double.parse(widget.longitude)))
        },
      ),
    );
  }
}
