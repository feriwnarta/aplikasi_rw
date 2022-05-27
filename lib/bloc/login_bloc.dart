import 'package:flutter_bloc/flutter_bloc.dart';

class LoginEvent {
  String _idUser;
  LoginEvent(this._idUser);
}

class LoginState {
  String idUser;
  bool isLogin;
  LoginState({this.idUser, this.isLogin});
}

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc(LoginState initialState) : super(initialState);

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event._idUser.isEmpty && event._idUser == null) {
      yield LoginState(idUser: '0', isLogin: false);
    } else {
      yield LoginState(idUser: event._idUser, isLogin: true);
    }
  }
}
