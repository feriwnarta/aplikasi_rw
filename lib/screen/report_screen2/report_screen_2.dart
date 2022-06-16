import 'package:aplikasi_rw/bloc/report_bloc.dart';
import 'package:aplikasi_rw/screen/report_screen2/card_report_screen.dart';
import 'package:aplikasi_rw/screen/report_screen2/add_report.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

//ignore: must_be_immutable
class ReportScreen2 extends StatefulWidget {
  @override
  State<ReportScreen2> createState() => _ReportScreen2State();
}

class _ReportScreen2State extends State<ReportScreen2> {
  // scroll controller
  ScrollController controller = ScrollController();
  ReportBloc bloc;

  // refresh key
  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();
  TextEditingController controllerSearch = TextEditingController();

  void onScroll() {
    if (controller.position.haveDimensions) {
      if (controller.position.maxScrollExtent == controller.position.pixels) {
        bloc.add(ReportEvent2());
      }
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bloc = BlocProvider.of<ReportBloc>(context);
    controller.addListener(onScroll);

    return Stack(children: [
      Scaffold(
        resizeToAvoidBottomInset: false,
        resizeToAvoidBottomPadding: false,
        body: SafeArea(
          child: NestedScrollView(
              controller: controller,
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                    SliverAppBar(
                      backgroundColor: Colors.white,
                      expandedHeight: 17.0.h,
                      pinned: true,
                      bottom: PreferredSize(
                        preferredSize: const Size.fromHeight(0),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 1.5.w),
                          height: 6.7.h,
                          child: TextField(
                            maxLines: 1,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(top: 1.2.h),
                                prefixIcon: Icon(
                                  Icons.search,
                                  size: 2.5.h,
                                ),
                                fillColor: Colors.grey[50],
                                filled: true,
                                hintText: 'Ticket Numbers',
                                hintStyle: TextStyle(
                                  fontSize: 11.0.sp,
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                        BorderSide(color: Colors.grey[300])),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                        BorderSide(color: Colors.grey[300])),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),
                          ),
                        ),
                      ),
                      flexibleSpace: FlexibleSpaceBar(
                        background: Container(
                          margin: EdgeInsets.only(bottom: 7.0.h, left: 3.0.w),
                          child: Row(
                            children: [
                              Image(
                                width: 25.0.w,
                                image: AssetImage('assets/img/logo.png'),
                                fit: BoxFit.cover,
                                repeat: ImageRepeat.noRepeat,
                              ),
                              SizedBox(
                                width: 3.0.w,
                              ),
                              Text(
                                'NextG-Report',
                                style: TextStyle(
                                    fontSize: 13.0.sp,
                                    color: Colors.black,
                                    fontFamily: 'poppins'),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
              body: RefreshIndicator(
                key: refreshIndicatorKey,
                onRefresh: () async => loadReport(),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Divider(
                        color: Colors.black,
                        height: 3.0.h,
                        thickness: 0.3,
                      ),
                      BlocBuilder<ReportBloc, ReportState2>(
                        builder: (context, state) {
                          if (state is ReportUnitialized) {
                            return ListView.builder(
                              shrinkWrap: true,
                              itemCount: 5,
                              itemBuilder: (context, index) => ShimmerReport(),
                            );
                          } else {
                            ReportLoaded reportLoaded = state as ReportLoaded;
                            return ListView.builder(
                              physics: ScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: (reportLoaded.isMaxReached)
                                  ? reportLoaded.listReport.length
                                  : reportLoaded.listReport.length + 1,
                              itemBuilder: (context, index) => (index <
                                      reportLoaded.listReport.length)
                                  ? CardReportScreen(
                                      urlImageReport: reportLoaded
                                          .listReport[index].urlImageReport,
                                      description: reportLoaded
                                          .listReport[index].description,
                                      location: reportLoaded
                                          .listReport[index].location,
                                      noTicket: reportLoaded
                                          .listReport[index].noTicket,
                                      time: reportLoaded.listReport[index].time,
                                      status:
                                          reportLoaded.listReport[index].status,
                                      additionalInformation: reportLoaded
                                          .listReport[index]
                                          .additionalInformation,
                                      category: reportLoaded
                                          .listReport[index].category,
                                      categoryIcon: reportLoaded
                                          .listReport[index].iconCategory,
                                      latitude: reportLoaded
                                          .listReport[index].latitude,
                                      longitude: reportLoaded
                                          .listReport[index].longitude,
                                      idReport: reportLoaded
                                          .listReport[index].idReport,
                                      idUser:
                                          reportLoaded.listReport[index].idUser,
                                      // additionalInformation: ,
                                    )
                                  : (index == reportLoaded.listReport.length)
                                      ? Container()
                                      : Container(
                                          margin: EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: Center(
                                            child: SizedBox(
                                              width: 30,
                                              height: 30,
                                              child:
                                                  CircularProgressIndicator(),
                                            ),
                                          ),
                                        ),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              )),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
            size: 4.0.h,
          ),
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(
              builder: (context) => AddReport(),
            ))
                .then((value) {
              if (value == 'reload') {
                bloc.add(ReportEventRefresh());
              }
            });
          },
        ),
      ),
      Container()
    ]);
  }

  Future loadReport() async {
    await Future.delayed(Duration(seconds: 2));
    bloc.add(ReportEventRefresh());
  }
}

class ShimmerReport extends StatelessWidget {
  const ShimmerReport({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 2.0.h),
            Shimmer.fromColors(
                baseColor: Colors.grey[300],
                highlightColor: Colors.grey[200],
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10)),
                  width: 25.0.w,
                  height: 13.0.h,
                  margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                )),
          ],
        ),
        // shimmer title
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 1.0.h),
            Shimmer.fromColors(
                baseColor: Colors.grey[300],
                highlightColor: Colors.grey[200],
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10)),
                  width: 30.0.w,
                  height: 2.0.h,
                )),
            SizedBox(
              height: 1.0.h,
            ),
            Shimmer.fromColors(
                baseColor: Colors.grey[300],
                highlightColor: Colors.grey[200],
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10)),
                  width: 60.0.w,
                  height: 2.0.h,
                )),
            SizedBox(
              height: 1.0.h,
            ),
            Shimmer.fromColors(
                baseColor: Colors.grey[300],
                highlightColor: Colors.grey[200],
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10)),
                  width: 30.0.w,
                  height: 2.0.h,
                )),
            SizedBox(
              height: 1.0.h,
            ),
            Shimmer.fromColors(
                baseColor: Colors.grey[300],
                highlightColor: Colors.grey[200],
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10)),
                  width: 40.0.w,
                  height: 2.0.h,
                )),
            Row(
              children: [
                SizedBox(width: 46.0.w),
                Shimmer.fromColors(
                    baseColor: Colors.grey[300],
                    highlightColor: Colors.grey[200],
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(7)),
                      width: 17.0.w,
                      height: 3.0.h,
                    )),
              ],
            ),
          ],
        )
      ],
    );
  }
}
