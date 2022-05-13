import 'dart:io';

import 'package:aplikasi_rw/screen/login_screen/login_screen.dart';
import 'package:aplikasi_rw/screen/login_screen/validate/validate_email_and_password.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'dart:convert';
import 'package:sizer/sizer.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> with ValidationForm {
  // field stepper
  int currentStep = 0;
  // key form
  final _formKeyAccount = GlobalKey<FormState>();
  final _formKeyContact = GlobalKey<FormState>();
  final _formKeyIdentity = GlobalKey<FormState>();

  // checker visibility password
  bool _isObscureFirst = true;
  bool _isObscureSecond = true;
  // date time
  DateTime date;

  // textfield form controller  account
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerUsername = TextEditingController();
  TextEditingController controllerFirstPassword = TextEditingController();
  TextEditingController controllerConfirmPassword = TextEditingController();

  // textfield form controller contact
  TextEditingController controllerBirthDay = TextEditingController(text: '');
  TextEditingController controllerFullName = TextEditingController();
  TextEditingController controllerAdress = TextEditingController();
  TextEditingController controllerCity = TextEditingController();
  TextEditingController controllerPhone = TextEditingController();

  // textfield form controller identity
  TextEditingController controllerNoKtp = TextEditingController();
  TextEditingController controllerNoKK = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Register',
          style: TextStyle(fontSize: 14.0.sp),
        ),
      ),
      body: Stepper(
          physics: ScrollPhysics(),
          type: StepperType.horizontal,
          currentStep: currentStep,
          controlsBuilder: (context, {onStepCancel, onStepContinue}) {
            return Row(children: [
              Expanded(
                  child: ElevatedButton(
                child: Text(
                  'Next',
                  style: TextStyle(fontSize: 11.0.sp),
                ),
                onPressed: onStepContinue,
              )),
              SizedBox(width: 2.0.w),
              if (currentStep != 0)
                Expanded(
                    child: ElevatedButton(
                  child: Text(
                    'Back',
                    style: TextStyle(fontSize: 11.0.sp),
                  ),
                  onPressed: onStepCancel,
                )),
            ]);
          },
          onStepContinue: () {
            final isLastStep = currentStep == getSteps().length - 1;

            // checker validate step account
            if (currentStep == 0) {
              if (_formKeyAccount.currentState.validate()) {
                setState(() => currentStep++);
              }
            } else if (currentStep == 1) {
              if (_formKeyContact.currentState.validate()) {
                setState(() => currentStep++);
              }
            } else if (currentStep == 2) {
              if (_formKeyIdentity.currentState.validate()) {
                setState(() {
                  if (isLastStep) {
                    userRegistration();
                  } else {
                    currentStep++;
                  }
                });
              }
            }
          },
          onStepCancel: () {
            currentStep > 0 ? setState(() => currentStep--) : currentStep = 0;
          },
          steps: getSteps()),
    );
  }

  List<Step> getSteps() {
    return [stepAccount(), stepContact(), stepIdentity()];
  }

  Step stepIdentity() {
    return Step(
        isActive: currentStep >= 2,
        state: currentStep > 2 ? StepState.complete : StepState.indexed,
        title: Text(
          'Identity',
          style: TextStyle(fontSize: 10.0.sp),
        ),
        content: Form(
          key: _formKeyIdentity,
          child: Column(
            children: [
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 1.0.w, vertical: 1.0.h),
                child: TextFormField(
                  controller: controllerNoKtp,
                  keyboardType: TextInputType.number,
                  style: TextStyle(fontSize: 11.0.sp),
                  validator: (noKtp) => (noKtp.isNotEmpty)
                      ? !isValidInputSpecialCharacters(noKtp)
                          ? 'no ktp must not contain spaces and special characters <>()!#/'
                          : null
                      : null,
                  decoration: InputDecoration(
                      icon: Icon(FontAwesomeIcons.idCard),
                      errorMaxLines: 3,
                      hintText: 'No Ktp',
                      border: UnderlineInputBorder()),
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 1.0.w, vertical: 1.0.h),
                child: TextFormField(
                  controller: controllerNoKK,
                  keyboardType: TextInputType.number,
                  style: TextStyle(fontSize: 11.0.sp),
                  validator: (noKk) => (noKk.isNotEmpty)
                      ? !isValidInputSpecialCharacters(noKk)
                          ? 'no kk must not contain spaces and special characters <>()!#/'
                          : null
                      : null,
                  decoration: InputDecoration(
                      icon: Icon(FontAwesomeIcons.fileAlt),
                      errorMaxLines: 3,
                      hintText: 'No KK',
                      border: UnderlineInputBorder()),
                ),
              ),
              SizedBox(
                height: 2.0.h,
              )
            ],
          ),
        ));
  }

  Step stepContact() {
    return Step(
        isActive: currentStep >= 1,
        state: currentStep > 1 ? StepState.complete : StepState.indexed,
        title: Text(
          'Contact',
          style: TextStyle(fontSize: 10.0.sp),
        ),
        content: Form(
          key: _formKeyContact,
          child: Column(
            children: [
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 1.0.w, vertical: 1.0.h),
                child: TextFormField(
                  controller: controllerFullName,
                  keyboardType: TextInputType.name,
                  style: TextStyle(fontSize: 11.0.sp),
                  decoration: InputDecoration(
                      icon: Icon(Icons.person_outline_sharp),
                      errorMaxLines: 3,
                      hintText: 'Full name',
                      border: UnderlineInputBorder()),
                  validator: (name) => (name.isEmpty)
                      ? 'full name can\'t be empty'
                      : !isValidInputSpecialCharacters(name)
                          ? 'username must not contain spaces and special characters <>()!#/'
                          : null,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5),
                child: TextFormField(
                  controller: controllerBirthDay,
                  keyboardType: TextInputType.datetime,
                  style: TextStyle(fontSize: 11.0.sp),
                  decoration: InputDecoration(
                      icon: Icon(Icons.date_range_outlined),
                      hintText: 'birthday',
                      border: UnderlineInputBorder()),
                  onTap: () {
                    FocusScope.of(context).requestFocus(new FocusNode());
                    pickDate(context).then((_) => controllerBirthDay.text =
                        '${date.day}/${date.month}/${date.year}');
                  },
                  validator: (date) =>
                      (date.isEmpty) ? 'date can\'t be empty' : null,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5),
                child: TextFormField(
                  controller: controllerAdress,
                  keyboardType: TextInputType.streetAddress,
                  style: TextStyle(fontSize: 11.0.sp),
                  decoration: InputDecoration(
                      icon: Icon(Icons.home_outlined),
                      hintText: 'Address',
                      errorMaxLines: 3,
                      border: UnderlineInputBorder()),
                  validator: (address) =>
                      (address.isEmpty) ? 'address can\'t be empty' : null,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5),
                child: TextFormField(
                  controller: controllerCity,
                  keyboardType: TextInputType.streetAddress,
                  style: TextStyle(fontSize: 11.0.sp),
                  decoration: InputDecoration(
                      icon: Icon(Icons.location_city_outlined),
                      errorMaxLines: 3,
                      hintText: 'city',
                      border: UnderlineInputBorder()),
                  validator: (city) =>
                      (city.isEmpty) ? 'city can\'t be empty' : null,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5),
                child: TextFormField(
                  controller: controllerPhone,
                  keyboardType: TextInputType.number,
                  style: TextStyle(fontSize: 11.0.sp),
                  decoration: InputDecoration(
                      icon: Icon(Icons.contact_phone_outlined),
                      hintText: 'Phone',
                      border: UnderlineInputBorder()),
                  validator: (phone) =>
                      (phone.isEmpty) ? 'phone can\'t be empty' : null,
                ),
              ),
              SizedBox(
                height: 20,
              )
            ],
          ),
        ));
  }

  Step stepAccount() {
    return Step(
        isActive: currentStep >= 0,
        state: currentStep > 0 ? StepState.complete : StepState.indexed,
        title: Text('Account', style: TextStyle(fontSize: 10.0.sp)),
        content: Form(
          key: _formKeyAccount,
          child: Column(
            children: [
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 1.0.w, vertical: 1.0.h),
                child: TextFormField(
                  controller: controllerEmail,
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(fontSize: 11.0.sp),
                  validator: (email) =>
                      !isValidEmail(email) ? 'Email not valid' : null,
                  decoration: InputDecoration(
                    icon: Icon(Icons.email_outlined),
                    hintText: 'Email',
                    border: UnderlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 1.0.w, vertical: 1.0.h),
                child: TextFormField(
                  controller: controllerUsername,
                  keyboardType: TextInputType.name,
                  style: TextStyle(fontSize: 11.0.sp),
                  validator: (username) => (username.isEmpty)
                      ? 'username cannot be empty'
                      : (username.length <= 6)
                          ? 'username must be more than 6'
                          : !isValidInputSpecialCharacters(username)
                              ? 'username must not contain spaces and special characters <>()!#'
                              : null,
                  decoration: InputDecoration(
                      icon: Icon(Icons.person_outline_sharp),
                      errorMaxLines: 3,
                      hintText: 'Username',
                      border: UnderlineInputBorder()),
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 1.0.w, vertical: 1.0.h),
                child: Column(
                  children: [
                    TextFormField(
                      controller: controllerFirstPassword,
                      keyboardType: TextInputType.visiblePassword,
                      style: TextStyle(fontSize: 11.0.sp),
                      obscureText: _isObscureFirst,
                      validator: (password) => (!isValidPassword(password)
                          ? 'password not valid, Password must be more than 8 characters containing 1 uppercase letter, 1 lowercase letter, 1 number, and 1 unique characters, example (Myadmin1@, @MyAdm1n, my@dm1NN)'
                          : null),
                      decoration: InputDecoration(
                          icon: Icon(
                            Icons.vpn_key_outlined,
                          ),
                          errorMaxLines: 5,
                          suffixIcon: IconButton(
                            icon: Icon((_isObscureFirst)
                                ? Icons.visibility_off_outlined
                                : Icons.visibility),
                            onPressed: () {
                              setState(() {
                                _isObscureFirst = !_isObscureFirst;
                              });
                            },
                          ),
                          hintText: 'Password',
                          border: UnderlineInputBorder()),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 1.0.w, vertical: 1.0.h),
                child: Column(
                  children: [
                    TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      style: TextStyle(fontSize: 11.0.sp),
                      obscureText: _isObscureSecond,
                      controller: controllerConfirmPassword,
                      validator: (password) =>
                          ((password == controllerFirstPassword.text)
                              ? null
                              : 'passwords are not the same'),
                      decoration: InputDecoration(
                          icon: Icon(
                            Icons.keyboard_return_sharp,
                            size: 20,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon((_isObscureSecond)
                                ? Icons.visibility_off_outlined
                                : Icons.visibility),
                            onPressed: () {
                              setState(() {
                                _isObscureSecond = !_isObscureSecond;
                              });
                            },
                          ),
                          hintText: 'Confirm Password',
                          border: UnderlineInputBorder()),
                    ),
                    SizedBox(height: 20)
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  Future pickDate(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: DateTime(DateTime.now().year - 60),
        lastDate: DateTime(DateTime.now().year + 10));
    if (newDate == null) return;
    setState(() => date = newDate);
  }

  Future userRegistration() async {
    String url = 'http://192.168.3.92/nextg_mobileapp/src/register.php';
    var message, response;


    var data = {
      'email': controllerEmail.text,
      'username': controllerUsername.text,
      'password': controllerConfirmPassword.text,
      'fullname': controllerFullName.text,
      'birthday': controllerBirthDay.text,
      'address': controllerAdress.text,
      'city': controllerCity.text,
      'phone': controllerPhone.text,
      'noktp': controllerNoKtp.text,
      'nokk': controllerNoKK.text
    };

    try {
      response = await http.post(url, body: json.encode(data));

      if (response.statusCode >= 400) {
        buildShowDialogAnimation('Error During Registration', 'OKE',
            'assets/animation/error-animation.json', 15.0);
      }

      if (response.statusCode == 200) {
        if (response.body.isNotEmpty) {
          message = jsonDecode(response.body);
          if (message == 'Register Successful') {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => LoginScreen()));
          } else {
            buildShowDialogAnimation('Email Already Exist', 'OKE',
                'assets/animation/warning-circle-animation.json', 15.0);
          }
        } else {
          buildShowDialogAnimation(
              'Error', 'OKE', 'assets/animation/error-animation.json', 15.0);
        }
      }
    } on SocketException {
      buildShowDialogAnimation(
          'No Internet', 'OKE', 'assets/animation/error-animation.json', 15.0);
    } on HttpException {
      buildShowDialogAnimation(
          'Error', 'OKE', 'assets/animation/error-animation.json', 15.0);
    }
  }

  Future buildShowDialogAnimation(
      String title, String btnMessage, String urlAsset, double size) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              title,
              style: TextStyle(fontSize: 12.0.sp),
            ),
            insetPadding: EdgeInsets.all(10.0.h),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            content: SizedBox(
              width: size.w,
              height: size.h,
              child: LottieBuilder.asset(urlAsset),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text(btnMessage),
                onPressed: () {
                  setState(() {
                    Navigator.of(context).pop();
                  });
                },
              ),
            ],
          );
        });
  }
}
