import 'package:aplikasi_rw/screen/login_screen/validate/validate_email_and_password.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with ValidationForm {
  final _formKeyLogin = GlobalKey<FormState>();
  double mediaSizeHeight, mediaSizeWidth;
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    mediaSizeHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    mediaSizeWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: mediaSizeHeight * 0.4,
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
                height: mediaSizeHeight * 0.6,
                width: mediaSizeWidth * 0.9,
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: mediaSizeHeight * 0.05,
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
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  color: Colors.lightBlue[400],
                                  padding: EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 30),
                                ),
                                FlatButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  onPressed: () {},
                                  child: Text(
                                    'Register',
                                    style:
                                        TextStyle(color: Colors.lightBlue[400]),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 30),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      Form(
                        key: _formKeyLogin,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(25),
                              child: TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                    icon: Icon(Icons.person),
                                    hintText: 'Insert email or username',
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
                                    decoration: InputDecoration(
                                        icon: Icon(
                                          FontAwesomeIcons.key,
                                          size: 17,
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
                                        border: UnderlineInputBorder()),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      TextButton(
                                        child: Text('Forgot Password ?'),
                                        onPressed: () {},
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      FlatButton(
                        child: Text(
                          'Log in',
                          style: TextStyle(color: Colors.white),
                        ),
                        padding: EdgeInsets.symmetric(
                            vertical: 15, horizontal: mediaSizeWidth * 0.3),
                        color: Colors.lightBlue[400],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        onPressed: () {},
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RichText(
                              text: TextSpan(
                                  text: 'Don\'t have account?',
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                  children: <TextSpan>[
                                TextSpan(
                                    text: ' Register',
                                    style: TextStyle(
                                      color: Colors.blue,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        print('test');
                                      })
                              ]))
                        ],
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
}

// Form(
//           key: _formKeyLogin,
//           child: Column(
//             children: [
//               TextFormField(
//                 keyboardType: TextInputType.emailAddress,
//                 decoration: InputDecoration(
//                     hintText: 'Insert email or username',
//                     border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(5))),
//               )
//             ],
//           ),
//         ),
