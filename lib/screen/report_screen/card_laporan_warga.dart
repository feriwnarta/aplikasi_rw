import 'package:aplikasi_rw/screen/report_screen/card_laporan_warga_edit.dart';
import 'package:aplikasi_rw/screen/transition_screen/slide_transition.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

//ignore: must_be_immutable
class CardLaporanWarga extends StatelessWidget {
  String noTicket, judul, status;

  CardLaporanWarga({this.noTicket, this.judul, this.status});

  Color colorStatusCheck() {
    return (status.toLowerCase() == 'listed')
        ? Colors.grey
        : (status.toLowerCase() == 'noticed'
            ? Colors.yellow[700]
            : Colors.green);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 9.0.h,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 2,
        child: Material(
          color: Colors.transparent,
          elevation: 0,
          child: InkWell(
            splashColor: Colors.indigo,
            borderRadius: BorderRadius.circular(20),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 4.0.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    noTicket,
                    style: TextStyle(
                        fontSize: 9.0.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.indigo),
                  ),
                  Container(
                    width: 60.0.w,
                    child: Text(
                      // 36 kata
                      judul,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 9.0.sp, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    width: 12.0.w,
                    child: Text(
                    status,
                    style: TextStyle(
                        fontSize: 9.0.sp,
                        fontWeight: FontWeight.bold,
                        color: colorStatusCheck()),
                ),
                  ),
                  

                ],
              ),
            ),
            onTap: () {
              if (status.toLowerCase() == 'listed') {
                Navigator.of(context).push(SlideTranstionRoute(
                    child: CardLaporanWargaEdit(
                      noTickects: noTicket,
                    ),
                    direction: AxisDirection.right));
              }
            },
          ),
        ),
      ),
    );
  }
}

// ListTile(
//               contentPadding: EdgeInsets.symmetric(horizontal: 4.0.w),
//               leading: Padding(
//                 padding: EdgeInsets.only(top: 1.0.h),
//                 child: Text(
//                   noTicket,
//                   style: TextStyle(
//                       fontSize: 9.0.sp,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.indigo),
//                 ),
//               ),
//               title: Text(
//                 // 36 kata
//                 judul,
//                 maxLines: 1,
//                 overflow: TextOverflow.ellipsis,
//                 style: TextStyle(fontSize: 9.0.sp, fontWeight: FontWeight.bold),
//               ),
//               trailing: Text(
//                 status,
//                 style: TextStyle(
//                     fontSize: 9.0.sp,
//                     fontWeight: FontWeight.bold,
//                     color: colorStatusCheck()),
//               ),
//             ),
