import 'dart:io';

import 'package:aplikasi_rw/model/category_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:im_stepper/stepper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

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
  Color color = Colors.white;

  @override
  Widget build(BuildContext context) {
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
              enableStepTapping: true,
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
            SizedBox(height: 4.0.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                (activeStep == 0)
                    ? Container(
                        width: 20.0.w,
                      )
                    : RaisedButton(
                        onPressed: () {
                          setState(() {
                            if (activeStep != 0) {
                              activeStep--;
                            }
                          });
                        },
                        color: Colors.blue[400],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),
                        child: Text(
                          'Prev',
                          style:
                              TextStyle(fontSize: 11.0.sp, color: Colors.white),
                        ),
                      ),
                SizedBox(width: 20.0.w),
                RaisedButton(
                  onPressed: () {
                    setState(() {
                      if (activeStep != 2) {
                        activeStep++;
                      }
                    });
                  },
                  color: Colors.blue[400],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  child: Text(
                    'Next',
                    style: TextStyle(fontSize: 11.0.sp, color: Colors.white),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Container stepCompleted() {
    return Container(
      // color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 2.0.h,
          ),
          Text(
            'Description problem',
            style: TextStyle(fontFamily: 'poppins', fontSize: 11.0.sp),
          ),
          SizedBox(
            height: 2.0.h,
          ),
          Container(
            width: 90.0.w,
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.blue[200].withOpacity(0.5),
            ),
            child: Text(
              'Description problem dapat berisi isi permasalahan, tanggal, waktu, jenis pelanggaran, dll',
              softWrap: true,
              maxLines: 2,
              style: TextStyle(color: Colors.blue, fontSize: 11.0.sp),
            ),
          ),
          SizedBox(height: 2.0.h),
          Text('Problem :'),
          SizedBox(height: 1.0.h),
          SizedBox(
            width: 90.0.w,
            child: TextField(
              maxLines: 10,
              maxLength: 2000,
              decoration: InputDecoration(
                  hintText:
                      'contoh: kemalingan motor di daerah sewan, walaupun kondisi ramai pelaku tetap nekat mencuri sepeda motor. minimnya cctv menjadi faktor utama pelaku nekat.',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
              style: TextStyle(fontSize: 12.0.sp),
            ),
          ),
          SizedBox(
            height: 2.0.h,
          ),
          Text(
            'Additional Location Description',
            style: TextStyle(fontFamily: 'poppins', fontSize: 11.0.sp),
          ),
          SizedBox(
            height: 2.0.h,
          ),
          Container(
            width: 90.0.w,
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.blue[200].withOpacity(0.5),
            ),
            child: Text(
              'Additional location description, dapat berisi informasi tambahan mengenai lokasi laporan. Seperti nama gedung, nama jalan, atau ciri khusus dekat sekitar. dll',
              softWrap: true,
              maxLines: 5,
              style: TextStyle(color: Colors.blue, fontSize: 11.0.sp),
            ),
          ),
          SizedBox(height: 2.0.h),
          Text('Location :'),
          SizedBox(height: 1.0.h),
          SizedBox(
            width: 90.0.w,
            child: TextField(
              maxLines: 10,
              maxLength: 2000,
              decoration: InputDecoration(
                  hintText:
                      'contoh: lokasi dekat dengan gedung cisadane. samping warung sembako',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
              style: TextStyle(fontSize: 12.0.sp),
            ),
          ),
          SizedBox(
            height: 2.0.h,
          ),
          Text(
            'Feedback',
            style: TextStyle(fontFamily: 'poppins', fontSize: 11.0.sp),
          ),
          SizedBox(
            height: 2.0.h,
          ),
          Container(
            width: 90.0.w,
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.blue[200].withOpacity(0.5),
            ),
            child: Text(
              'Feedback merupakan bagian saran dan kritik untuk pengelola, agar setiap permasalahan dapat ditangani dengan baik',
              softWrap: true,
              maxLines: 5,
              style: TextStyle(color: Colors.blue, fontSize: 11.0.sp),
            ),
          ),
          SizedBox(height: 2.0.h),
          Text('Location :'),
          SizedBox(height: 1.0.h),
          SizedBox(
            width: 90.0.w,
            child: TextField(
              maxLines: 10,
              maxLength: 2000,
              decoration: InputDecoration(
                  hintText:
                      'contoh: dimohon pengelola setiap tempat yang rawan diberikan cctv',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
              style: TextStyle(fontSize: 12.0.sp),
            ),
          ),
        ],
      ),
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
            'Select Category Report',
            style: TextStyle(fontFamily: 'Poppins', fontSize: 11.0.sp),
          ),
        ),
        SizedBox(height: 2.0.h),
        Container(
          height: 50.0.h,
          child: GridView.builder(
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                // childAspectRatio: 0.05.w / 0.05.h
                // childAspectRatio: 100.0.h / 1100,
                childAspectRatio: 100.0.h / 950,
                crossAxisSpacing: 1.0.w,
                mainAxisSpacing: 1.0.h),
            itemCount: CategoryModel.getCategory.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    CategoryModel.getCategory[index].cardColor =
                        Colors.yellow[500];
                  });
                },
                child: Column(
                  children: [
                    SizedBox(
                      height: 10.0.h,
                      width: 20.0.w,
                      child: Card(
                        elevation: 5,
                        color: CategoryModel.getCategory[index].cardColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: Container(
                          child: Icon(
                            CategoryModel.getCategory[index].icon,
                            color: CategoryModel.getCategory[index].iconColor,
                          ),
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        Text(
                          CategoryModel.getCategory[index].title,
                          style: TextStyle(
                              fontSize: 9.0.sp, fontFamily: 'poppins'),
                          softWrap: true,
                          maxLines: 3,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ],
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

  Future getImage(ImageSource source) async {
    final pickedFile = await _picker.getImage(source: source);
    if (pickedFile != null) {
      imagePath = pickedFile.path;
    }
  }
}
