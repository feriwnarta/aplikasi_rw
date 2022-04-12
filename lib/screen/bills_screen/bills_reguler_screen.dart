import 'package:aplikasi_rw/model/bills_history.dart';
import 'package:flutter/material.dart';

class BillsRegulerScreen extends StatefulWidget {
  @override
  State<BillsRegulerScreen> createState() => _BillsRegulerScreenState();
}

class _BillsRegulerScreenState extends State<BillsRegulerScreen> {
  double mediaSizeHeight;
  double mediaSizeWidth;
  bool isExpand = false;

  @override
  Widget build(BuildContext context) {
    mediaSizeHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    mediaSizeWidth = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 10,),
          buildContainerCardBills(),
          Container(
            margin: EdgeInsets.only(top: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 10, bottom: 15),
                  child: Text(
                    'Previous Bill',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                Container(
                  width: mediaSizeWidth * 0.95,
                  height: mediaSizeHeight * 0.4,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.black)),
                  child: Container(
                    margin:
                        EdgeInsets.only(top: 10, bottom: 10, left: 2, right: 2),
                    child: SingleChildScrollView(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: ExpansionPanelList(
                            expansionCallback: (panelIndex, isExpanded) {
                              setState(() {
                                isExpand = !isExpanded;
                              });
                            },
                            children: BillsHistory.getBillsHistory().map<ExpansionPanel>((items) => ExpansionPanel(

                                  isExpanded: isExpand,
                                  canTapOnHeader: true,
                                  headerBuilder: (context, isExpanded) =>
                                      ListTile(
                                        title: Text(
                                          '${items.month} ${items.year}',
                                          style: TextStyle(
                                            fontSize: 15,

                                          ),
                                        ),
                                        subtitle: Text('${items.total} IDR'),
                                      ),
                                  body: ListTile(
                                    title: Text('asd'),
                            
                            ))).toList(),
                      ),
                    ),
                  ),
                ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Container buildContainerCardBills() {
    return Container(
      padding: EdgeInsets.all(20),
      width: mediaSizeWidth * 0.95,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xff2297F4), Color(0xff3ABBFD)])),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            height: mediaSizeHeight * 0.07,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Tagihan Saya',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 19,
                            fontWeight: FontWeight.bold)),
                    Text(
                      'March 2022',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    )
                  ],
                ),
                VerticalDivider(
                  color: Colors.white,
                  // width: 50,
                  thickness: 1,
                  endIndent: 15,
                ),
                Text(
                  '350.000.000 IDR',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                )
              ],
            ),
          ),
          Divider(
            color: Colors.white,
            thickness: 1,
          ),
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: mediaSizeWidth * 0.4,
                  height: mediaSizeHeight * 0.04,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        elevation: 0,
                        primary: Colors.transparent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        side: BorderSide(color: Colors.white)),
                    child: Text('See Details'),
                    onPressed: () {},
                  ),
                ),
                SizedBox(
                  width: mediaSizeWidth * 0.4,
                  height: mediaSizeHeight * 0.04,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      primary: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                    child: Text(
                      'Pay off now',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {},
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
