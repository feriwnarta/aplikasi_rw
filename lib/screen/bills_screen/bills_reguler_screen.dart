import 'package:aplikasi_rw/bloc/bills_reguler_screen_bloc.dart';
import 'package:aplikasi_rw/model/bills_history_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BillsRegulerScreen extends StatelessWidget {
  double mediaSizeHeight;
  double mediaSizeWidth;
  bool isExpand = false;

  // bloc
  BillRegulerBloc bloc;

  @override
  Widget build(BuildContext context) {
    bloc = BlocProvider.of<BillRegulerBloc>(context);

    mediaSizeHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    mediaSizeWidth = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
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
                Center(child: buildContainerPreviousBill()),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Column(
                    children: [
                      buildListTileBottomStatus(Icons.notifications_none,
                          'Bill Reminder', '3 Maret 2022'),
                      buildListTileBottomStatus(Icons.email_outlined,
                          'Send E-Bill', 'example@gmail.com'),
                      buildListTileBottomStatus(
                          FontAwesomeIcons.questionCircle, 'Help', 'FAQ'),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  ListTile buildListTileBottomStatus(
      IconData icon, String description, String status) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 30),
      title: Row(
        children: [
          Icon(
            icon,
            color: Colors.black,
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            description,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
      trailing: Text(
        status,
        style: TextStyle(color: Colors.grey),
      ),
      onTap: () {},
    );
  }

  Container buildContainerPreviousBill() {
    return Container(
      width: mediaSizeWidth * 0.95,
      height: mediaSizeHeight * 0.45,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.black)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          margin: EdgeInsets.only(bottom: 10, left: 2, right: 2),
          child: SingleChildScrollView(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: BlocBuilder<BillRegulerBloc, List<BillsHistoryModel>>(
                builder: (context, state) => ExpansionPanelList(
                  expansionCallback: (panelIndex, isExpanded) {
                    bloc.add(BillRegulerEvent(
                      index: panelIndex,
                      isExpanded: !isExpanded
                    ));
                  },
                  children: state
                      .map<ExpansionPanel>((items) => ExpansionPanel(
                          isExpanded: items.isExpanded,
                          canTapOnHeader: true,
                          headerBuilder: (context, isExpanded) => ListTile(
                                title: Text(
                                  '${items.month} ${items.year}',
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                                subtitle: Text('${items.total} IDR'),
                              ),
                          body: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: items.billsHistoryBody.length,
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            reverse: true,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  ListTile(
                                    title: Text(
                                        '${items.billsHistoryBody[index].description}'),
                                    subtitle: Text(
                                        '${items.billsHistoryBody[index].date}-${items.billsHistoryBody[index].month}-${items.billsHistoryBody[index].year}'),
                                    trailing: Text(
                                        '${items.billsHistoryBody[index].price}'),
                                  ),
                                  Divider()
                                ],
                              );
                            },
                          )))
                      .toList(),
                ),
              ),
            ),
          ),
        ),
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
            height: mediaSizeHeight * 0.055,
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
                  endIndent: 8,
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
