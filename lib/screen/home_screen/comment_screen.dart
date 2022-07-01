import 'package:aplikasi_rw/bloc/comment_bloc.dart';
import 'package:aplikasi_rw/bloc/status_user_bloc.dart';
import 'package:aplikasi_rw/services/add_comment_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

//ignore: must_be_immutable
class CommentScreen extends StatelessWidget {
  // bloc
  CommentBloc bloc;
  StatusUserBloc statusBloc;
  TextEditingController controllerWriteStatus = TextEditingController();
  String idStatus;
  bool _isValidate = false;

  CommentScreen({this.idStatus});

  ScrollController controller = ScrollController();
  void onScroll() {
    if (controller.position.maxScrollExtent == controller.position.pixels) {
      bloc.add(CommentBlocEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    // bloc
    bloc = BlocProvider.of<CommentBloc>(context);
    statusBloc = BlocProvider.of<StatusUserBloc>(context);
    controller.addListener(onScroll);

    return Container(
      padding: EdgeInsets.all(0.6.h),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      height: 60.0.h,
      child: WillPopScope(
        onWillPop: () async {
          bloc.add(CommentEventRefresh());
          return true;
        },
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(5.0.h),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 10.0.w,
                  ),
                  Text(
                    // '${CommentModel.getAllComment().length} Comment',
                    'comment',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 12.0.sp),
                  ),
                  IconButton(
                    icon: Icon(Icons.clear_rounded),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ]),
          ),
          body: Stack(children: [
            Container(
              height: 47.0.h,
              child: BlocBuilder<CommentBloc, CommentBlocState>(
                  builder: (context, state) {
                if (state is CommentBlocUnitialized) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: SizedBox(
                        width: 5.0.w,
                        height: 3.0.h,
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  );
                } else {
                  CommentBlocLoaded commentLoaded = state as CommentBlocLoaded;
                  return ListView.builder(
                    controller: controller,
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: (commentLoaded.isMaxReached)
                        ? commentLoaded.listComment.length
                        : commentLoaded.listComment.length + 1,
                    itemBuilder: (context, index) => (index <
                            commentLoaded.listComment.length)
                        ? buildColumnComment(
                            commentLoaded.listComment[index].urlImage,
                            commentLoaded.listComment[index].userName,
                            commentLoaded.listComment[index].date,
                            commentLoaded.listComment[index].comment)
                        : (index == commentLoaded.listComment.length)
                            ? Container()
                            : Container(
                                margin: EdgeInsets.symmetric(vertical: 1.0.h),
                                child: Center(
                                  child: SizedBox(
                                    width: 10.0.w,
                                    height: 5.0.h,
                                    child: CircularProgressIndicator(),
                                  ),
                                ),
                              ),
                  );
                }
              }),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: 7.0.h,
                  padding: EdgeInsets.symmetric(vertical: 5),
                  decoration: BoxDecoration(color: Colors.white, boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        blurRadius: 1,
                        spreadRadius: 1)
                  ]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: 85.0.w,
                        child: TextField(
                          controller: controllerWriteStatus,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                ),
                              ),
                              filled: true,
                              fillColor: Colors.grey[200],
                              hintText: 'write status',
                              errorText: (_isValidate)
                                  ? 'comment can\'t be empty'
                                  : null),
                          style: TextStyle(fontSize: 12.0.sp),
                        ),
                      ),
                      Material(
                        color: Colors.transparent,
                        child: IconButton(
                            icon: Icon(
                              Icons.arrow_forward,
                              size: 4.0.h,
                            ),
                            onPressed: () {
                              AddCommentServices.addComment(idStatus,
                                  controllerWriteStatus.text, context);
                              bloc.add(CommentEventRefresh());
                              bloc.add(CommentBlocEvent(
                                  idStatus: int.parse(idStatus)));
                            }),
                      )
                    ],
                  ),
                )
              ],
            )
          ]),
        ),
      ),
    );
  }

  Column buildColumnComment(
      String urlUserComment, String userName, String date, String comment) {
    return Column(
      children: [
        ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(urlUserComment),
            radius: 3.5.h,
          ),
          title: Text(
            userName,
            style: TextStyle(fontSize: 11.0.sp),
          ),
          subtitle: Text(date, style: TextStyle(fontSize: 9.0.sp)),
        ),
        Row(
          children: [
            SizedBox(
              width: 5.0.w,
            ),
            Expanded(
              child: Text(
                comment,
                maxLines: 10,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 12.0.sp),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 1.0.h,
        ),
        Divider(
          thickness: 1,
        )
      ],
    );
  }
}
