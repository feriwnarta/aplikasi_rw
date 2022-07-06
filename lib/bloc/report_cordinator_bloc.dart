import 'package:aplikasi_rw/model/ReportModel.dart';
import 'package:aplikasi_rw/services/cordinator/cordinator_report_services.dart';
import 'package:aplikasi_rw/services/report_services.dart';
import 'package:aplikasi_rw/utils/UserSecureStorage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReportCordinatorEvent {}

abstract class ReportCordinatorState {}

class ReportCordinatorUnitialized extends ReportCordinatorState {}

class ReportCordinatorEventRefresh extends ReportCordinatorEvent {}

class ReportCordinatorLoaded extends ReportCordinatorState {
  List<CordinatorReportModel> listReport;
  bool isMaxReached;
  String idCordinator;

  ReportCordinatorLoaded(
      {this.listReport, this.isMaxReached, this.idCordinator});

  // update max reached
  ReportCordinatorLoaded copyWith(
      {List<ReportCordinatorLoaded> listReport,
      bool isMaxReached,
      String idCordinator}) {
    return ReportCordinatorLoaded(
        listReport: listReport ?? this.listReport,
        isMaxReached: isMaxReached ?? this.isMaxReached,
        idCordinator: idCordinator ?? this.idCordinator);
  }
}

class ReportCordinatorBloc
    extends Bloc<ReportCordinatorEvent, ReportCordinatorState> {
  ReportCordinatorBloc(ReportCordinatorState initialState)
      : super(initialState);
  @override
  Stream<ReportCordinatorState> mapEventToState(
      ReportCordinatorEvent event) async* {
    List<CordinatorReportModel> listReport;

    if (event is ReportCordinatorEventRefresh) {
      yield ReportCordinatorUnitialized();
    }

    if (state is ReportCordinatorUnitialized) {
      String idCordinator = await UserSecureStorage.getIdUser();
      listReport = await CordinatorReportServices.getReportCordinator(
          idCordinator, 0, 10);
      yield ReportCordinatorLoaded(
          listReport: listReport,
          isMaxReached: false,
          idCordinator: idCordinator);
    } else {
      ReportCordinatorLoaded reportLoaded = state as ReportCordinatorLoaded;
      listReport = await CordinatorReportServices.getReportCordinator(
          reportLoaded.idCordinator, reportLoaded.listReport.length, 10);
      yield (listReport.isEmpty)
          ? reportLoaded.copyWith(
              isMaxReached: true, idCordinator: reportLoaded.idCordinator)
          : ReportCordinatorLoaded(
              listReport: reportLoaded.listReport + listReport,
              isMaxReached: false,
              idCordinator: reportLoaded.idCordinator);
    }
  }
}
