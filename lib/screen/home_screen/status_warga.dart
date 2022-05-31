import 'package:aplikasi_rw/screen/home_screen/comment_screen.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

//ignore: must_be_immutable
class StatusWarga extends StatelessWidget {
  // sampel data untuk status warga
  String userName,
      uploadTime,
      urlStatusImage,
      fotoProfile,
      caption,
      numberOfLikes,
      numberOfComments;

  // Container untuk data
  StatusWarga({
    this.userName,
    this.uploadTime,
    this.urlStatusImage,
    this.fotoProfile,
    this.caption,
    this.numberOfLikes,
    this.numberOfComments,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 2)]),

      // top : 10, left: 10, right: 10
      margin: EdgeInsets.only(top: 10, left: 10, right: 10),
      child: Column(
        children: [
          Row(children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 10),
              child: CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(fotoProfile),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10, top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 3),
                    child: Text(
                      userName,
                      style: TextStyle(fontSize: 9.0.sp),
                    ),
                  ),
                  Text(
                    '$uploadTime',
                    style: TextStyle(fontSize: 9.0.sp),
                  )
                ],
              ),
            )
          ]),

          // bagian caption
          Padding(
            padding: EdgeInsets.only(left: 10, top: 5, right: 10, bottom: 10),
            child: Row(
              children: [
                Expanded(
                  child: ReadMoreText(
                    caption,
                    trimLines: 3,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: 'Read More',
                    trimExpandedText: 'Read Less',
                    textAlign: TextAlign.justify,
                    style: TextStyle(fontSize: 11.0.sp),
                  ),
                )
              ],
            ),
          ),

          // Bagian foto
          Row(
            children: [
              Container(
                child: Expanded(
                  flex: 1,
                  // child: Image(
                  //   // width: MediaQuery.of(context).size.width * 0.949,
                  //   height: MediaQuery.of(context).size.height * 0.4,
                  //   alignment: Alignment.bottomLeft,
                  //   fit: BoxFit.cover,
                  //   repeat: ImageRepeat.noRepeat,
                  //   image: NetworkImage(urlStatusImage),
                  // ),
                  // child: FadeInImage(
                  //   imageErrorBuilder: (BuildContext context, Object exception,
                  //       StackTrace stackTrace) {
                  //     print('Error Handler');
                  //     return Container(
                  //       height: 50.0.h,
                  //       child: Icon(Icons.error),
                  //     );
                  //   },
                  //   placeholder: AssetImage('assets/img/loading.gif'),
                  //   image: NetworkImage(urlStatusImage),
                  //   fit: BoxFit.cover,
                  //   height: 50.0.h,
                  // ),
                  child: Image.network(
                    urlStatusImage,
                    height: 50.0.h,
                    fit: BoxFit.cover,
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      }
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  ),
                ),
              )
            ],
          ),

          // Like Dan comment
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Material(
                      color: Colors.transparent,
                      child: IconButton(
                        splashColor: Colors.transparent,
                        icon: Icon(Icons.thumb_up_alt_outlined,
                            color: Colors.black),
                        onPressed: () {},
                      ),
                    ),
                    Text(numberOfLikes)
                  ],
                ),
                Row(
                  children: [
                    Material(
                      color: Colors.transparent,
                      child: IconButton(
                        splashColor: Colors.transparent,
                        icon: Icon(
                          Icons.comment_outlined,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          showModalBottomSheet(
                            barrierColor: Colors.white.withOpacity(0.4),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(16),
                                topRight: Radius.circular(16),
                              ),
                            ),
                            isScrollControlled: true,
                            context: context,
                            // push id comment
                            builder: (context) => CommentScreen(),
                          );
                        },
                      ),
                    ),
                    Text(numberOfComments)
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
