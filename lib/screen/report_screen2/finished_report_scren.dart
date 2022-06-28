import 'package:aplikasi_rw/services/report_finished_services.dart';
import 'package:flutter/material.dart';

class FinishedReportScreen extends StatelessWidget {
  List<ReportFinishedModel> report;

  FinishedReportScreen({this.report});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Report Finished'),
      ),
      body: Text(
        report[0].listReportFinish[0].noTicket
      ),
    );
  }
}
