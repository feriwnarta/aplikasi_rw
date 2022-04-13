import 'package:aplikasi_rw/bloc/bills_tab_bloc.dart';
import 'package:aplikasi_rw/model/bills_tab_model.dart';
import 'package:aplikasi_rw/screen/bills_screen/bills_reguler_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BillScreen extends StatefulWidget {
  @override
  State<BillScreen> createState() => _BillScreenState();
}

class _BillScreenState extends State<BillScreen>
    with SingleTickerProviderStateMixin {
  double mediaSizeHeight;
  TabController controller;

  // bloc
  BillTabColorBloc bloc;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: BillTabModel.tabs().length, vsync: this);
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
    mediaSizeHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;

    return BlocBuilder<BillTabColorBloc, Color>(
      builder: (context, state) => Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(mediaSizeHeight * 0.18),
            child: AppBar(
              brightness: Brightness.light,
              backgroundColor: state,
              flexibleSpace: Container(
                padding: EdgeInsets.only(bottom: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 20, top: 10),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Bills',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 32,
                                  fontFamily: 'poppins'),
                            ),
                            Text(
                              'citizen dues',
                              style: TextStyle(
                                  color: Colors.blue[900],
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ]),
                    ),
                    Divider(
                      thickness: 1,
                    )
                  ],
                ),
              ),
              bottom: TabBar(
                  controller: controller,
                  labelColor: Colors.black,
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
