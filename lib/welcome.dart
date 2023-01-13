import 'package:elib/feature/onboarding/screens/onboarding.dart';
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


  @override
  Widget build(BuildContext context) {
    return const OnboardingPageScreeen();
  }
}
