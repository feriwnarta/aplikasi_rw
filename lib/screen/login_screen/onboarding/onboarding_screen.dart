import 'package:aplikasi_rw/screen/login_screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:lottie/lottie.dart';

//ignore: must_be_immutable
class OnboardingScreen extends StatelessWidget {
  double mediaSizeHeight, mediaSizeWidth;

  @override
  Widget build(BuildContext context) {
    mediaSizeHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    mediaSizeWidth = MediaQuery.of(context).size.width;

    return IntroductionScreen(
      pages: [
        PageViewModel(
            title: 'housing management made easier',
            body:
                'socialize and all your environmental needs will be made easier',
            image: LottieBuilder.asset('assets/animation/onboard1.json'),

            // image:
            //     Image(image: AssetImage('assets/img/image-onboarding/bg1.png')),
            decoration: buildPageDecoration(
                pageColor: Colors.blue[100].withOpacity(0.5))),
        PageViewModel(
            title: 'report it and we will deal with it immediately',
            body:
                'report directly through the application, and we will handle it immediately',
            image: LottieBuilder.asset('assets/animation/onboard2.json'),
            // image:
            //     Image(image: AssetImage('assets/img/image-onboarding/bg2.png')),
            decoration: buildPageDecoration(
                pageColor: Colors.green[100].withOpacity(0.5))),
        PageViewModel(
            title: 'payment process via app',
            body: 'Pay every bill easily by uploading screenshot proof',
            // image:Image(image: AssetImage('assets/img/image-onboarding/bg3.png')),
            image: LottieBuilder.asset('assets/animation/onboard3.json'),
            footer: FlatButton(
              textColor: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 35),
              child: Text(
                'Login',
              ),
              color: Colors.blue,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              },
            ),
            decoration: buildPageDecoration(
                pageColor: Colors.yellow[100].withOpacity(0.5))),
      ],
      done: Text(
        'Login',
        style: TextStyle(fontFamily: 'poppins', fontSize: 16),
      ),
      onDone: () {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => LoginScreen()));
      },
      showSkipButton: true,
      skip: Text(
        'SKIP',
        style: TextStyle(fontFamily: 'poppins', fontSize: 16),
      ),
      next: Icon(
        Icons.arrow_forward,
        size: 25,
      ),
      dotsDecorator: buildDotsDecorator(),
    );
  }

  DotsDecorator buildDotsDecorator() {
    return DotsDecorator(
        color: Colors.lightBlue,
        activeColor: Colors.blue,
        size: Size.square(10),
        activeSize: Size(mediaSizeWidth * 0.08, 12),
        activeShape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)));
  }

  PageDecoration buildPageDecoration({Color pageColor}) {
    return PageDecoration(
        titleTextStyle: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
        imagePadding: EdgeInsets.only(top: 90),
        contentPadding: EdgeInsets.all(20),
        pageColor: pageColor ?? Colors.white,
        bodyTextStyle: TextStyle(
          fontSize: 21,
          fontWeight: FontWeight.bold,
        ));
  }
}
