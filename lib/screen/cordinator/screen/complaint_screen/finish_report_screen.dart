import 'package:aplikasi_rw/server-app.dart';
import 'package:aplikasi_rw/services/cordinator/process_report_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FinishReportScreen extends StatelessWidget {
  FinishReportScreen(
      {Key key,
      this.url,
      this.time,
      this.title,
      this.description,
      this.location,
      this.latitude,
      this.longitude,
      this.idReport})
      : super(key: key);
  String url, title, description, location, time, latitude, longitude, idReport;

  FinishWorkCordinator work;

  @override
  Widget build(BuildContext context) {
    ProcessReportServices.getDataFinish(idReport: idReport)
        .then((value) => print('id estate ${value.photo1}'));

    return Scaffold(
      backgroundColor: Color(0xffE0E0E0),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(104.h),
        child: AppBar(
          backgroundColor: Color(0xFF2094F3),
          automaticallyImplyLeading: false,
          title: Text(
            'Laporan Selesai',
            style: TextStyle(fontSize: 19.sp, fontWeight: FontWeight.w500),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 2.h),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 24.h, left: 16.w),
                    child: Text('Laporan Sedang Proses'),
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    children: [
                      SizedBox(width: 16.w),
                      FutureBuilder<FinishWorkCordinator>(
                          future: ProcessReportServices.getDataFinish(
                              idReport: idReport),
                          builder: (context, snapshot) => (snapshot.hasData)
                              ? (snapshot.data.photo1 != null &&
                                      snapshot.data.photo1.isNotEmpty)
                                  ? Container(
                                      height: 70.h,
                                      width: 70.w,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(4)),
                                      child: Image.network(
                                        '${ServerApp.url}${snapshot.data.photo1}',
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : SizedBox()
                              : CircularProgressIndicator()),
                      SizedBox(width: 16.w),
                      FutureBuilder<FinishWorkCordinator>(
                          future: ProcessReportServices.getDataFinish(
                              idReport: idReport),
                          builder: (context, snapshot) => (snapshot.hasData)
                              ? (snapshot.data.photo2 != null &&
                                      snapshot.data.photo2.isNotEmpty)
                                  ? Container(
                                      height: 70.h,
                                      width: 70.w,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(4)),
                                      child: Image.network(
                                        '${ServerApp.url}${snapshot.data.photo2}',
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : SizedBox(
                                      width: 16.w,
                                    )
                              : CircularProgressIndicator()),
                      SizedBox(width: 16.w),
                      Container(
                        width: 156.w,
                        height: 70.h,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('Waktu Kerja'),
                            SizedBox(height: 14.h),
                            Text('80.00')
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 42.h),
                ],
              ),
            ),
            Container(
              color: Colors.white,
              child: Column(
                children: [],
              ),
            )
          ],
        ),
      ),
    );
  }
}
