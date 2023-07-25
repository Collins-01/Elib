import 'package:elib/feature/onboarding/screens/sign_in/sign_in.dart';
import 'package:elib/feature/onboarding/screens/sign_up/sign_up.dart';
import 'package:elib/helpers/colors.dart';
import 'package:elib/helpers/components/app_icon.dart';
import 'package:elib/helpers/components/button.dart';
import 'package:elib/helpers/navigators.dart';
import 'package:elib/helpers/page_layout/page_layout.dart';
import 'package:elib/helpers/page_layout/text_formating.dart';
import 'package:flutter/cupertino.dart';

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
                  "Helping Computer science\n students study on the go.",
                  maxLines: 3,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: textStyle.copyWith(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w700,
                    color: secondaryColor,
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 100.0,
          ),
          AppButton(
              onPress: () => nextPage(context, (context) => SignIn()),
              title: "login"),
          const SizedBox(
            height: 20.0,
          ),
          AppButton(
              onPress: () => nextPage(context, (context) => const SignUp()),
              borderColor: secondaryColor,
              color: secondaryColor,
              title: "Register"),
          const SizedBox(
            height: 50.0,
          ),
        ],
      ),
    );
  }
}
