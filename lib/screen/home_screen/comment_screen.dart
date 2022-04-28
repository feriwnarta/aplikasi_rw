import 'package:aplikasi_rw/bloc/comment_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class CommentScreen extends StatelessWidget {
  // bloc
  CommentBloc bloc;

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
    controller.addListener(onScroll);

    return Container(
      height: 60.0.h,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(5.0.h),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            SizedBox(
              width: 10.0.w,
            ),
            Text(
              // '${CommentModel.getAllComment().length} Comment',
              'comment',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.0.sp),
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
          BlocBuilder<CommentBloc, CommentBlocState>(builder: (context, state) {
            if (state is CommentBlocUnitialized) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: SizedBox(
                    width: 3.0.w,
                    height: 3.0.h,
                    child: CircularProgressIndicator(),
                  ),
                ),
              );
            } else {
              CommentBlocLoaded commentLoaded = state as CommentBlocLoaded;

              return ListView.builder(
                controller: controller,
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                itemCount: (commentLoaded.isMaxReached)
                    ? commentLoaded.listComment.length
                    : commentLoaded.listComment.length + 2,
                itemBuilder: (context, index) => (index <
                        commentLoaded.listComment.length)
                    ? buildColumnComment(
                        commentLoaded.listComment[index].urlImage,
                        '${commentLoaded.listComment[index].userName} $index',
                        commentLoaded.listComment[index].date,
                        commentLoaded.listComment[index].comment)
                    : Container(
                        margin: EdgeInsets.symmetric(vertical: 1.0.h),
                        child: Center(
                          child: SizedBox(
                            width: 30,
                            height: 30,
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      ),
              );
            }
          }),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: 8.0.h,
                decoration: BoxDecoration(color: Colors.grey[100], boxShadow: [
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
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red)),
                            hintText: 'write status'),
                            style: TextStyle(
                              fontSize: 12.0.sp
                            ),
                      ),
                    ),
                    Material(
                      child: IconButton(
                          icon: Icon(Icons.arrow_forward, size: 4.0.h,), onPressed: () {}),
                    )
                  ],
                ),
              )
            ],
          )
        ]),
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
            style: TextStyle(fontSize: 12.0.sp),
          ),
          subtitle: Text(date, style: TextStyle(fontSize: 11.0.sp)),
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
                style: TextStyle(
                  fontSize: 12.0.sp
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 2.0.h,
        ),
        Divider(
          thickness: 1,
        )
      ],
    );
  }
}
