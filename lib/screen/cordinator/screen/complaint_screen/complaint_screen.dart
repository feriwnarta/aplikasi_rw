import 'package:aplikasi_rw/bloc/report_cordinator_bloc.dart';
import 'package:aplikasi_rw/screen/cordinator/screen/complaint_screen/detail_report_screen.dart';
import 'package:aplikasi_rw/screen/cordinator/screen/complaint_screen/process_report.dart';
import 'package:aplikasi_rw/server-app.dart';
import 'package:aplikasi_rw/services/cordinator/cordinator_report_services.dart';
import 'package:aplikasi_rw/services/cordinator/process_report_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class ComplaintScreen extends StatefulWidget {
  ComplaintScreen({Key key, this.name}) : super(key: key);
  String name;

  @override
  _ComplaintScreenState createState() => _ComplaintScreenState();
}

class _ComplaintScreenState extends State<ComplaintScreen>
    with AutomaticKeepAliveClientMixin<ComplaintScreen> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Color(0xffE0E0E0),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(104.h),
          child: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Color(0xFF2094F3),
            flexibleSpace: Container(
              padding: EdgeInsets.only(top: 48.h, left: 16.w, right: 16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Complaint',
                        style: TextStyle(
                            fontFamily: 'inter',
                            fontSize: 19.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                      SizedBox(height: 4.h),
                    ],
                  ),
                  InkWell(
                      splashColor: Colors.white,
                      borderRadius: BorderRadius.circular(200),
                      radius: 15.h,
                      onTap: () {},
                      child: SizedBox(
                        height: 20.h,
                        child: IconButton(
                            splashRadius: 15.h,
                            icon: SvgPicture.asset(
                                'assets/img/image-svg/search.svg'),
                            padding: EdgeInsets.zero,
                            onPressed: () {}),
                      )),
                ],
              ),
            ),
            bottom: TabBar(
              indicatorColor: Colors.white,
              indicatorSize: TabBarIndicatorSize.label,
              labelStyle: TextStyle(fontSize: 14.sp),
              tabs: [
                Tab(
                  text: 'Complaint',
                ),
                Tab(
                  text: 'Proses',
                ),
                Tab(text: 'Selesai'),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            CardReport(
              name: widget.name,
            ),
            Container(),
            Container(),
          ],
        ),
      ),
    );
  }
}

class CardReport extends StatelessWidget {
  CardReport({Key key, this.name}) : super(key: key);

  String name;
  ReportCordinatorBloc bloc;
  final ScrollController controller = ScrollController();
  void onScroll() {
    if (controller.position.maxScrollExtent == controller.position.pixels) {
      bloc.add(ReportCordinatorEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    bloc = BlocProvider.of<ReportCordinatorBloc>(context);
    controller.addListener(onScroll);

    return Container(
      child: BlocBuilder<ReportCordinatorBloc, ReportCordinatorState>(
          builder: (context, state) {
        if (state is ReportCordinatorUnitialized) {
          return Center(
            child: SizedBox(
                height: 30, width: 30, child: CircularProgressIndicator()),
          );
        } else if (state is ReportCordinatorLoaded) {
          ReportCordinatorLoaded loaded = state as ReportCordinatorLoaded;
          return ListView.builder(
              controller: controller,
              itemCount: (loaded.isMaxReached)
                  ? loaded.listReport.length + 1
                  : loaded.listReport.length + 1,
              // itemCount: loaded.listReport.length,
              itemBuilder: (context, index) =>
                  (index < loaded.listReport.length)
                      ? CardListReport(
                          description: loaded.listReport[index].description,
                          location: loaded.listReport[index].address,
                          time: loaded.listReport[index].time,
                          title: loaded.listReport[index].title,
                          url:
                              '${ServerApp.url}${loaded.listReport[index].urlImage}',
                          idReport: loaded.listReport[index].idReport,
                          latitude: loaded.listReport[index].latitude,
                          longitude: loaded.listReport[index].longitude,
                          name: name,
                        )
                      : (index == loaded.listReport.length)
                          ? Center(child: Text('Tidak ada laporan lagi'))
                          : Center(
                              child: SizedBox(
                                height: 30,
                                width: 30,
                                child: CircularProgressIndicator(
                                  strokeWidth: 1.5,
                                ),
                              ),
                            ));
        } else {
          return Container();
        }
      }),
    );
  }
}

class CardListReport extends StatelessWidget {
  CardListReport(
      {Key key,
      this.url,
      this.title,
      this.description,
      this.location,
      this.time,
      this.idReport,
      this.latitude,
      this.name,
      this.longitude})
      : super(key: key);

  String url,
      title,
      description,
      location,
      time,
      latitude,
      longitude,
      idReport,
      name;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ProcessReportServices.checkExistProcess(idReport).then((value) {
          if (value == 'FALSE') {
            print(value);
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
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => DetailReportScreen(
                  description: description,
                  idReport: idReport,
                  latitude: latitude,
                  location: location,
                  longitude: longitude,
                  time: time,
                  title: title,
                  url: url,
                  name: name),
            ));
          }
        });
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 2.h),
        color: Colors.white,
        height: 120.h,
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Image.network(
                  url,
                  height: 70.h,
                  width: 70.w,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 16.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      width: 190.w,
                      child: Text(
                        title,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 16),
                      )),
                  SizedBox(
                    width: 180.w,
                    height: 51.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SvgPicture.asset(
                            'assets/img/image-svg/location-marker.svg'),
                        SizedBox(width: 4.w),
                        Expanded(
                          child: Text(
                            location,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 14, color: Color(0xff757575)),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(width: 3.w),
              Text(
                time,
                style: TextStyle(fontSize: 12, color: Color(0xff757575)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
