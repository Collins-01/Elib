import 'package:elib/feature/onboarding/screens/sign_in/sign_in.dart';
import 'package:elib/feature/onboarding/screens/sign_up/sign_up.dart';
import 'package:elib/helpers/colors.dart';
import 'package:elib/helpers/components/app_icon.dart';
import 'package:elib/helpers/components/button.dart';
import 'package:elib/helpers/navigators.dart';
import 'package:elib/helpers/page_layout/page_layout.dart';
import 'package:elib/helpers/page_layout/text_formating.dart';
import 'package:flutter/material.dart';

class OnboardingPageScreeen extends StatefulWidget {
  const OnboardingPageScreeen({super.key});

  @override
  State<OnboardingPageScreeen> createState() => _OnboardingPageScreeenState();
}

class _OnboardingPageScreeenState extends State<OnboardingPageScreeen> {
  @override
  Widget build(BuildContext context) {
    return PageLayout(
      noAppBar: true,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppIcon(
                width: 200.0,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  "Learning Made Easy",
                  maxLines: 3,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: textStyle.copyWith(
                    fontSize: 28.0,
                    fontWeight: FontWeight.w700,
                    color: bluePrimaryColor,
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 100.0,
          ),
          AppButton(
            onPress: () => nextPage(context, (context) => const SignUp()),
            // borderColor: bluePrimaryColor,
            color: bluePrimaryColor,
            borderColor: Colors.transparent,
            title: "Sign Up",
          ),
          const SizedBox(
            height: 20.0,
          ),
          // AppButton(
          //   onPress: () => nextPage(context, (context) => const SignIn()),
          //   title: "login",
          // ),
          SizedBox(
            height: 48,
            width: MediaQuery.of(context).size.width * 0.8,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                  side: BorderSide(
                    color: bluePrimaryColor,
                    width: 1.5,
                  ),
                ),
              ),
              onPressed: () => nextPage(context, (context) => const SignIn()),
              child: Text("Login",
                  style: textStyle.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: Colors.black,
                  )),
            ),
          ),
          const SizedBox(
            height: 50.0,
          ),
        ],
      ),
    );
  }
}
