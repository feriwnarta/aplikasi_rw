import 'package:aplikasi_rw/services/cordinator/cordinator_report_services.dart';
import 'package:aplikasi_rw/utils/UserSecureStorage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReportCordinatorEvent {}

abstract class ReportCordinatorState {}

class ReportCordinatorUnitialized extends ReportCordinatorState {}

class ReportCordinatorStateProcess extends ReportCordinatorState {}

class ReportCordinatorEventRefresh extends ReportCordinatorEvent {}

class ReportCordinatorEventProcess extends ReportCordinatorEvent {}

class ReportCordinatorEventFinish extends ReportCordinatorEvent {}

class ReportCordinatorStateFinish extends ReportCordinatorState {}

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

class ReportCordinatorLoadedProcess extends ReportCordinatorState {
  List<CordinatorReportModel> listReport;
  bool isMaxReached;
  String idCordinator;

  ReportCordinatorLoadedProcess(
      {this.listReport, this.isMaxReached, this.idCordinator});

  // update max reached
  ReportCordinatorLoadedProcess copyWith(
      {List<ReportCordinatorLoaded> listReport,
      bool isMaxReached,
      String idCordinator}) {
    return ReportCordinatorLoadedProcess(
        listReport: listReport ?? this.listReport,
        isMaxReached: isMaxReached ?? this.isMaxReached,
        idCordinator: idCordinator ?? this.idCordinator);
  }
}

class ReportCordinatorLoadedFinish extends ReportCordinatorState {
  List<CordinatorReportModel> listReport;
  bool isMaxReached;
  String idCordinator;

  ReportCordinatorLoadedFinish(
      {this.listReport, this.isMaxReached, this.idCordinator});

  // update max reached
  ReportCordinatorLoadedFinish copyWith(
      {List<ReportCordinatorLoaded> listReport,
      bool isMaxReached,
      String idCordinator}) {
    return ReportCordinatorLoadedFinish(
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

    String idCordinator = await UserSecureStorage.getIdUser();

    if (event is ReportCordinatorEventRefresh) {
      listReport = await CordinatorReportServices.getReportCordinator(
          idCordinator, 0, 10);
      yield ReportCordinatorLoaded(
          listReport: listReport,
          isMaxReached: false,
          idCordinator: idCordinator);
    }

    if (state is ReportCordinatorUnitialized) {
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

class ReportCordinatorProcessBloc
    extends Bloc<ReportCordinatorEvent, ReportCordinatorState> {
  ReportCordinatorProcessBloc(ReportCordinatorState initialState)
      : super(initialState);

  @override
  Stream<ReportCordinatorState> mapEventToState(
      ReportCordinatorEvent event) async* {
    List<CordinatorReportModel> listReportProcess;
    String idCordinator = await UserSecureStorage.getIdUser();

    if (event is ReportCordinatorEventProcess) {
      listReportProcess =
          await CordinatorReportServices.getReportCordinatorProcess(
              idCordinator, 0, 10);
      yield ReportCordinatorLoadedProcess(
          listReport: listReportProcess,
          isMaxReached: false,
          idCordinator: idCordinator);
    }

    if (state is ReportCordinatorStateProcess) {
      listReportProcess =
          await CordinatorReportServices.getReportCordinatorProcess(
              idCordinator, 0, 10);
      yield ReportCordinatorLoadedProcess(
          listReport: listReportProcess,
          isMaxReached: false,
          idCordinator: idCordinator);
    } else {
      ReportCordinatorLoadedProcess reportLoaded =
          state as ReportCordinatorLoadedProcess;
      listReportProcess =
          await CordinatorReportServices.getReportCordinatorProcess(
              reportLoaded.idCordinator, reportLoaded.listReport.length, 10);
      yield (listReportProcess.isEmpty)
          ? reportLoaded.copyWith(
              isMaxReached: true, idCordinator: reportLoaded.idCordinator)
          : ReportCordinatorLoadedProcess(
              listReport: reportLoaded.listReport + listReportProcess,
              isMaxReached: false,
              idCordinator: reportLoaded.idCordinator);
    }
  }
}

class ReportCordinatorFinishBloc
    extends Bloc<ReportCordinatorEvent, ReportCordinatorState> {
  ReportCordinatorFinishBloc(ReportCordinatorState initialState)
      : super(initialState);

  @override
  Stream<ReportCordinatorState> mapEventToState(
      ReportCordinatorEvent event) async* {
    List<CordinatorReportModel> listReportFinish;

    String idCordinator = await UserSecureStorage.getIdUser();

    if (event is ReportCordinatorEventFinish) {
      listReportFinish =
          await CordinatorReportServices.getReportCordinatorFinish(
              idCordinator, 0, 10);
      yield ReportCordinatorLoadedFinish(
          listReport: listReportFinish,
          isMaxReached: false,
          idCordinator: idCordinator);
    }
    if (state is ReportCordinatorStateFinish) {
      listReportFinish =
          await CordinatorReportServices.getReportCordinatorFinish(
              idCordinator, 0, 10);
      yield ReportCordinatorLoadedFinish(
          listReport: listReportFinish,
          isMaxReached: false,
          idCordinator: idCordinator);
    } else {
      ReportCordinatorLoadedFinish reportLoaded =
          state as ReportCordinatorLoadedFinish;
      listReportFinish =
          await CordinatorReportServices.getReportCordinatorFinish(
              reportLoaded.idCordinator, reportLoaded.listReport.length, 10);
      yield (listReportFinish.isEmpty)
          ? reportLoaded.copyWith(
              isMaxReached: true, idCordinator: reportLoaded.idCordinator)
          : ReportCordinatorLoadedFinish(
              listReport: reportLoaded.listReport + listReportFinish,
              isMaxReached: false,
              idCordinator: reportLoaded.idCordinator);
    }
  }
}
