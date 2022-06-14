import 'package:aplikasi_rw/bloc/bills_tab_bloc.dart';
import 'package:aplikasi_rw/model/bills_tab_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class BillScreen extends StatefulWidget {
  @override
  State<BillScreen> createState() => _BillScreenState();
}

class _BillScreenState extends State<BillScreen>
    with SingleTickerProviderStateMixin {
  TabController controller;

  // bloc
  BillTabColorBloc bloc;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: BillTabModel.tabs().length, vsync: this,);
    bloc = BlocProvider.of<BillTabColorBloc>(context);
    controller.addListener(() {
      bloc.add(controller.index);
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<BillTabColorBloc, TabState>(
      builder: (context, state) => Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(18.0.h),
            child: AppBar(
              brightness: Brightness.light,
              backgroundColor: state.colorAppBar,
              flexibleSpace: Container(
                padding: EdgeInsets.only(bottom: 2.5.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 5.0.w, bottom: 2.0.h),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Event',
                              style: TextStyle(
                                  color: state.colorsText,
                                  fontSize: 26.0.sp,
                                  fontFamily: 'poppins'),
                            ),
                            Text(
                              'Event Citizen',
                              style: TextStyle(
                                  color: state.colorsText,
                                  fontSize: 12.0.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                          ]),
                    ),
                  ],
                ),
              ),
              bottom: TabBar(                
                  labelPadding: EdgeInsets.symmetric(horizontal: 1.0.w),
                  controller: controller,
                  labelColor: state.colorsText,
                  labelStyle: TextStyle(fontWeight: FontWeight.bold),
                  tabs: BillTabModel.tabs().map<Widget>((e) => e.tab).toList()),
            ),
          ),
          body: TabBarView(
            controller: controller,
            children: BillTabModel.tabs().map<Widget>((e) => e.screen).toList(),
          )),
    );
  }
}
