import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:elib/helpers/page_layout/text_formating.dart';

class LoginWithGoogle extends StatefulWidget {
  const LoginWithGoogle({Key? key}) : super(key: key);

  @override
  State<LoginWithGoogle> createState() => _LoginWithGoogleState();
}

class _LoginWithGoogleState extends State<LoginWithGoogle> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        // pageToast("Service not available yet.",secondaryPryDangerColor);
        final authUser = await signInWithGoogle();
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color(0xff756E68),
          ),
          borderRadius: BorderRadius.circular(2),
          color: Colors.transparent,
        ),
        height: 46.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 28.0,
              height: 28.0,
              child: SvgPicture.asset("assets/icons/google_icon.svg"),
            ),
            const SizedBox(
              width: 10,
            ),
            Text("Continue with Google",
                style: textStyle.copyWith(
                    color: const Color(0xff473E35),
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }

  Future signInWithGoogle() async {
    // Trigger the authentication flow
    // final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // // Obtain the auth details from the request
    // final GoogleSignInAuthentication? googleAuth =
    //     await googleUser?.authentication;

    // Create a new credential
    // final credential = {
    //    googleAuth?.accessToken,
    //    googleAuth?.idToken,
    // };

    // Once signed in, return the UserCredential
    // return await FirebaseAuth.instance.linkWithGoogleCredential(
    //   idToken: googleAuth?.idToken,
    //   accessToken: googleAuth?.accessToken,
    // );
  }
}
