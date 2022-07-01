import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ViewImage extends StatelessWidget {
  String urlImage;

  ViewImage({this.urlImage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
        color: Colors.black,
        child: Center(
          child: InteractiveViewer(
            panEnabled: true,
            boundaryMargin: EdgeInsets.all(0),
            scaleEnabled: true,
            minScale: 1,
            maxScale: 2.5,
            child: Image.network(
              urlImage,
              width: double.infinity,
              height: 55.0.h,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
