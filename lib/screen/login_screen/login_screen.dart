import 'dart:convert';
import 'dart:io';
import 'package:aplikasi_rw/main.dart';
import 'package:aplikasi_rw/screen/login_screen/register_screen.dart';
import 'package:aplikasi_rw/screen/login_screen/validate/validate_email_and_password.dart';
import 'package:aplikasi_rw/utils/UserSecureStorage.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with ValidationForm {
  final _formKeyLogin = GlobalKey<FormState>();
  double mediaSizeHeight, mediaSizeWidth;
  bool _isObscure = true;

  Color buttonLoginRegister = Colors.lightBlue[400];

  TextEditingController controllerUsername = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    mediaSizeHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    mediaSizeWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: 40.0.h,
            decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.only(bottomLeft: Radius.circular(30)),
                image: DecorationImage(
                  image: AssetImage('assets/img/bglogin.jpg'),
                  alignment: Alignment.center,
                  fit: BoxFit.fill,
                  repeat: ImageRepeat.noRepeat,
                )),
          ),
          Center(
            child: SingleChildScrollView(
              child: SizedBox(
                width: 90.0.w,
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 3.0.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 5.0.h,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey[400]),
                                borderRadius: BorderRadius.circular(20)),
                            child: Row(
                              children: [
                                FlatButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  onPressed: () {},
                                  child: Text(
                                    'Login',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 11.0.sp),
                                  ),
                                  color: Colors.lightBlue[400],
                                  padding: EdgeInsets.symmetric(
                                      vertical: 0.5.h, horizontal: 10.0.w),
                                ),
                                FlatButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  onPressed: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) => RegisterScreen(),
                                    ));
                                  },
                                  child: Text('Register',
                                      style: TextStyle(
                                          color: Colors.lightBlue[400],
                                          fontSize: 11.0.sp)),
                                  color: Colors.white,
                                  padding: EdgeInsets.symmetric(
                                      vertical: 0.5.h, horizontal: 10.0.w),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      // (formLoginOrRegister)
                      buildFormLogin(),
                      // : buildFormRegister(),
                      FlatButton(
                        child: Text(
                          'Log in',
                          style:
                              TextStyle(color: Colors.white, fontSize: 11.0.sp),
                        ),
                        padding: EdgeInsets.symmetric(
                            vertical: 1.8.h, horizontal: 30.0.w),
                        color: Colors.lightBlue[400],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        onPressed: () {
                          userLogin();
                        },
                      ),
                      SizedBox(
                        height: 4.0.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RichText(
                              text: TextSpan(
                                  text: 'Don\'t have account? ',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 11.0.sp),
                                  children: <TextSpan>[
                                TextSpan(
                                    text: 'Register',
                                    style: TextStyle(
                                        color: Colors.blue, fontSize: 11.0.sp),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        setState(() {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      RegisterScreen()));
                                        });
                                      })
                              ]))
                        ],
                      ),
                      SizedBox(
                        height: 2.0.h,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Form buildFormLogin() {
    return Form(
      key: _formKeyLogin,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: EdgeInsets.all(25),
            child: TextFormField(
              controller: controllerUsername,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  icon: Icon(
                    Icons.person,
                    size: 4.0.h,
                  ),
                  hintText: 'Insert email or username',
                  hintStyle: TextStyle(fontSize: 12.0.sp),
                  border: UnderlineInputBorder()),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(25),
            child: Column(
              children: [
                TextFormField(
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: _isObscure,
                  controller: controllerPassword,
                  decoration: InputDecoration(
                      icon: Icon(
                        FontAwesomeIcons.key,
                        size: 2.5.h,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon((_isObscure)
                            ? Icons.visibility_off_outlined
                            : Icons.visibility),
                        onPressed: () {
                          setState(() {
                            _isObscure = !_isObscure;
                          });
                        },
                      ),
                      hintText: 'Password',
                      hintStyle: TextStyle(fontSize: 12.0.sp),
                      border: UnderlineInputBorder()),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      child: Text('Forgot Password ?',
                          style: TextStyle(fontSize: 10.0.sp)),
                      onPressed: () {},
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future userLogin() async {
    String url = 'http://192.168.3.76/nextg_mobileapp/src/login.php';
    var message, response;

    var data = {
      'usernameOrEmail': controllerUsername.text,
      'password': controllerPassword.text
    };

    try {
      response = await http.post(url, body: json.encode(data));

      if (response.statusCode >= 400) {
        buildShowDialogAnimation('Error During login', 'OKE',
            'assets/animation/error-animation.json', 15.0); 
      }

      if (response.body.isNotEmpty) {
        message = jsonDecode(response.body);
        if (message != 'login failed') {
          await UserSecureStorage.setIdUser(message);
          String idUser = await UserSecureStorage.getIdUser();

          if (idUser.isNotEmpty) {
            setState(() {
              // Navigator.of(context).pushReplacement(MaterialPageRoute(
              //   builder: (context) => MainApp(),
              // ));
              Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
            });
          }
        } else {
          buildShowDialogAnimation('Email Username Or Password Is Wrong', 'OKE',
              'assets/animation/error-animation.json', 15.0);
        }
      } else {
        buildShowDialogAnimation(
            'Error', 'OKE', 'assets/animation/error-animation.json', 15.0);
      }
    } on SocketException {
      buildShowDialogAnimation(
          'No Internet', 'OKE', 'assets/animation/error-animation.json', 15.0);
    } on HttpException {
      buildShowDialogAnimation(
          'Server Error', 'OKE', 'assets/animation/error-animation.json', 15.0);
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

  Map<String, String> headers = {};

  void getCookie(http.Response response) {
    String rawCookie = response.headers['set-cookie'];
    if (rawCookie != null) {
      int index = rawCookie.indexOf(';');
      headers['cookie'] =
          (index == -1) ? rawCookie : rawCookie.substring(0, index);
    }
  }
}
