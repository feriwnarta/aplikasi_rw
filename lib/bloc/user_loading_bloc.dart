import 'package:aplikasi_rw/model/contractor_model.dart';
import 'package:aplikasi_rw/model/user_model.dart';
import 'package:aplikasi_rw/services/get_data_user_services.dart';
import 'package:aplikasi_rw/utils/UserSecureStorage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../services/get_data_contractor_services.dart';

class UserLoadingEvent {}

abstract class UserLoadingState {}

class UserLoadingRefresh extends UserLoadingEvent {}

class UserLoadingUnitialized extends UserLoadingState {}

class UserSuccesLogin extends UserLoadingState {}

class UserNotLogin extends UserLoadingState {}

class UserLogin extends UserLoadingEvent {}

class UserLoadingInitialized extends UserLoadingState {
  String idUser, username, urlProfile;

  UserLoadingInitialized({this.idUser, this.urlProfile, this.username});
}

class ContractorInitialized extends UserLoadingState {
  String idContractor, nameContractor;

  ContractorInitialized({this.idContractor, this.nameContractor});
}

class UserLoadingBloc extends Bloc<UserLoadingEvent, UserLoadingState> {
  UserLoadingBloc(UserLoadingState initialState) : super(initialState);
  @override
  Stream<UserLoadingState> mapEventToState(UserLoadingEvent event) async* {
    if (event is UserLoadingRefresh) {
      yield UserLoadingUnitialized();
    }
    String status = await UserSecureStorage.getStatus();
    String user = await UserSecureStorage.getIdUser();

    if (status == null && user == null) {
      yield (UserNotLogin());
    }

    if (status != null) {
      if (status == 'user') {
        if (state is UserLoadingUnitialized) {
          String idUser = await UserSecureStorage.getIdUser();
          if (idUser == null) {
            yield UserNotLogin();
          } else {
            UserModel userModel = await GetDataUserServices.getDataUser(idUser);
            String username = userModel.username;
            String urlProfile = userModel.urlProfile;
            yield UserLoadingInitialized(
                idUser: idUser, urlProfile: urlProfile, username: username);
          }
        } else {
          String idUser = await UserSecureStorage.getIdUser();
          UserModel userModel = await GetDataUserServices.getDataUser(idUser);
          String username = userModel.username;
          String urlProfile = userModel.urlProfile;
          yield UserLoadingInitialized(
              idUser: idUser, urlProfile: urlProfile, username: username);
        }
      } else if (status == 'kontraktor') {
        if (state is UserLoadingUnitialized) {
          String idUser = await UserSecureStorage.getIdUser();
          if (idUser == null) {
            yield UserNotLogin();
          } else {
            ContractorModel model =
                await GetDataContractorService.getDataContractor(idUser);
            yield (ContractorInitialized(
                idContractor: model.idContractor,
                nameContractor: model.nameContractor));
            // String username = userModel.username;
            // String urlProfile = userModel.urlProfile;
            // yield UserLoadingInitialized(
            //     idUser: idUser, urlProfile: urlProfile, username: username);
          }
        } else {
          // String idUser = await UserSecureStorage.getIdUser();
          // UserModel userModel = await GetDataUserServices.getDataUser(idUser);
          // String username = userModel.username;
          // String urlProfile = userModel.urlProfile;
          // yield UserLoadingInitialized(
          //     idUser: idUser, urlProfile: urlProfile, username: username);
        }
      }
    }
  }
}
