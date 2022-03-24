import 'package:flutter/material.dart';

class StatusWarga extends StatefulWidget {
  String namaUser,
      rw,
      waktuUpload,
      urlFotoStatus,
      fotoProfile,
      caption,
      jumlahLike,
      jumlahKomen;  

  // Constructor untuk menerima data
  StatusWarga({this.namaUser, this.rw, this.waktuUpload, this.urlFotoStatus,
      this.fotoProfile, this.caption, this.jumlahLike, this.jumlahKomen});

  @override
  State<StatusWarga> createState() => _StatusWargaState(
    namaUser: namaUser,
    rw: rw,
    waktuUpload: waktuUpload,
    urlFotoStatus: urlFotoStatus,
    fotoProfile: fotoProfile,
    caption: caption,
    jumlahLike: jumlahLike,
    jumlahKomen: jumlahKomen,
  );
      
}

class _StatusWargaState extends State<StatusWarga> {
  // String namaUser, rw, waktuUpload, urlFotoStatus, fotoProfile, caption, jumlahLike, jumlahKomen;

  // Container untuk data
  _StatusWargaState({
      this.namaUser,
      this.rw,
      this.waktuUpload,
      this.urlFotoStatus,
      this.fotoProfile,
      this.caption,
      this.jumlahLike,
      this.jumlahKomen,
      });

  // sampel data untuk status warga
  String namaUser = 'Siska';
  String rw = 'RW 01';
  String waktuUpload = '1 jam yang lalu';
  String urlFotoStatus =
      'https://i.pinimg.com/originals/ce/16/b9/ce16b9ea78dc83667937dfcc509d66a2.jpg';
  String fotoProfile =
      'https://img.idxchannel.com/media/700/images/idx/2022/03/08/Kekayaan_Orang_Tua_Sisca_Kohl.jpg';
  String caption =
      'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa';
  String jumlahLike = '21';
  String jumlahKomen = '20';

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 2 
          )
        ]
      ),
      margin: EdgeInsets.only(top: 10, left: 10, right: 10),
      child: Padding(
        padding: EdgeInsets.only(left: 20, right: 10, top: 20),
        child: Column(
          children: [
            Row(children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(fotoProfile),
              ),
              Container(
                margin: EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(namaUser),
                    Row(
                      children: [
                        Text(
                          '$waktuUpload',
                          style: TextStyle(fontSize: 9),
                        ),
                        Container(
                          width: 5,
                        ),
                        Text(
                          '$rw',
                          style:
                              TextStyle(fontSize: 9, color: Colors.lightBlue),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ]),

            // bagian caption
            Padding(
              padding: EdgeInsets.only(top: 5, bottom: 10, right: 5),
              child: Row(
                children: [
                  Expanded(
                      child: Text(
                    caption,
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      height: 1.4
                    ),
                    maxLines: 10,
                  ))
                ],
              ),
            ),

            // Bagian foto
            Row(
              children: [
                Container(
                  child: Image(
                    width: MediaQuery.of(context).size.width * 0.85,
                    height: MediaQuery.of(context).size.height * 0.4,
                    alignment: Alignment.bottomLeft,
                    fit: BoxFit.fill,
                    repeat: ImageRepeat.noRepeat,
                    image: NetworkImage(urlFotoStatus),
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
                        icon: Icon(Icons.comment_outlined, color: Colors.black,),
                        onPressed: () {
                          
                        },
                      ),
                      Text(jumlahKomen)
                    ],
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
