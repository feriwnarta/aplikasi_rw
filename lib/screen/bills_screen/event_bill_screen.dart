import 'package:flutter/material.dart';

class EventBillScrenn extends StatelessWidget {
  double mediaSizeHeight, mediaSizeWidth;
  final Color background;

  final String urlHeroImage, titleEvent, price, dueDate;

  EventBillScrenn(
      {this.urlHeroImage, this.titleEvent, this.price, this.dueDate, this.background});

  @override
  Widget build(BuildContext context) {
    mediaSizeHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    mediaSizeWidth = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Container(
        height: mediaSizeHeight * 0.6,
        width: mediaSizeWidth,
        decoration: BoxDecoration(
            color: background, borderRadius: BorderRadius.vertical()),
        child: Column(
          children: [
            Container(
              child: Image(
                width: mediaSizeWidth,
                height: mediaSizeHeight * 0.3,
                fit: BoxFit.cover,
                repeat: ImageRepeat.noRepeat,
                image: NetworkImage(urlHeroImage),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: Text(titleEvent,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Material(
              borderRadius: BorderRadius.circular(20),
              elevation: 7,
              child: Container(
                width: mediaSizeWidth * 0.8,
                height: mediaSizeHeight * 0.15,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          )),
                      height: mediaSizeHeight * 0.075,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'Contribution Amount',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          VerticalDivider(
                            indent: 10,
                            endIndent: 10,
                            color: Colors.black,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('$price IDR',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              Text(dueDate,
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey[700]))
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          width: mediaSizeWidth * 0.3,
                          height: mediaSizeHeight * 0.04,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shadowColor: Colors.red,
                                elevation: 0,
                                primary: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                side: BorderSide(color: background)),
                            child: Text(
                              'See Details',
                              style: TextStyle(
                                color: background,
                              ),
                            ),
                            onPressed: () {},
                          ),
                        ),
                        SizedBox(
                          width: mediaSizeWidth * 0.3,
                          height: mediaSizeHeight * 0.04,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                elevation: 0,
                                primary: background,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                side: BorderSide(color: background)),
                            child: Text(
                              'Pay',
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {},
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
