import 'package:aplikasi_rw/screen/cordinator/screen/complaint_screen/complaint_screen.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

//ignore: must_be_immutable
class HomeScreenCordinator extends StatelessWidget {
  String name;

  HomeScreenCordinator({this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(104.h),
        child: AppBar(
          // title: Text('Contractor'),
          backgroundColor: Color(0xFF2094F3),
          flexibleSpace: Container(
            padding: EdgeInsets.only(top: 48.h, left: 16.w, right: 16.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hi, $name',
                      style: TextStyle(
                          fontFamily: 'inter',
                          fontSize: 19.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'Sudahkah cek laporan hari ini ?',
                      style: TextStyle(
                          fontFamily: 'inter',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.white),
                    )
                  ],
                ),
                // SizedBox(
                //   height: 20.h,
                //   child: IconButton(
                //       splashRadius: 15.h,
                //       icon: SvgPicture.asset('assets/img/image-svg/bell.svg'),
                //       padding: EdgeInsets.zero,
                //       onPressed: () {}),
                // )
                InkWell(
                  splashColor: Colors.white,
                  borderRadius: BorderRadius.circular(200),
                  radius: 15.h,
                  onTap: () {},
                  child: Badge(
                    badgeColor: Colors.red,
                    // showBadge: () ? true : false,
                    badgeContent: Text(
                      '0',
                      style: TextStyle(color: Colors.white),
                    ),
                    position: BadgePosition.topEnd(top: -15, end: -10),
                    child: SvgPicture.asset('assets/img/image-svg/bell.svg'),
                    animationType: BadgeAnimationType.scale,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
          child: Container(
              child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 56.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ButtonIconCordinator(
                asset: 'assets/img/image-svg/Group 4.svg',
                title: 'Complaint',
                navigator: ComplaintScreen(
                  name: name,
                ),
              ),
              SizedBox(width: 44.w),
              ButtonIconCordinator(
                asset: 'assets/img/image-svg/Group 5.svg',
                title: 'Request',
              ),
              SizedBox(width: 44.w),
              ButtonIconCordinator(
                asset: 'assets/img/image-svg/Group 6.svg',
                title: 'Laporan',
              ),
            ],
          ),
          SizedBox(height: 24.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ButtonIconCordinator(
                asset: 'assets/img/image-svg/Group 7.svg',
                title: 'Absensi',
              ),
              SizedBox(
                width: 124.w,
              ),
              SizedBox(
                width: 124.w,
              ),
            ],
          ),
        ],
      ))),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFF2094F3),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        iconSize: 16.0.w,
        items: [
          BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/img/image-svg/home.svg'),
              label: ''),
          BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/img/image-svg/user.svg'),
              label: ''),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: SvgPicture.asset('assets/img/image-svg/button_absen.svg'),
        onPressed: () {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

//ignore: must_be_immutable
class ButtonIconCordinator extends StatelessWidget {
  ButtonIconCordinator({Key key, this.asset, this.title, this.navigator})
      : super(key: key);
  String asset, title;
  Widget navigator;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(children: [
          Center(
              child: Container(
                  height: 80.w, width: 80.w, child: SvgPicture.asset(asset))),
          Center(
            child: Material(
                color: Colors.transparent,
                child: SizedBox(
                  height: 80.w,
                  width: 80.w,
                  child: new InkWell(
                    borderRadius: BorderRadius.circular(5),
                    splashColor: Colors.grey[100].withOpacity(0.5),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => navigator,
                      ));
                    },
                  ),
                )),
          )
        ]),
        SizedBox(height: 8.h),
        Container(
          width: 69.w,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontFamily: 'inter',
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w400),
              ),
            ],
          ),
        )
      ],
    );
  }
}
