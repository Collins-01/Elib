import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:elib/feature/dashboard/screens/dashboard.dart';
import 'package:elib/feature/onboarding/screens/sign_in/sign_in.dart';
import 'package:elib/feature/onboarding/screens/sign_up/sign_up.dart';
import 'package:elib/feature/onboarding/screens/sign_with_google/login_with_google.dart';
import 'package:elib/feature/onboarding/services/auth_services.dart';
import 'package:elib/helpers/colors.dart';
import 'package:elib/helpers/components/app_icon.dart';
import 'package:elib/helpers/components/button.dart';
import 'package:elib/helpers/components/email_input.dart';
import 'package:elib/helpers/components/input_field.dart';
import 'package:elib/helpers/components/password_input.dart';
import 'package:elib/helpers/components/telephone_input.dart';
import 'package:elib/helpers/navigators.dart';
import 'package:elib/helpers/page_layout/page_layout.dart';
import 'package:elib/helpers/page_layout/text_formating.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  GlobalKey<FormState> _signUpFormkey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneNumeberController = TextEditingController();
  TextEditingController _passWordController = TextEditingController();

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
                  const SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
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
                          Text("Sign Up",
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
                        key: _signUpFormkey,
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
                            TelephoneInput(
                              title: "Enter your Mobile number",
                              controller: _phoneNumeberController,
                              hintText: "+234 9023687892",
                            ),
                            const SizedBox(
                              height: 24.0,
                            ),
                            InputField(
                              title: "Enter password",
                              passwordInput: _showPassword,
                              controller: _passWordController,
                              hintText: "Password",
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                SizedBox(
                                  child: InkWell(
                                    onTap: null,
                                    // onTap: () => nextPage(context,
                                    // (context) => ResetPasswordEnterEmail()),
                                    child: Text(
                                      "Forgot Password?",
                                      style: textStyle(
                                          decoration: TextDecoration.underline,
                                          color: const Color(0xff114B5F),
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 68.0,
                            ),
                            AppButton(
                              loading: _loading,
                              onPress: () {
                                if (_signUpFormkey.currentState!.validate()) {
                                  final data = {
                                    "phoneNumber":
                                        _phoneNumeberController.text.trim(),
                                    "password": _passWordController.text.trim()
                                  };
                                  signUpAction(context, data);
                                }
                              },
                              title: "Sign Up",
                            ),
                            const SizedBox(
                              height: 8.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Or",
                                  style: textStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: const Color.fromRGBO(
                                          30, 30, 30, 0.64)),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 8.0,
                            ),
                            const LoginWithGoogle(),
                            SizedBox(
                              height: 50.0,
                              child: Stack(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(top: 18.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Already have an Account? ",
                                          textAlign: TextAlign.center,
                                          style: textStyle(
                                              color: textColor,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        const SizedBox(
                                          width: 2.0,
                                        ),
                                        InkWell(
                                          onTap: () => nextPage(
                                              context, (context) => SignIn()),
                                          child: Text(
                                            "Sign in",
                                            textAlign: TextAlign.center,
                                            style: textStyle(
                                                color: primaryColor,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 80.0,
                            ),
                            SizedBox(
                              height: 50.0,
                              child: Stack(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "By Signing in or creating an account, you agree with",
                                        textAlign: TextAlign.center,
                                        style: textStyle(
                                            color: textColor,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(top: 18.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "our",
                                          textAlign: TextAlign.center,
                                          style: textStyle(
                                              color: textColor,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        const SizedBox(
                                          width: 2.0,
                                        ),
                                        Text(
                                          "Terms & Conditions",
                                          textAlign: TextAlign.center,
                                          style: textStyle(
                                              color: primaryColor,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        const SizedBox(
                                          width: 2.0,
                                        ),
                                        Text(
                                          "and",
                                          textAlign: TextAlign.center,
                                          style: textStyle(
                                              color: textColor,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        const SizedBox(
                                          width: 2.0,
                                        ),
                                        Text(
                                          "Privacy Statement",
                                          textAlign: TextAlign.center,
                                          style: textStyle(
                                              color: primaryColor,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
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

  signUpAction(context, data) {
    nextPage(context, (context) => Dashboard());
    // setState(() {
    //   _loading = true;
    // });
    // final req = AuthServices().signUp(data, context).then((value) {
    //   setState(() {
    //     _loading = false;
    //   });
    // }).catchError((err) {
    //   setState(() {
    //     _loading = false;
    //   });
    // });
  }
}
