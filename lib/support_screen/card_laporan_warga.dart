import 'package:aplikasi_rw/support_screen/card_laporan_warga_edit.dart';
import 'package:aplikasi_rw/transition_screen/slide_transition.dart';
import 'package:flutter/material.dart';

//ignore: must_be_immutable
class CardLaporanWarga extends StatefulWidget {
  String noTicket, judul, status;

  CardLaporanWarga({this.noTicket, this.judul, this.status});

  @override
  State<CardLaporanWarga> createState() =>
      _CardLaporanWargaState(noTicket: noTicket, judul: judul, status: status);
}

class _CardLaporanWargaState extends State<CardLaporanWarga> {
  String noTicket, judul, status;

  _CardLaporanWargaState({this.noTicket, this.judul, this.status});

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
            Navigator.of(context).push(
              SlideTranstionRoute(
                child: CardLaporanWargaEdit(noTickets: noTicket,),
                direction: AxisDirection.right
              )
            );
          },
        ),
      ),
    );
  }
}
