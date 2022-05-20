import 'package:aplikasi_rw/model/ReportModel.dart';
import 'package:aplikasi_rw/services/report_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReportEvent2 {}

abstract class ReportState2 {}

class ReportUnitialized extends ReportState2 {}

class ReportLoaded extends ReportState2 {
  List<ReportModel> listReport;
  bool isMaxReached;

  ReportLoaded({this.listReport, this.isMaxReached});

  // update max reached
  ReportLoaded copyWith({List<ReportModel> listReport, bool isMaxReached}) {
    return ReportLoaded(
        listReport: listReport ?? this.listReport,
        isMaxReached: isMaxReached ?? this.isMaxReached);
  }
}

class ReportBloc extends Bloc<ReportEvent2, ReportState2> {
  ReportBloc(ReportState2 initialState) : super(initialState);

  @override
  Stream<ReportState2> mapEventToState(ReportEvent2 event) async* {
    List<ReportModel> listReport;

    if (state is ReportUnitialized) {
      listReport = await ReportServices.getDataApi(0, 10);
      yield ReportLoaded(listReport: listReport, isMaxReached: false);
    } else {
      ReportLoaded reportLoaded = state as ReportLoaded;
      listReport =
          await ReportServices.getDataApi(reportLoaded.listReport.length, 10);
      yield (listReport.isEmpty)
          ? reportLoaded.copyWith(isMaxReached: true)
          : ReportLoaded(
              listReport: reportLoaded.listReport + listReport,
              isMaxReached: false);
    }
  }
}
