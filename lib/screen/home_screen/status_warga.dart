import 'package:aplikasi_rw/bloc/comment_bloc.dart';
import 'package:aplikasi_rw/bloc/count_comment_bloc.dart';
import 'package:aplikasi_rw/bloc/like_status_bloc.dart';
import 'package:aplikasi_rw/screen/home_screen/comment_screen.dart';
import 'package:aplikasi_rw/screen/report_screen2/view_image.dart';
import 'package:aplikasi_rw/server-app.dart';
import 'package:aplikasi_rw/services/count_comment_services.dart';
import 'package:aplikasi_rw/services/like_status_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:readmore/readmore.dart';
import 'package:sizer/sizer.dart';

//ignore: must_be_immutable
class StatusWarga extends StatefulWidget {
  String userName,
      uploadTime,
      urlStatusImage,
      fotoProfile,
      caption,
      numberOfLikes,
      idStatus,
      numberOfComments,
      idUser;

  // Container untuk data
  StatusWarga(
      {this.userName,
      this.uploadTime,
      this.urlStatusImage,
      this.fotoProfile,
      this.caption,
      this.numberOfLikes,
      this.numberOfComments,
      this.idStatus,
      this.idUser});

  @override
  _StatusWargaState createState() => _StatusWargaState();
}

class _StatusWargaState extends State<StatusWarga> {
  bool isLoading = true;
  LikeStatusBloc bloc;
  CommentBloc commentBloc;
  CommentCountBloc countBloc;
  Color color = Colors.black;
  bool isLike = false;
  String numberLike = '0';

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    commentBloc.close();
    bloc.close();
    countBloc.close();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    LikeStatusService.isLike(idStatus: widget.idStatus, idUser: widget.idUser)
        .then((value) {
      if (value >= 1) {
        setState(() {
          color = Colors.red;
          isLike = true;
        });
      } else {
        setState(() {
          isLike = false;
        });
      }
    });
    LikeStatusService.getLike(idStatus: widget.idStatus, idUser: widget.idUser)
        .then((value) {
      print('jmlah' + value);
      if (value != null) {
        numberLike = value;
      }
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    bloc = BlocProvider.of<LikeStatusBloc>(context);
    countBloc = BlocProvider.of<CommentCountBloc>(context);
    commentBloc = BlocProvider.of<CommentBloc>(context);
    print('id status from status warga ${int.parse(widget.idStatus)}');

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
                backgroundImage:
                    NetworkImage('${ServerApp.url}${widget.fotoProfile}'),
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
                      widget.userName,
                      style: TextStyle(fontSize: 9.0.sp),
                    ),
                  ),
                  Text(
                    '${widget.uploadTime}',
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
                    widget.caption,
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
              Visibility(
                visible:
                    (widget.urlStatusImage.contains('no_image')) ? false : true,
                child: Container(
                  child: Expanded(
                    flex: 1,
                    child: GestureDetector(
                      child: FadeInImage(
                        imageErrorBuilder: (BuildContext context,
                            Object exception, StackTrace stackTrace) {
                          print('Error Handler');
                          return Container(
                            height: 40.0.h,
                            child: Icon(Icons.error),
                          );
                        },
                        placeholder: AssetImage('assets/img/loading.gif'),
                        image: NetworkImage(widget.urlStatusImage),
                        fit: BoxFit.cover,
                        height: 40.0.h,
                      ),
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ViewImage(
                          urlImage: widget.urlStatusImage,
                        ),
                      )),
                    ),
                  ),
                ),
              )
            ],
          ),

          // Like Dan comment
          BlocBuilder<LikeStatusBloc, LikeStatusState>(
            builder: (context, state) => Padding(
              padding: EdgeInsets.only(right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      ButtonLike(
                        color: color,
                        isLike: isLike,
                        widget: widget,
                        numberLike: numberLike,
                      ),
                    ],
                  ),
                  ButtonComment(commentBloc: commentBloc, widget: widget)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ButtonLike extends StatefulWidget {
  ButtonLike({
    Key key,
    @required this.color,
    @required this.isLike,
    @required this.widget,
    @required this.numberLike,
  }) : super(key: key);

  Color color;
  bool isLike;
  StatusWarga widget;
  String numberLike = '0';

  @override
  _ButtonLikeState createState() => _ButtonLikeState();
}

class _ButtonLikeState extends State<ButtonLike> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Row(
        children: [
          IconButton(
            splashColor: Colors.transparent,
            icon: Icon(Icons.thumb_up_alt_outlined, color: widget.color),
            onPressed: () {
              print('button like clicked');
              if (!widget.isLike) {
                LikeStatusService.addLike(
                        idStatus: widget.widget.idStatus,
                        idUser: widget.widget.idUser)
                    .then((value) {
                  if (value == 'OK') {
                    LikeStatusService.getLike(
                            idStatus: widget.widget.idStatus,
                            idUser: widget.widget.idUser)
                        .then((value) {
                      print('jmlah' + value);
                      if (value != null) {
                        setState(() {
                          widget.isLike = true;
                          widget.color = Colors.red;
                          widget.numberLike = value;
                        });
                      }
                    });
                  }
                });
              } else {
                LikeStatusService.deleteLike(
                        idStatus: widget.widget.idStatus,
                        idUser: widget.widget.idUser)
                    .then((value) {
                  if (value == 'OK') {
                    LikeStatusService.getLike(
                            idStatus: widget.widget.idStatus,
                            idUser: widget.widget.idUser)
                        .then((like) {
                      print('jmlah' + value);
                      if (like != null) {
                        setState(() {
                          widget.isLike = false;
                          widget.color = Colors.black;
                          widget.numberLike = like;
                        });
                      }
                    });
                  }
                });
              }
            },
          ),
          Text(widget.numberLike)
        ],
      ),
    );
  }
}

class ButtonComment extends StatefulWidget {
  ButtonComment({
    Key key,
    @required this.commentBloc,
    @required this.widget,
  }) : super(key: key);

  final CommentBloc commentBloc;
  final StatusWarga widget;

  @override
  _ButtonCommentState createState() => _ButtonCommentState();
}

class _ButtonCommentState extends State<ButtonComment> {
  String count = '0';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    getCountComment();
    return Row(
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
              widget.commentBloc.add(CommentEventRefresh());
              widget.commentBloc.add(CommentBlocEvent(
                  idStatus: int.parse(widget.widget.idStatus)));
              showModalBottomSheet(
                  barrierColor: Colors.black.withOpacity(0.4),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                  isScrollControlled: true,
                  context: context,
                  // push id comment
                  builder: (context) => CommentScreen(
                        idStatus: widget.widget.idStatus,
                      ));
            },
          ),
        ),
        Text(count)
      ],
    );
  }

  void getCountComment() {
    CountCommentServices.getCountComment(
            idStatus: widget.widget.idStatus, idUser: widget.widget.idUser)
        .then((value) {
      if (value != null) {
        setState(() {
          count = value;
        });
      }
    });
  }
}
