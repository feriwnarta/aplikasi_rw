import 'package:flutter_bloc/flutter_bloc.dart';

class LoginEvent {
  String idUser;
  String profileImage;
  LoginEvent({
    this.idUser, this.profileImage
  });
}

class LoginState {
  String idUser;
  bool isLogin;
  String profileImage;
  LoginState({this.idUser, this.isLogin, this.profileImage});
}

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc(LoginState initialState) : super(initialState);

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event.idUser.isEmpty && event.idUser == null) {
      yield LoginState(idUser: '0', isLogin: false);
    } else {
      yield LoginState(idUser: event.idUser, isLogin: true, profileImage: event.profileImage);
    }
  }
}
