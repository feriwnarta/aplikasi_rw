
import 'package:aplikasi_rw/screen/transition_screen/slide_transition.dart';
import 'package:flutter/material.dart';

//ignore: must_be_immutable
class CardPayment extends StatelessWidget {
  String noPayment, title, status;

  CardPayment({this.noPayment, this.title, this.status});

  Color colorStatusCheck() {
    return (status.toLowerCase() == 'listed')
        ? Colors.grey
        : Colors.green[800];
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
                noPayment,
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo),
              ),
            ),
            title: Text(
              // 36 kata
              title,
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
              
            }
          },
        ),
      ),
    );
  }
}
