import 'package:aplikasi_rw/bloc/report_bloc.dart';
import 'package:aplikasi_rw/screen/report_screen2/add_report.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

enum SubMenu { Request, Complaint }

class SubMenuReport extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SubMenu menuRequest = SubMenu.Complaint;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Create Report',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        brightness: Brightness.light,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: RadioMenu(menuRequest: menuRequest),
      ),
    );
  }
}

class RadioMenu extends StatefulWidget {
  RadioMenu({
    Key key,
    @required SubMenu menuRequest,
  })  : menuRequest = menuRequest,
        super(key: key);

  SubMenu menuRequest;
  SubMenu menuComplaint = SubMenu.Complaint;

  Color colorBorderComplaint = Colors.grey[300];
  Color colorFontComplaint = Colors.black;
  Color colorBorderReq = Colors.grey[300];
  Color colorFontReq = Colors.black;

  ReportBloc bloc;

  @override
  _RadioMenuState createState() => _RadioMenuState();
}

class _RadioMenuState extends State<RadioMenu> {
  @override
  void initState() {
    super.initState();
    widget.menuRequest = SubMenu.Complaint;
    widget.colorBorderComplaint = Colors.blue;
    widget.colorFontComplaint = Colors.blue;
  }

  @override
  void dispose() {
    widget.bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    widget.bloc = BlocProvider.of<ReportBloc>(context);

    return Column(
      children: [
        radioButtonComplaint(),
        radioButtonReq(),
        SizedBox(
          height: 50.0.h,
        ),
        FlatButton(
          highlightColor: Colors.blue[100],
          padding: EdgeInsets.symmetric(horizontal: 40.0.w, vertical: 2.0.h),
          child: Text(
            'Next',
            style: TextStyle(color: Colors.white, fontSize: 13.0.sp),
          ),
          color: Colors.blue,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          onPressed: () {
            if (widget.menuRequest == SubMenu.Complaint) {
              Navigator.of(context)
                  .push(MaterialPageRoute(
                builder: (context) => AddReport(),
              ))
                  .then((value) {
                if (value == 'reload') {
                  widget.bloc.add(ReportEventRefresh());
                  Navigator.pop(context, 'reload');
                }
              });
            } else if (widget.menuRequest == SubMenu.Request) {}
          },
        )
      ],
    );
  }

  GestureDetector radioButtonComplaint() {
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.menuRequest = SubMenu.Complaint;
          widget.colorBorderComplaint = Colors.blue;
          widget.colorFontComplaint = Colors.blue;
          if (widget.colorFontReq == Colors.blue) {
            widget.colorFontReq = Colors.black;
            widget.colorBorderReq = Colors.grey[300];
          }
        });
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10).copyWith(top: 7),
        decoration: BoxDecoration(
            border: Border.all(color: widget.colorBorderComplaint),
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Radio(
                  groupValue: widget.menuRequest,
                  value: SubMenu.Complaint,
                  onChanged: (SubMenu value) {
                    setState(() {
                      widget.menuRequest = value;
                      widget.colorBorderComplaint = Colors.blue;
                      widget.colorFontComplaint = Colors.blue;
                      if (widget.colorFontReq == Colors.blue) {
                        widget.colorFontReq = Colors.black;
                        widget.colorBorderReq = Colors.grey[300];
                      }
                    });
                  },
                ),
                Text('Complaint',
                    style: TextStyle(
                        fontSize: 12.0.sp, color: widget.colorFontComplaint))
              ],
            ),
            Container(
                margin: EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  'Laporan ini di tunjukan untuk permasalahan yang terjadi di area lingkungan pribadi',
                  style: TextStyle(
                      fontSize: 12.0.sp, color: widget.colorFontComplaint),
                )),
            SizedBox(
              height: 2.5.h,
            )
          ],
        ),
      ),
    );
  }

  GestureDetector radioButtonReq() {
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.menuRequest = SubMenu.Request;
          widget.colorBorderReq = Colors.blue;
          widget.colorFontReq = Colors.blue;
          if (widget.colorFontReq == Colors.blue) {
            widget.colorFontComplaint = Colors.black;
            widget.colorBorderComplaint = Colors.grey[300];
          }
        });
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10).copyWith(top: 7),
        decoration: BoxDecoration(
            border: Border.all(color: widget.colorBorderReq),
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Radio(
                  groupValue: widget.menuRequest,
                  value: SubMenu.Request,
                  onChanged: (SubMenu value) {
                    setState(() {
                      widget.menuRequest = value;
                      widget.colorBorderReq = Colors.blue;
                      widget.colorFontReq = Colors.blue;
                      if (widget.colorFontComplaint == Colors.blue) {
                        widget.colorBorderComplaint = Colors.black;
                        widget.colorFontComplaint = Colors.grey[300];
                      }
                    });
                  },
                ),
                Text('Request',
                    style: TextStyle(
                        fontSize: 12.0.sp, color: widget.colorFontReq))
              ],
            ),
            Container(
                margin: EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  'Laporan ini ditunjukan untuk permasalahan yang terjadi di area lingkungan RW 05',
                  style:
                      TextStyle(fontSize: 12.0.sp, color: widget.colorFontReq),
                )),
            SizedBox(
              height: 2.5.h,
            )
          ],
        ),
      ),
    );
  }
}
