import 'package:aplikasi_rw/model/bills_tab_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class TabState {
  Color colorAppBar, colorsText;

  TabState({this.colorAppBar, this.colorsText});
}

class BillTabColorBloc extends Bloc<int, TabState> {
  BillTabColorBloc(TabState initialState) : super(initialState);

  @override
  Stream<TabState> mapEventToState(int event) async* {
    yield TabState(colorAppBar:BillTabModel.tabs()[event].colorsAppBar, colorsText: BillTabModel.tabs()[event].colorsText);
  }
  

  
}