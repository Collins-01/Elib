import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:elib/feature/onboarding/screens/sign_in/sign_in.dart';
import 'package:elib/feature/onboarding/screens/sign_up/sign_up.dart';
import 'package:elib/helpers/navigators.dart';
import 'package:elib/helpers/page_layout/text_formating.dart';

class WelcomeOnBoardingPage extends StatefulWidget {
  @override
  _WelcomeOnBoardingPageState createState() => _WelcomeOnBoardingPageState();
}

class _WelcomeOnBoardingPageState extends State<WelcomeOnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    nextPage(context, (context) => SignIn());
  }

  Widget _buildFullscreenImage(image) {
    return Image.asset(
      '${image}',
      fit: BoxFit.cover,
      height: double.infinity,
      width: double.infinity,
      alignment: Alignment.center,
    );
  }

  // Widget _buildImage(String assetName, [double width = 350]) {
  //   return Image.asset('assets/$assetName', width: width);
  // }

  @override
  Widget build(BuildContext context) {
    final bodyStyle = textStyle(fontSize: 16.0);

    final pageDecoration = PageDecoration(
      titleTextStyle: textStyle(fontSize: 24.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 8.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
      imageFlex: 3,
    );

    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: Colors.white,

      pages: [
        PageViewModel(
          title: "Catch up with exclusives",
          body: "Watch real time exclusive shows whenever you like!",
          image: _buildFullscreenImage("assets/welcome/1.jpg"),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Join the fun",
          body: "Watch, share, upload, etc, short videos on the eliby T.V app",
          image: _buildFullscreenImage("assets/welcome/2.jpg"),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Stay updated",
          body:
              "Read latest news on different industries of your choice at a go. ",
          image: _buildFullscreenImage("assets/welcome/3.jpg"),
          decoration: pageDecoration,
        ),
      ],
      onDone: () => _onIntroEnd(context),
      //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: false,
      skipOrBackFlex: 0,
      nextFlex: 0,
      showBackButton: true,
      //rtl: true, // Display as right-to-left
      back: const Icon(Icons.arrow_back),
      skip: const Text('Skip', style: TextStyle(fontWeight: FontWeight.w600)),
      next: const Icon(Icons.arrow_forward),
      done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      controlsPadding: kIsWeb
          ? const EdgeInsets.all(12.0)
          : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      dotsContainerDecorator: const ShapeDecoration(
        color: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
    );
  }
}
