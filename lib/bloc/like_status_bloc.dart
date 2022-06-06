import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LikeStatusState {
  Color colorButton;

  LikeStatusState({
    this.colorButton
  });
}  

class LikeStatusBloc extends Bloc<bool, LikeStatusState>{
  LikeStatusBloc(LikeStatusState initialState) : super(initialState);

  @override
  Stream<LikeStatusState> mapEventToState(bool event) async* {
    if(event == true) {
      yield LikeStatusState(colorButton: Colors.red);
    } else {
      yield LikeStatusState(colorButton: Colors.black);
    }
  }
  
}