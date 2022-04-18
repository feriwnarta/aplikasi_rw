import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

//ignore: must_be_immutable
class StatusWarga extends StatelessWidget {
  // String namaUser, rw, waktuUpload, urlFotoStatus, fotoProfile, caption, jumlahLike, jumlahKomen;

  // Container untuk data
  StatusWarga({
    this.namaUser,
    this.lamaUpload,
    this.urlFotoStatus,
    this.fotoProfile,
    this.caption,
    this.jumlahLike,
    this.jumlahKomen,
  });

  // sampel data untuk status warga
  String namaUser, lamaUpload, urlFotoStatus, fotoProfile, caption, jumlahLike, jumlahKomen;

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
                    child: Text(namaUser),
                  ),
                  Text('$lamaUpload',style: TextStyle(fontSize: 9),
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
                  // child: Text(
                  // caption,
                  // textAlign: TextAlign.justify,
                  // style: TextStyle(height: 1.4),
                  // maxLines: 10,
                  // )
                  child: ReadMoreText(
                    caption,
                    trimLines: 3,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: 'Read More',
                    trimExpandedText: 'Read Less',
                    textAlign: TextAlign.justify,
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
                  child: Image(
                    // width: MediaQuery.of(context).size.width * 0.949,
                    height: MediaQuery.of(context).size.height * 0.4,
                    alignment: Alignment.bottomLeft,
                    fit: BoxFit.cover,
                    repeat: ImageRepeat.noRepeat,
                    image: NetworkImage(urlFotoStatus),
                  ),
                ),
              )
            ],
          ),

          // Like Dan comment
          Padding(
            // padding tambahahan karena row pembungus padding kanannya dikurangin 10
            // jadi total 20
            padding: EdgeInsets.only(right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.thumb_up_alt_outlined,
                          color: Colors.black),
                      onPressed: () {},
                    ),
                    Text(jumlahLike)
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.comment_outlined,
                        color: Colors.black,
                      ),
                      onPressed: () {},
                    ),
                    Text(jumlahKomen)
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
