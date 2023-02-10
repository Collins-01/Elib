import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:elib/feature/dashboard/screens/dashboard.dart';
import 'package:elib/feature/onboarding/screens/sign_up/sign_up.dart';
import 'package:elib/feature/onboarding/screens/sign_with_google/login_with_google.dart';
import 'package:elib/helpers/colors.dart';
import 'package:elib/helpers/components/app_icon.dart';
import 'package:elib/helpers/components/button.dart';
import 'package:elib/helpers/components/email_input.dart';
import 'package:elib/helpers/components/input_field.dart';
import 'package:elib/helpers/navigators.dart';
import 'package:elib/helpers/page_layout/page_layout.dart';
import 'package:elib/helpers/page_layout/text_formating.dart';
import 'package:elib/helpers/snakbars.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ForgetPassword extends StatefulWidget {
  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  GlobalKey<FormState> _ForgetPasswordFormkey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passWordController = TextEditingController();

  bool _showPassword = true;
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return PageLayout(
        noAppBar: true,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: [
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      // Text("Sign In",
                      //         style:textStyle(
                      //       fontSize: 24.0,
                      //       fontWeight: FontWeight.w700,
                      //     )
                      //   ),
                      AppIcon(
                        width: 130,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 40.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Text("Forget Password",
                              style: textStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.w700,
                              )),
                        ],
                      ),
                      const SizedBox(
                        height: 40.0,
                      ),
                      Form(
                        key: _ForgetPasswordFormkey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            EmailInputField(
                              title: "Enter your email address",
                              controller: _emailController,
                              hintText: "Email Address",
                            ),
                            const SizedBox(
                              height: 24.0,
                            ),
                            const SizedBox(
                              height: 68.0,
                            ),
                            AppButton(
                              loading: _loading,
                              onPress: () {
                                if (_ForgetPasswordFormkey.currentState!
                                    .validate()) {
                                  ForgetPasswordAction(context);
                                }
                              },
                              title: "Forget password",
                            ),
                            const SizedBox(
                              height: 80.0,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ));
  }

  ForgetPasswordAction(context) async {
    final _pref = await SharedPreferences.getInstance();
    final token = _pref.getString("token");
    setState(() {
      _loading = true;
    });

    try {
      final credential = await FirebaseAuth.instance.sendPasswordResetEmail(
        email: _emailController.text.trim(),
      );
      setState(() {
        _loading = false;
      });

      defaultSnackyBar(
          context,
          "Password reset email sent to ${_emailController.text.trim()}",
          successColor);
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      setState(() {
        _loading = false;
      });
      String err = "${e.message}";
      if (e.code == 'user-not-found') {
        err = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        err = 'Wrong password provided for that user.';
      }
      defaultSnackyBar(context, err, dangerColor);
      print(e);
    } catch (e) {
      // print(e);
      defaultSnackyBar(context, "An error occured", dangerColor);
      setState(() {
        _loading = false;
      });
    }
  }
}
