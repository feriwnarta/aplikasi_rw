import 'package:aplikasi_rw/bloc/comment_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommentScreen extends StatelessWidget {
  double mediaSizeHeight, mediaSizeWidth;

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

    mediaSizeHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    mediaSizeWidth = MediaQuery.of(context).size.width;

    return Container(
      height: mediaSizeHeight * 0.6,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(mediaSizeHeight * 0.05),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            SizedBox(
              width: mediaSizeWidth * 0.1,
            ),
            Text(
              // '${CommentModel.getAllComment().length} Comment',
              'comment',
              style: TextStyle(fontWeight: FontWeight.bold),
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
                    width: 30,
                    height: 30,
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
                        margin: EdgeInsets.symmetric(vertical: 10),
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
                height: mediaSizeHeight * 0.07,
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
                      width: mediaSizeWidth * 0.8,
                      child: TextField(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red),
                                borderRadius: BorderRadius.circular(10)),
                            hintText: 'write status'),
                      ),
                    ),
                    Material(
                      child: IconButton(
                          icon: Icon(Icons.arrow_forward), onPressed: () {}),
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
            radius: 20,
          ),
          title: Text(userName),
          subtitle: Text(date),
        ),
        Row(
          children: [
            SizedBox(
              width: mediaSizeWidth * 0.05,
            ),
            Expanded(
              child: Text(
                comment,
                maxLines: 10,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.left,
                style: TextStyle(),
              ),
            ),
          ],
        ),
        SizedBox(
          height: mediaSizeHeight * 0.02,
        ),
        Divider(
          thickness: 1,
        )
      ],
    );
  }
}
