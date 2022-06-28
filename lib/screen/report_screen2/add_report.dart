import 'dart:io';
import 'package:aplikasi_rw/bloc/report_bloc.dart';
import 'package:aplikasi_rw/server-app.dart';
import 'package:aplikasi_rw/services/category_detail_services.dart';
import 'package:aplikasi_rw/services/category_services.dart';
import 'package:aplikasi_rw/services/klasifikasi_category_services.dart';
import 'package:aplikasi_rw/utils/UserSecureStorage.dart';
import 'package:aplikasi_rw/model/category_model.dart';
import 'package:aplikasi_rw/services/report_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:im_stepper/stepper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:aplikasi_rw/screen/loading_send_screen.dart';

import 'google_maps_screen.dart';

class AddReport extends StatefulWidget {
  @override
  State<AddReport> createState() => _AddReportState();
}

class _AddReportState extends State<AddReport> {
  int activeStep = 0;
  final _picker = ImagePicker();
  String imagePath = '';
  PickedFile imageFile;
  bool isVisibility = false;
  bool isVisibilityGuid = true;
  String idCategory, address;
  Color color = Colors.white;
  String idUser;
  Future _future;
  String title = 'Select Category Report';

  TextEditingController controllerDescription = TextEditingController();
  TextEditingController controllerAdditionalLocation = TextEditingController();
  TextEditingController controllerFeedBack = TextEditingController();

  final _formKeyError = GlobalKey<FormState>();
  String categoryPicked;
  String idCategoryDetail;
  String icon;
  bool check = false;
  var selectedIndex = [];
  List<String> klasifikasiPicked = [];
  List<String> nameKlasifikasi = [];

  // flutter maps
  double latitude, longitude;

  @override
  void initState() {
    _future = UserSecureStorage.getIdUser();
    super.initState();
  }

  @override
  void dispose() {
    latitude = null;
    longitude = null;
    categoryPicked = null;
    idCategoryDetail = null;
    klasifikasiPicked = [];
    selectedIndex = [];
    super.dispose();
  }

  ReportBloc bloc;

