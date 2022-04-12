import 'package:aplikasi_rw/model/status_user_model.dart';
import 'package:aplikasi_rw/services/status_user_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StatusUserEvent {}

abstract class StatusUserState {}

class StatusUserUnitialized extends StatusUserState {}

class StatusUserLoaded extends StatusUserState {
  List<StatusUserModel> listStatusUser;
  bool isMaxReached;

  StatusUserLoaded({this.listStatusUser, this.isMaxReached});

  // update max reached
  StatusUserLoaded copyWith({List<StatusUserModel> listStatusUser, bool isMaxReached}) {
    return StatusUserLoaded(
        listStatusUser: listStatusUser ?? this.listStatusUser,
        isMaxReached: isMaxReached ?? this.isMaxReached);
  }
}

class StatusUserBloc extends Bloc<StatusUserEvent, StatusUserState> {
  StatusUserBloc(StatusUserState initialState) : super(initialState);

  @override
  Stream<StatusUserState> mapEventToState(StatusUserEvent event) async* {
    List<StatusUserModel> listStatusUser;

    if(state is StatusUserUnitialized) {
      listStatusUser = await StatusUserServices.getDataApi(0, 10);
      yield StatusUserLoaded(
        listStatusUser: listStatusUser,
        isMaxReached: false
      );

    } else {
      StatusUserLoaded statusLoaded = state as StatusUserLoaded;
      listStatusUser = await StatusUserServices.getDataApi(statusLoaded.listStatusUser.length, 10);
      yield (listStatusUser.isEmpty) ? statusLoaded.copyWith(isMaxReached: true) 
      : StatusUserLoaded(listStatusUser: statusLoaded.listStatusUser + listStatusUser, isMaxReached: false);
    }
  }
  
}
