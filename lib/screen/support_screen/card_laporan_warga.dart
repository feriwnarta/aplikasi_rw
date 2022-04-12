import 'package:aplikasi_rw/screen/support_screen/card_laporan_warga_edit.dart';
import 'package:aplikasi_rw/screen/transition_screen/slide_transition.dart';
import 'package:flutter/material.dart';

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
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 2,
      child: Material(
        color: Colors.transparent,
        elevation: 0,
        child: InkWell(
          splashColor: Colors.indigo,
          borderRadius: BorderRadius.circular(20),
          child: ListTile(
            contentPadding: EdgeInsets.only(left: 20, right: 20),
            leading: Padding(
              padding: EdgeInsets.only(top: 3),
              child: Text(
                noTicket,
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo),
              ),
            ),
            title: Text(
              // 36 kata
              judul,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
            ),
            trailing: Text(
              status,
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: colorStatusCheck()),
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
    );
  }
}