  @override
  Widget build(BuildContext context) {
    bloc = BlocProvider.of<ReportBloc>(context);

    return Scaffold(
      // backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          'Create Report',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            IconStepper(
              enableNextPreviousButtons: false,
              activeStepColor: Colors.blue[400],
              enableStepTapping: false,
              icons: [
                Icon(
                  Icons.camera_alt,
                  color: Colors.white,
                  size: 12,
                ),
                Icon(
                  Icons.category,
                  color: Colors.white,
                ),
                Icon(
                  FontAwesomeIcons.clipboardCheck,
                  color: Colors.white,
                )
              ],
              activeStep: activeStep,
              onStepReached: (index) {
                setState(() {
                  activeStep = index;
                });
              },
            ),
            (activeStep == 0)
                ? stepCamera()
                : (activeStep == 1)
                    ? stepKategory()
                    : stepCompleted(),
            SizedBox(height: 2.0.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                (activeStep == 0)
                    ? Container(
                        width: 20.0.w,
                      )
                    : (activeStep == 1)
                        ? (idCategory == null)
                            ? SizedBox(
                                width: 40.0.w,
                                child: RaisedButton(
                                  onPressed: () {
                                    setState(() {
                                      if (activeStep != 0) {
                                        activeStep--;
                                        isVisibility = true;
                                      }
                                    });
                                  },
                                  color: Colors.blue[400],
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Text(
                                    'Prev',
                                    style: TextStyle(
                                        fontSize: 11.0.sp, color: Colors.white),
                                  ),
                                ),
                              )
                            : (idCategoryDetail != null)
                                ? SizedBox(
                                    width: 40.0.w,
                                    child: RaisedButton(
                                      onPressed: () {
                                        setState(() {
                                          idCategoryDetail = null;
                                          selectedIndex = [];
                                          klasifikasiPicked = [];
                                          title = 'Detail report';
                                        });
                                      },
                                      color: Colors.blue[400],
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Text(
                                        'Prev',
                                        style: TextStyle(
                                            fontSize: 11.0.sp,
                                            color: Colors.white),
                                      ),
                                    ),
                                  )
                                : SizedBox(
                                    width: 40.0.w,
                                    child: RaisedButton(
                                      onPressed: () {
                                        setState(() {
                                          idCategory = null;
                                          title = 'Select category report';
                                          selectedIndex = [];
                                          klasifikasiPicked = [];
                                        });
                                      },
                                      color: Colors.blue[400],
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Text(
                                        'Prev',
                                        style: TextStyle(
                                            fontSize: 11.0.sp,
                                            color: Colors.white),
                                      ),
                                    ),
                                  )
                        : SizedBox(
                            width: 40.0.w,
                            child: RaisedButton(
                              onPressed: () {
                                setState(() {
                                  if (activeStep != 0) {
                                    activeStep--;
                                  }
                                });
                              },
                              color: Colors.blue[400],
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              child: Text(
                                'Prev',
                                style: TextStyle(
                                    fontSize: 11.0.sp, color: Colors.white),
                              ),
                            ),
                          ),
                (isVisibility)
                    ? SizedBox()
                    : SizedBox(
                        width: 30.0.w,
                      ),
                Visibility(
                  visible: (isVisibility) ? true : false,
                  child: SizedBox(
                    width: 40.0.w,
                    child: RaisedButton(
                      onPressed: () {
                        setState(() {
                          if (activeStep == 0) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MapSample(),
                                )).then((value) {
                              if (value != null) {
                                latitude = value[0];
                                longitude = value[1];
                                address = value[2];
                                print('${latitude} ${longitude} ${address}');
                                if (activeStep == 0) {
                                  setState(() {
                                    activeStep++;
                                  });
                                }
                              }
                            });
                          }
                          if (activeStep != 2) {
                            if (latitude != null) {
                              activeStep++;
                            }
                            if (activeStep == 1 && klasifikasiPicked.isEmpty) {
                              setState(() {
                                isVisibility = !isVisibility;
                              });
                            }
                          } else {
                            if (_formKeyError.currentState.validate()) {
                              String stringKlasifikasi = "";
                              klasifikasiPicked.forEach((element) {
                                stringKlasifikasi += element + ',';
                              });
                              ReportServices.sendDataReport(
                                      description: controllerDescription.text,
                                      category: categoryPicked,
                                      idUser: idUser,
                                      imgPath: imagePath,
                                      idCategory: idCategory,
                                      latitude: latitude.toString(),
                                      longitude: longitude.toString(),
                                      idKlasifikasiCategory: stringKlasifikasi,
                                      status: 'listed')
                                  .then((value) {
                                showLoading(context);
                                value.send().then((value) {
                                  http.Response.fromStream(value).then((value) {
                                    String message = json.decode(value.body);
                                    if (message != null && message.isNotEmpty) {
                                      Navigator.of(context)
                                          .popUntil((route) => route.isFirst);
                                      bloc.add(ReportEventRefresh());
                                    }
                                  });
                                });
                              });
                            }
                          }
                        });
                      },
                      color: Colors.blue[400],
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(
                        (activeStep) != 2 ? 'Next' : 'Send',
                        style:
                            TextStyle(fontSize: 11.0.sp, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 3.0.h,
            )
          ],
        ),
      ),
    );
  }

  FutureBuilder stepCompleted() {
    return FutureBuilder<String>(
      future: _future,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            idUser = snapshot.data;
            return Container(
              // color: Colors.white,
              child: Form(
                key: _formKeyError,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 95.0.w,
                      child: Card(
                        elevation: 10.0,
                        color: Colors.blueAccent[100],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 5),
                                    child: Text(
                                      'Details',
                                      style: TextStyle(
                                          color: Colors.blueAccent[100],
                                          fontWeight: FontWeight.bold),
                                    ),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                  ),
                                  SizedBox(
                                    width: 19.0.w,
                                  ),
                                  Container(
                                      height: 10.0.h,
                                      width: 10.0.w,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  '${ServerApp.url}icon/$icon')))),
                                  SizedBox(
                                    width: 1.5.w,
                                  ),
                                  Text('$categoryPicked',
                                      style: TextStyle(
                                          fontSize: 10.0.sp,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                              SizedBox(height: 1.0.h),
                              Text(
                                'Complaint',
                                style: TextStyle(
                                    fontSize: 9.0.sp,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 1.5.h,
                              ),
                              ListView.builder(
                                itemCount: nameKlasifikasi.length,
                                shrinkWrap: true,
                                physics: ScrollPhysics(),
                                itemBuilder: (context, index) => Column(
                                  children: [
                                    Row(
                                      children: [
                                        Icon(FontAwesomeIcons.exclamationCircle,
                                            color: Colors.red),
                                        SizedBox(width: 1.0.w),
                                        Text(
                                          '${nameKlasifikasi[index]}',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 1.0.h,
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(height: 1.5.h)
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 2.0.h,
                    ),
                    Text(
                      'Description problem',
                      style:
                          TextStyle(fontFamily: 'poppins', fontSize: 11.0.sp),
                    ),
                    SizedBox(
                      height: 2.0.h,
                    ),
                    Container(
                      width: 95.0.w,
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blue[200].withOpacity(0.5),
                      ),
                      child: Text(
                        'Description problem dapat berisi detail permasalahan',
                        softWrap: true,
                        maxLines: 2,
                        style: TextStyle(color: Colors.blue, fontSize: 11.0.sp),
                      ),
                    ),
                    SizedBox(height: 2.0.h),
                    Text('Problem :'),
                    SizedBox(height: 1.0.h),
                    SizedBox(
                      width: 95.0.w,
                      child: TextFormField(
                        maxLines: 10,
                        maxLength: 2000,
                        controller: controllerDescription,
                        keyboardType: TextInputType.name,
                        style: TextStyle(fontSize: 12.0.sp),
                        validator: (description) => (description.isEmpty)
                            ? 'form problem tidak boleh kosong'
                            : (description.length < 10)
                                ? 'minimal kata harus lebih dari 10 karakter'
                                : null,
                        decoration: InputDecoration(
                            errorMaxLines: 3,
                            hintText:
                                'contoh: pohon di cluster Ebony dekat rumah pak udin hampir rubuh',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ),
                    ),
                    SizedBox(
                      height: 2.0.h,
                    ),
                    // Text(
                    //   'Additional Location Description',
                    //   style:
                    //       TextStyle(fontFamily: 'poppins', fontSize: 11.0.sp),
                    // ),
                    // SizedBox(
                    //   height: 2.0.h,
                    // ),
                    // Container(
                    //   width: 90.0.w,
                    //   padding: EdgeInsets.all(15),
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(10),
                    //     color: Colors.blue[200].withOpacity(0.5),
                    //   ),
                    //   child: Text(
                    //     'Additional location description, dapat berisi informasi tambahan mengenai lokasi laporan. Seperti nama gedung, nama jalan, atau ciri khusus dekat sekitar. dll',
                    //     softWrap: true,
                    //     maxLines: 5,
                    //     style: TextStyle(color: Colors.blue, fontSize: 11.0.sp),
                    //   ),
                    // ),
                    // SizedBox(height: 2.0.h),
                    // Text('Location :'),
                    // SizedBox(height: 1.0.h),
                    // SizedBox(
                    //   width: 90.0.w,
                    //   child: TextFormField(
                    //     maxLines: 10,
                    //     maxLength: 2000,
                    //     controller: controllerAdditionalLocation,
                    //     keyboardType: TextInputType.name,
                    //     style: TextStyle(fontSize: 12.0.sp),
                    //     validator: (description) => (description.isEmpty)
                    //         ? 'form additional location tidak boleh kosong'
                    //         : (description.length < 10)
                    //             ? 'minimal kata harus lebih 10 karakter'
                    //             : null,
                    //     decoration: InputDecoration(
                    //         errorMaxLines: 3,
                    //         hintText:
                    //             'contoh: lokasi dekat dengan gedung cisadane. samping warung sembako',
                    //         border: OutlineInputBorder(
                    //             borderRadius: BorderRadius.circular(10))),
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: 2.0.h,
                    // ),
                    // Text(
                    //   'Feedback',
                    //   style:
                    //       TextStyle(fontFamily: 'poppins', fontSize: 11.0.sp),
                    // ),
                    // SizedBox(
                    //   height: 2.0.h,
                    // ),
                    // Container(
                    //   width: 90.0.w,
                    //   padding: EdgeInsets.all(15),
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(10),
                    //     color: Colors.blue[200].withOpacity(0.5),
                    //   ),
                    //   child: Text(
                    //     'Feedback merupakan bagian saran dan kritik untuk pengelola, agar setiap permasalahan dapat ditangani dengan baik',
                    //     softWrap: true,
                    //     maxLines: 5,
                    //     style: TextStyle(color: Colors.blue, fontSize: 11.0.sp),
                    //   ),
                    // ),
                    // SizedBox(height: 2.0.h),
                    // Text('Feedback :'),
                    // SizedBox(height: 1.0.h),
                    // SizedBox(
                    //   width: 90.0.w,
                    //   child: TextFormField(
                    //     maxLines: 10,
                    //     maxLength: 2000,
                    //     controller: controllerFeedBack,
                    //     keyboardType: TextInputType.name,
                    //     style: TextStyle(fontSize: 12.0.sp),
                    //     // validator: (description) => (description.isEmpty)
                    //     //     ? 'form feedback tidak boleh kosong'
                    //     //     : (description.length < 50)
                    //     //         ? 'minimal kata harus lebih dari 50 karakter'
                    //     //         : null,
                    //     decoration: InputDecoration(
                    //         errorMaxLines: 3,
                    //         hintText:
                    //             'contoh: dimohon pengelola setiap tempat yang rawan diberikan cctv',
                    //         border: OutlineInputBorder(
                    //             borderRadius: BorderRadius.circular(10))),
                    //   ),
                    // ),
                  ],
                ),
              ),
            );
          default:
            if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
        }
      },
    );
  }

  Column stepKategory() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 2.0.h,
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 3.0.w),
          child: Text(
            title,
            style: TextStyle(fontFamily: 'Poppins', fontSize: 11.0.sp),
          ),
        ),
        SizedBox(height: 2.0.h),
        Container(
          height: 50.0.h,
          child: FutureBuilder<List<CategoryModel>>(
              future: CategoryServices.getCategory(),
              builder: (_, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return Container(
                        child: Center(child: CircularProgressIndicator()));
                  case ConnectionState.done:
                    return (idCategory == null)
                        ? gridViewCategory(snapshot.data)
                        : viewKlasifikasiCategory(idCategory);
                  default:
                    if (snapshot.hasError)
                      return new Text('Error: ${snapshot.error}');
                    return Container(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                }
              }),
        ),
      ],
    );
  }

  FutureBuilder<List<KlasifikasiCategory>> viewKlasifikasiCategory(
      String idCategory) {
    return FutureBuilder<List<KlasifikasiCategory>>(
        future: KlasifikasiCategoryServices.getKlasifikasiCategory(idCategory),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Container(
                  child: Center(child: CircularProgressIndicator()));
            case ConnectionState.done:
              return ListView.builder(
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return buildCheckboxListTile(
                        snapshot.data[index].klasifikasi,
                        index,
                        snapshot.data[index].idKlasifikasi);
                  });
            default:
              if (snapshot.hasError)
                return new Text('Error: ${snapshot.error}');
              return Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
          }
        });
  }

  CheckboxListTile buildCheckboxListTile(
      String klasifikasi, int index, String idKlasifikasi) {
    return CheckboxListTile(
      controlAffinity: ListTileControlAffinity.leading,
      activeColor: Colors.blue,
      value: selectedIndex.contains(index),
      title: Text(
        klasifikasi,
        textAlign: TextAlign.left,
      ),
      onChanged: (value) {
        setState(() {
          if (selectedIndex.contains(index)) {
            selectedIndex.remove(index);
            klasifikasiPicked.remove(idKlasifikasi);
            nameKlasifikasi.remove(klasifikasi);
            if (klasifikasiPicked.isEmpty) {
              isVisibility = false;
            }
            print(klasifikasiPicked);
          } else {
            selectedIndex.add(index);
            klasifikasiPicked.add(idKlasifikasi);
            nameKlasifikasi.add(klasifikasi);
            isVisibility = true;
            print(klasifikasiPicked);
          }
        });
      },
    );
  }

  FutureBuilder<List<CategoryDetailModel>> gridViewCategoryDetail() {
    return FutureBuilder<List<CategoryDetailModel>>(
        future: CategoryDetailServices.getCategoryDetail(idCategory),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Container(
                  child: Center(child: CircularProgressIndicator()));
            case ConnectionState.done:
              return GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  // childAspectRatio: 0.05.w / 0.05.h
                  // childAspectRatio: 100.0.h / 1100,
                  childAspectRatio: 100.0.h / 1100,
                  // crossAxisSpacing: 0.05.h,
                  // mainAxisSpacing: 0.02.h
                ),
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      SizedBox(
                        height: 10.0.h,
                        width: 20.0.w,
                        child: Card(
                          elevation: 7,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          child: Container(
                              child: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      idCategoryDetail =
                                          snapshot.data[index].idCategoryDetail;
                                      title = 'Klasifikasi Report';
                                    });
                                  },
                                  icon: Image.network(
                                      '${ServerApp.url}/icon/${snapshot.data[index].iconDetail}'))),
                        ),
                      ),
                      Column(
                        children: [
                          Text(
                            snapshot.data[index].namecategoryDetail,
                            style: TextStyle(
                                fontSize: 9.0.sp, fontFamily: 'poppins'),
                            softWrap: true,
                            maxLines: 3,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      )
                    ],
                  );
                },
              );
            default:
              if (snapshot.hasError)
                return new Text('Error: ${snapshot.error}');
              return Container();
          }
        });
  }

  GridView gridViewCategory(List<CategoryModel> category) {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          // childAspectRatio: 0.05.w / 0.05.h
          // childAspectRatio: 100.0.h / 1100,
          childAspectRatio: 100.0.h / 900,
          crossAxisSpacing: 0.5.w,
          mainAxisSpacing: 0.7.h),
      itemCount: category.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            SizedBox(
              height: 10.0.h,
              width: 20.0.w,
              child: Card(
                elevation: 7,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Container(
                    child: IconButton(
                        onPressed: () {
                          setState(() {
                            idCategory = '${category[index].idCategory}';
                            categoryPicked = '${category[index].category}';
                            icon = '${category[index].icon}';
                            title = 'Detail Report';
                          });
                        },
                        icon: Image.network(
                            '${ServerApp.url}/icon/${category[index].icon}'))),
              ),
            ),
            Column(
              children: [
                Text(
                  category[index].category,
                  style: TextStyle(fontSize: 9.0.sp, fontFamily: 'poppins'),
                  softWrap: true,
                  maxLines: 3,
                  textAlign: TextAlign.center,
                ),
              ],
            )
          ],
        );
      },
    );
  }

  Container stepCamera() {
    return Container(
      child: Column(
        children: [
          Visibility(
            visible: isVisibility,
            child: Container(
              height: 55.0.h,
              // color: Colors.grey,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: FileImage(File(imagePath)),
                      fit: BoxFit.cover,
                      repeat: ImageRepeat.noRepeat)),
            ),
          ),
          SizedBox(height: 2.0.h),
          Visibility(
            visible: isVisibilityGuid,
            child: Container(
              width: 90.0.w,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.blue[400],
                  borderRadius: BorderRadius.circular(10)),
              child: Text(
                'Klik icon camera untuk memfoto langsung laporan, atau icon gallery untuk langsung memilih gambar yang ada di gallery',
                style: TextStyle(
                    fontSize: 12.0.sp,
                    color: Colors.white,
                    fontFamily: 'PT Sans Narrow'),
              ),
            ),
          ),
          SizedBox(height: 2.0.h),
          Container(
            height: 7.0.h,
            width: 50.0.w,
            decoration: BoxDecoration(
                color: Colors.green[300],
                borderRadius: BorderRadius.circular(10)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Material(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(100),
                  child: Padding(
                    padding: EdgeInsets.only(right: 1.5.w),
                    child: IconButton(
                      icon: Icon(
                        Icons.camera_alt,
                        size: 5.0.h,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        getImage(ImageSource.camera)
                            .whenComplete(() => setState(() {
                                  isVisibility = true;
                                  isVisibilityGuid = false;
                                }));
                      },
                    ),
                  ),
                ),
                Material(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(100),
                  child: Padding(
                    padding: EdgeInsets.only(right: 1.5.w),
                    child: IconButton(
                      icon: Icon(
                        Icons.image,
                        size: 5.0.h,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        getImage(ImageSource.gallery)
                            .whenComplete(() => setState(() {
                                  isVisibility = true;
                                  isVisibilityGuid = false;
                                }));
                      },
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  String validatorTextField(String text) {
    if (text.isEmpty) {
      return 'Form tidak boleh kosong';
    } else if (text.length < 50) {
      return 'Minimal kata 50 karakter';
    } else {
      return null;
    }
  }

  Future getImage(ImageSource source) async {
    final pickedFile = await _picker.getImage(source: source, imageQuality: 50);
    if (pickedFile != null) {
      imagePath = pickedFile.path;
    }
  }
}
