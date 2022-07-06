import 'package:aplikasi_rw/screen/cordinator/screen/complaint_screen/process_report.dart';
import 'package:aplikasi_rw/screen/report_screen2/view_image.dart';
import 'package:aplikasi_rw/server-app.dart';
import 'package:aplikasi_rw/services/cordinator/process_report_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailReportScreen extends StatelessWidget {
  String url,
      title,
      description,
      location,
      time,
      latitude,
      longitude,
      idReport,
      name;

  DetailReportScreen(
      {this.url,
      this.time,
      this.title,
      this.description,
      this.location,
      this.latitude,
      this.longitude,
      this.idReport,
      this.name});

  @override
  Widget build(BuildContext context) {
    print(name);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(104.h),
        child: AppBar(
          backgroundColor: Color(0xFF2094F3),
          title: Text(
            'Detail Laporan',
            style: TextStyle(fontSize: 19.sp, fontWeight: FontWeight.w500),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(left: 16.w, right: 25.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(0, 24.h, 0, 0),
                width: 319.w,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset(
                      'assets/img/image-svg/location-marker.svg',
                      color: Colors.black,
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Text(
                        location,
                        style: TextStyle(
                            fontSize: 14.sp, fontWeight: FontWeight.w400),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 16.h, 0, 0),
                child: (title.contains(','))
                    ? ListView.builder(
                        shrinkWrap: true,
                        itemCount: explodeTitle().length,
                        itemBuilder: (context, index) => Container(
                          margin: EdgeInsets.only(bottom: 6.h),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                  'assets/img/image-svg/Icon-warning.svg'),
                              SizedBox(width: 8.w),
                              Expanded(child: Text('${explodeTitle()[index]}'))
                            ],
                          ),
                        ),
                      )
                    : Row(
                        children: [
                          SvgPicture.asset(
                              'assets/img/image-svg/Icon-warning.svg'),
                          SizedBox(width: 8.w),
                          Expanded(child: Text(title))
                        ],
                      ),
              ),
              SizedBox(height: 32.h),
              GestureDetector(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ViewImage(
                          urlImage: url,
                        ))),
                child: SizedBox(
                  height: 188.w,
                  width: 319.w,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: Image.network(
                      '$url',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 8.h),
              GestureDetector(
                onTap: () =>
                    navigateTo(double.parse(latitude), double.parse(longitude)),
                child: Row(
                  children: [
                    SizedBox(width: 240.w),
                    SvgPicture.asset('assets/img/image-svg/Icon-map.svg'),
                    SizedBox(width: 4.w),
                    Text(
                      'Lihat peta lokasi',
                      style:
                          TextStyle(color: Color(0xff2094F3), fontSize: 10.sp),
                    )
                  ],
                ),
              ),
              SizedBox(height: 16.h),
              SizedBox(
                  width: 319.w,
                  child: Text(
                    description,
                    style: TextStyle(color: Color(0xff757575), fontSize: 12.sp),
                  )),
              SizedBox(height: 122.h),
              SizedBox(
                width: 328.w,
                height: 40.h,
                child: FlatButton(
                  onPressed: () {
                    ProcessReportServices.insertProcessReport(
                            idReport: idReport,
                            message:
                                'Laporan diterima oleh estate cordinator ($name)')
                        .then((value) {
                      if (value == 'OKE') {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ProcessReportScreen(
                                  url: url,
                                  title: title,
                                  description: description,
                                  idReport: idReport,
                                  latitude: latitude,
                                  location: location,
                                  longitude: longitude,
                                  time: time,
                                )));
                      } else {
                        print('error');
                      }
                    });
                  },
                  child: Text(
                    'Terima Laporan',
                    style: TextStyle(fontSize: 16.sp, color: Colors.white),
                  ),
                  color: Color(0xff2094F3),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  List<String> explodeTitle() {
    List<String> titleParts = title.split(',');
    List<String> wantedParts = [titleParts.removeAt(0), titleParts.join("")];
    return wantedParts;
  }

  static void navigateTo(double lat, double lng) async {
    var uri = Uri.parse("google.navigation:q=$lat,$lng&mode=d");
    if (await canLaunch(uri.toString())) {
      await launch(uri.toString());
    } else {
      throw 'Could not launch ${uri.toString()}';
    }
  }
}
