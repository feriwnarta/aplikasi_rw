import 'package:flutter/material.dart';

class CreateReportScreen extends StatefulWidget {
  @override
  State<CreateReportScreen> createState() => _CreateReportScreenState();
}

class _CreateReportScreenState extends State<CreateReportScreen> {
  double mediaSizeHeight;

  @override
  Widget build(BuildContext context) {
    mediaSizeHeight = MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;

    return Container(
      height: mediaSizeHeight * 0.7,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Add Report'),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(
              Icons.clear_rounded,
              color: Colors.white,
              size: 30,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
      ),
    );
  }
}
