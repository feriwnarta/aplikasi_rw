import 'dart:convert';
import 'dart:io';
import 'package:aplikasi_rw/bloc/user_loading_bloc.dart';
import 'package:aplikasi_rw/screen/login_screen/otp_screen.dart';
import 'package:aplikasi_rw/screen/login_screen/register_screen.dart';
import 'package:aplikasi_rw/screen/login_screen/validate/validate_email_and_password.dart';
import 'package:aplikasi_rw/server-app.dart';
import 'package:aplikasi_rw/utils/UserSecureStorage.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  TextEditingController controllerIpl = TextEditingController();
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerNoTelp = TextEditingController();
  UserLoadingBloc bloc;
  bool isLogin = true;

  @override
  Widget build(BuildContext context) {
    mediaSizeHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    mediaSizeWidth = MediaQuery.of(context).size.width;

    bloc = BlocProvider.of<UserLoadingBloc>(context);

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
                width: 95.0.w,
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 4.0.h,
                      ),
                      Image(
                        image: AssetImage('assets/img/logo_rw.png'),
                        height: 13.0.h,
                      ),
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
                                  onPressed: () {
                                    setState(() {
                                      isLogin = true;
                                    });
                                  },
                                  child: Text(
                                    'Login',
                                    style: TextStyle(
                                        color: (isLogin)
                                            ? Colors.white
                                            : Colors.lightBlue[400],
                                        fontSize: 11.0.sp),
                                  ),
                                  color: (isLogin)
                                      ? Colors.lightBlue[400]
                                      : Colors.white,
                                  padding: EdgeInsets.symmetric(
                                      vertical: 0.5.h, horizontal: 10.0.w),
                                ),
                                FlatButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  onPressed: () {
                                    // Navigator.of(context)
                                    //     .push(MaterialPageRoute(
                                    //   builder: (context) => RegisterScreen(),
                                    // ));
                                    setState(() {
                                      isLogin = false;
                                    });
                                  },
                                  child: Text('Register',
                                      style: TextStyle(
                                          color: (isLogin)
                                              ? Colors.lightBlue[400]
                                              : Colors.white,
                                          fontSize: 11.0.sp)),
                                  color: (isLogin)
                                      ? Colors.white
                                      : Colors.lightBlue[400],
                                  padding: EdgeInsets.symmetric(
                                      vertical: 0.5.h, horizontal: 10.0.w),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      // (formLoginOrRegister)
                      (isLogin) ? buildFormLogin() : buildFormRegister(),
                      SizedBox(
                        height: 2.0.h,
                      )
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
                  hintText: 'Insert username or no IPL',
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
          FlatButton(
            child: Text(
              'Log in',
              style: TextStyle(color: Colors.white, fontSize: 11.0.sp),
            ),
            padding: EdgeInsets.symmetric(vertical: 1.8.h, horizontal: 30.0.w),
            color: Colors.lightBlue[400],
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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
                      style: TextStyle(color: Colors.grey, fontSize: 11.0.sp),
                      children: <TextSpan>[
                    TextSpan(
                        text: 'Register',
                        style: TextStyle(color: Colors.blue, fontSize: 11.0.sp),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            setState(() {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => RegisterScreen()));
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
    );
  }

  Form buildFormRegister() {
    return Form(
      key: _formKeyLogin,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25)
                .copyWith(top: 15, bottom: 10),
            child: TextFormField(
              controller: controllerIpl,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  icon: Icon(
                    Icons.person,
                    size: 4.0.h,
                  ),
                  hintText: 'Insert No IPL',
                  hintStyle: TextStyle(fontSize: 12.0.sp),
                  border: UnderlineInputBorder()),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25)
                .copyWith(top: 15, bottom: 10),
            child: Column(
              children: [
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: controllerEmail,
                  decoration: InputDecoration(
                      icon: Icon(
                        Icons.email,
                        size: 4.0.h,
                      ),
                      hintText: 'Email address',
                      hintStyle: TextStyle(fontSize: 12.0.sp),
                      border: UnderlineInputBorder()),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25)
                .copyWith(top: 15, bottom: 25),
            child: Column(
              children: [
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: controllerNoTelp,
                  decoration: InputDecoration(
                      icon: Icon(
                        Icons.phone_android,
                        size: 4.0.h,
                      ),
                      hintText: 'No Telp',
                      hintStyle: TextStyle(fontSize: 12.0.sp),
                      border: UnderlineInputBorder()),
                ),
              ],
            ),
          ),
          FlatButton(
            child: Text(
              'Register',
              style: TextStyle(color: Colors.white, fontSize: 11.0.sp),
            ),
            padding: EdgeInsets.symmetric(vertical: 1.8.h, horizontal: 30.0.w),
            color: Colors.lightBlue[400],
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            onPressed: () {
              userRegister(controllerIpl.text, controllerEmail.text,
                  controllerNoTelp.text);
            },
          ),
          SizedBox(height: 4.0.h)
        ],
      ),
    );
  }

  Future userLogin() async {
    String url = '${ServerApp.url}src/login/login.php';
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
          await UserSecureStorage.setIdUser(message['id_user']);
          await UserSecureStorage.setStatusLogin(message['status']);
          String idUser = await UserSecureStorage.getIdUser();
          if (idUser.isNotEmpty) {
            setState(() {
              bloc.add(UserLoadingEvent());
              Navigator.of(context)
                  .pushNamedAndRemoveUntil('/', (route) => false);
            });
          }
        } else {
          String urlKontraktor = '${ServerApp.url}src/login/login_kontraktor/login_kontraktor.php';
          var dataKontraktor = {
            'username' : controllerUsername.text,
            'password' : controllerPassword.text
          };
          response = await http.post(urlKontraktor, body: json.encode(dataKontraktor));
          message = jsonDecode(response.body);
          if (message != 'login_kontraktor_failed') {
            await UserSecureStorage.setIdUser(message['id_contractor']);
            await UserSecureStorage.setStatusLogin(message['status']);
            String idContractor = await UserSecureStorage.getIdUser();
            if (idContractor.isNotEmpty) {
              setState(() {
                bloc.add(UserLoadingEvent());
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('/', (route) => false);
              });
            }
          }

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

  Future userRegister(String noIpl, String email, String noTelp) async {
    String url = '${ServerApp.url}src/login/register.php';
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.fields['no_ipl'] = noIpl;
    request.fields['email'] = email;
    request.fields['no_telp'] = noTelp;
    request.send().then((value) {
      http.Response.fromStream(value).then((value) {
        String message = json.decode(value.body);
        if (message != null && message.isNotEmpty) {
          if (message == 'email terkirim') {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => OtpScreen(
                      noIpl: controllerIpl.text,
                    )));
          }
        }
      });
    });
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
