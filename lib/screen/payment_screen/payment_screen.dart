import 'package:aplikasi_rw/bloc/payment_bloc.dart';
import 'package:aplikasi_rw/model/card_payment_model.dart';
import 'package:aplikasi_rw/screen/bills_screen/bills_screen.dart';
import 'package:aplikasi_rw/screen/bills_screen/details_bill_screen.dart';
import 'package:aplikasi_rw/screen/payment_screen/add_payment.dart';
import 'package:aplikasi_rw/screen/payment_screen/card_payment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

class PaymentScreen extends StatelessWidget {
  double mediaSizeHeight, mediaSizeWidth;
  bool isVisibility = false;

  PaymentBloc bloc;
  @override
  Widget build(BuildContext context) {
    bloc = BlocProvider.of<PaymentBloc>(context);

    mediaSizeHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    mediaSizeWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(children: [
          Container(
            height: mediaSizeHeight * 0.2,
            color: Colors.blue[200].withOpacity(0.5),
          ),
          Column(
            children: [
              SizedBox(
                height: mediaSizeHeight * 0.015,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20, top: 20),
                    child: Text(
                      'Payment',
                      style: TextStyle(
                          color: Colors.blue[900],
                          fontFamily: 'poppins',
                          fontSize: 29),
                    ),
                  ),
                ],
              ),
              SizedBox(height: mediaSizeHeight * 0.05),
              Material(
                elevation: 5,
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  height: mediaSizeHeight * 0.13,
                  width: mediaSizeWidth * 0.9,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(
                              icon: Icon(
                                Icons.payment_outlined,
                                size: 31,
                                color: Colors.blue[900],
                              ),
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => AddPayment()));
                              }),
                          Text(
                            'Pay Now',
                            style: TextStyle(
                                fontFamily: 'pt sans narrow',
                                fontSize: 16,
                                color: Colors.blue[900]),
                          )
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(
                              icon: Icon(Icons.list_alt_rounded,
                                  size: 31, color: Colors.blue[900]),
                              onPressed: () {
                                showModalBottomSheet(
                                    backgroundColor: Colors.white,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(16),
                                        topRight: Radius.circular(16),
                                      ),
                                    ),
                                    isScrollControlled: true,
                                    context: context,
                                    builder: (context) => DetailsBillScreen());
                              }),
                          Text(
                            'Bill Details',
                            style: TextStyle(
                                fontFamily: 'pt sans narrow',
                                fontSize: 16,
                                color: Colors.blue[900]),
                          )
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          IconButton(
                              icon: ImageIcon(
                                AssetImage(
                                    'assets/img/image-icons/call-center-worker-with-headset.png'),
                                size: 31,
                                color: Colors.blue[900],
                              ),
                              onPressed: () {
                                launchWhatsApp();
                              }),
                          Text(
                            'Whatsapp Admin',
                            style: TextStyle(
                                fontFamily: 'pt sans narrow',
                                fontSize: 16,
                                color: Colors.blue[200].withOpacity(0.5)),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              buildMaterialMyPayment(),
              SizedBox(
                height: 10,
              ),
              buildVisibilityHeaderText(),
              BlocBuilder<PaymentBloc, bool>(
                builder: (context, state) => Visibility(
                  visible: state,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: CardPaymentModel.getPaymentHistory().length,
                    itemBuilder: (context, index) => (CardPaymentModel
                                    .getPaymentHistory()[index]
                                .status
                                .toLowerCase() ==
                            'listed')
                        ? Slidable(
                            actionPane: SlidableDrawerActionPane(),
                            secondaryActions: [
                              IconSlideAction(
                                caption: 'delete',
                                color: Colors.blue[200].withOpacity(0.5),
                                icon: Icons.delete_forever_outlined,
                                foregroundColor: Colors.blue[900],
                                onTap: () {
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                    backgroundColor: Colors.blue[900],
                                    content: Text(
                                      '${CardPaymentModel.getPaymentHistory()[index].noPayment} delete',
                                      textAlign: TextAlign.center,
                                    ),
                                  ));
                                },
                              )
                            ],
                            child: CardPayment(
                              noPayment:
                                  CardPaymentModel.getPaymentHistory()[index]
                                      .noPayment,
                              status:
                                  CardPaymentModel.getPaymentHistory()[index]
                                      .status,
                              title: CardPaymentModel.getPaymentHistory()[index]
                                  .title,
                            ),
                          )
                        : CardPayment(
                            noPayment:
                                CardPaymentModel.getPaymentHistory()[index]
                                    .noPayment,
                            status: CardPaymentModel.getPaymentHistory()[index]
                                .status,
                            title: CardPaymentModel.getPaymentHistory()[index]
                                .title,
                          ),
                  ),
                ),
              )
            ],
          ),
        ]),
      ),
      floatingActionButton: SizedBox(
        height: 50,
        child: FloatingActionButton(
          backgroundColor: Colors.blue[900],
          heroTag: 'btn2',
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddPayment(),
                ));
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  Visibility buildVisibilityHeaderText() {
    return Visibility(
      visible: true,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'No Payment',
              style: TextStyle(fontSize: 10, color: Colors.grey),
            ),
            Text(
              'Title',
              style: TextStyle(fontSize: 10, color: Colors.grey),
            ),
            Text(
              'Status',
              style: TextStyle(fontSize: 10, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Material buildMaterialMyPayment() {
    return Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: EdgeInsets.only(left: 15, right: 15),
        width: mediaSizeWidth * 0.95,
        height: mediaSizeHeight * 0.07,
        decoration: BoxDecoration(
          color: Colors.blue[900].withOpacity(0.7),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(20),
            splashColor: Colors.indigo,
            onTap: () {
              isVisibility = !isVisibility;
              bloc.add(isVisibility);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'My Payment',
                  style: TextStyle(
                      color: Colors.white, fontSize: 16, fontFamily: 'poppins'),
                ),
                Row(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 10),
                          child: Text(
                            '${CardPaymentModel.getPaymentHistory().length}',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                        Icon(
                          Icons.account_balance_wallet_rounded,
                          size: 21,
                          color: Colors.white,
                        )
                      ],
                    ),
                    Row(
                      children: [
                        VerticalDivider(
                          color: Colors.white,
                          width: 50,
                          thickness: 1,
                          indent: 17,
                          endIndent: 17,
                        ),
                        BlocBuilder<PaymentBloc, bool>(
                          builder: (context, state) => Material(
                              color: Colors.transparent,
                              child: SizedBox(
                                height: 50,
                                width: mediaSizeWidth * 0.045,
                                child: InkWell(
                                  splashColor: Colors.indigo,
                                  borderRadius: BorderRadius.circular(20),
                                  child: AnimatedSwitcher(
                                      duration: Duration(milliseconds: 900),
                                      child: (state)
                                          ? Icon(
                                              FontAwesomeIcons.angleUp,
                                              color: Colors.white,
                                            )
                                          : Icon(
                                              FontAwesomeIcons.angleDown,
                                              color: Colors.white,
                                            )),
                                  onTap: () {
                                    isVisibility = !isVisibility;
                                    bloc.add(isVisibility);
                                  },
                                ),
                              )),
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  launchWhatsApp() async {
    final link = WhatsAppUnilink(
      phoneNumber: '+6285714342528',
      text: "Selamat siang admin",
    );
    await launch('$link');
  }
}
