import 'package:aplikasi_rw/bloc/report_screen_bloc.dart';
import 'package:aplikasi_rw/model/card_laporan_warga_model.dart';
import 'package:aplikasi_rw/screen/support_screen/create_report_screen.dart';
import 'package:aplikasi_rw/screen/support_screen/card_laporan_warga.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

//ignore: must_be_immutable
class ReportScreen extends StatelessWidget {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  double mediaSizeHeight;
  double mediaSizeWidth;
  bool isVisibility = true;

  ReportScreen(this.scaffoldKey);

  // bloc
  ReportScreenBloc blocScreenReport;

  @override
  Widget build(BuildContext context) {
    blocScreenReport = BlocProvider.of<ReportScreenBloc>(context);
    mediaSizeHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    mediaSizeWidth = MediaQuery.of(context).size.height;

    return BlocBuilder<ReportScreenBloc, ReportState>(
      builder: (context, state) => Scaffold(
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
                        'Report',
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
                    Material(
                      elevation: 5,
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        padding: EdgeInsets.only(left: 15, right: 15),
                        width: mediaSizeWidth * 0.46,
                        height: mediaSizeHeight * 0.07,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(20),
                            splashColor: Colors.indigo,
                            onTap: () {
                              if (isVisibility) {
                                blocScreenReport
                                    .add(ReportEvent(isVisibility: false));
                                isVisibility = false;
                              } else {
                                blocScreenReport
                                    .add(ReportEvent(isVisibility: true));
                                isVisibility = true;
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'My Report',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontFamily: 'poppins'),
                                ),
                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(right: 10),
                                          child: Text(
                                            CardLaporanWargaModel
                                                .getAllLaporan.length
                                                .toString(),
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18),
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
                                        Material(
                                            color: Colors.transparent,
                                            child: SizedBox(
                                              height: 50,
                                              width: mediaSizeWidth * 0.045,
                                              child: InkWell(
                                                splashColor: Colors.indigo,
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                child: AnimatedSwitcher(
                                                    duration: Duration(
                                                        milliseconds: 900),
                                                    child: (state.isVisibility)
                                                        ? Icon(
                                                            FontAwesomeIcons
                                                                .angleUp,
                                                            color: Colors.white,
                                                          )
                                                        : Icon(
                                                            FontAwesomeIcons
                                                                .angleDown,
                                                            color: Colors.white,
                                                          )),
                                                onTap: () {
                                                  if (isVisibility) {
                                                    blocScreenReport.add(
                                                        ReportEvent(
                                                            isVisibility:
                                                                false));

                                                    isVisibility = false;
                                                  } else {
                                                    blocScreenReport.add(
                                                        ReportEvent(
                                                            isVisibility:
                                                                true));

                                                    isVisibility = true;
                                                  }
                                                },
                                              ),
                                            ))
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                buildVisibilityQuickGuide(),
                buildVisibilityHeaderCard(),
                buildVisibilityCardLaporan(),
              ],
            )
          ],
        ),
        floatingActionButton: buildSizeBoxFloatingActionButton(context),
      ),
    );
  }

  BlocBuilder buildVisibilityCardLaporan() {
    return BlocBuilder<ReportScreenBloc, ReportState>(
      builder: (context, state) => Visibility(
        visible: state.isVisibility,
        child: ListView.builder(
          physics: ScrollPhysics(),
          shrinkWrap: true,
          reverse: true,
          itemCount: CardLaporanWargaModel.getAllLaporan.length,
          itemBuilder: (context, index) {
            return CardLaporanWarga(
              // 7 digit kode
              noTicket: CardLaporanWargaModel.getAllLaporan[index].noTicket,
              judul: CardLaporanWargaModel.getAllLaporan[index].judul,
              status: CardLaporanWargaModel.getAllLaporan[index].status,
            );
          },
        ),
      ),
    );
  }

  Visibility buildVisibilityHeaderCard() {
    return Visibility(
      visible: true,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'No tickets',
              style: TextStyle(fontSize: 10, color: Colors.grey),
            ),
            Text(
              'Title',
              style: TextStyle(fontSize: 10, color: Colors.grey),
            ),
            Text(
              'Status',
              style: TextStyle(fontSize: 10, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  BlocBuilder buildVisibilityQuickGuide() {
    return BlocBuilder<ReportScreenBloc, ReportState>(
      builder: (context, state) => Visibility(
        visible: state.isVisibileGuide,
        child: Material(
          elevation: 5,
          borderRadius: BorderRadius.circular(20),
          child: Container(
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
                    Material(
                        color: Colors.transparent,
                        child: SizedBox(
                          height: 35,
                          width: mediaSizeWidth * 0.045,
                          child: InkWell(
                            splashColor: Colors.indigo,
                            borderRadius: BorderRadius.circular(20),
                            child: Icon(
                              Icons.clear_rounded,
                              color: Colors.white,
                            ),
                            onTap: () {
                              blocScreenReport
                                  .add(ReportEvent(isVisibileGuide: false));
                            },
                          ),
                        ))
                  ],
                ),
                Divider(
                  color: Colors.white,
                  thickness: 1.2,
                ),
                Column(
                  children: [
                    Text(
                      'Ini adalah bagian untuk membuat laporan, silahkan klik tombol (+) masukan judul, dan isi laporan beserta gambar kemudian laporan akan segera kami proses.',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 10,
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  SizedBox buildSizeBoxFloatingActionButton(BuildContext context) {
    return SizedBox(
      height: 50,
      child: FittedBox(
        child: FloatingActionButton(
          child: Icon(
            Icons.add,
            size: 32,
          ),
          backgroundColor: Colors.lightBlue,
          splashColor: Colors.indigo,
          onPressed: () {
            showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (context) {
                return CreateReportScreen();
              },
            );
          },
        ),
      ),
    );
  }
}
