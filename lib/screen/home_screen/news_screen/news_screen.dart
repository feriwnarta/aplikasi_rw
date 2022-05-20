import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

class NewsScreen extends StatelessWidget {
  final String urlImage, caption, content;

  NewsScreen({this.urlImage, this.caption, this.content});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark
      ),
          child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 30.0.h,
              floating: true,
              pinned: true,
              snap: true,
              actionsIconTheme: IconThemeData(opacity: 0.0),
              flexibleSpace: Stack(
                children: <Widget>[
                  Positioned.fill(
                      child: CachedNetworkImage(
                    imageUrl: urlImage,
                    fit: BoxFit.cover,
                    repeat: ImageRepeat.noRepeat,
                    placeholder: (context, _) => Container(
                      color: Colors.grey,
                    ),
                    errorWidget: (context, url, _) => Container(
                      color: Colors.grey,
                      child: Icon(
                        Icons.error,
                        color: Colors.red,
                      ),
                    ),
                  ))
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  // caption
                  Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: 4.0.w, vertical: 2.7.h),
                      child: Text(
                        caption,
                        textAlign: TextAlign.justify,
                        style: TextStyle(fontFamily: 'poppins'),
                      )),

                  Divider(
                    thickness: 3,
                    indent: 40.0.w,
                    endIndent: 40.0.w,
                  ),

                  // body
                  Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: 4.0.w, vertical: 2.7.h),
                    child: Text(
                      content,
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
