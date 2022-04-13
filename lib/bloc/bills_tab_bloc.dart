import 'package:aplikasi_rw/model/bills_tab_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class BillTabColorBloc extends Bloc<int, Color> {
  BillTabColorBloc(Color initialState) : super(initialState);

  @override
  Stream<Color> mapEventToState(int event) async* {
    yield BillTabModel.tabs()[event].colorsAppBar;
  }
}