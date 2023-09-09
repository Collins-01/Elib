import 'dart:async';

import 'package:elib/helpers/snakbars.dart';
import 'package:elib/helpers/util_helpers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:elib/feature/dashboard/screens/dashboard.dart';
import 'package:elib/feature/onboarding/screens/sign_in/sign_in.dart';
import 'package:elib/helpers/colors.dart';
import 'package:elib/helpers/components/app_icon.dart';
import 'package:elib/helpers/components/button.dart';
import 'package:elib/helpers/components/email_input.dart';
import 'package:elib/helpers/components/input_field.dart';
import 'package:elib/helpers/components/telephone_input.dart';
import 'package:elib/helpers/navigators.dart';
import 'package:elib/helpers/page_layout/page_layout.dart';
import 'package:elib/helpers/page_layout/text_formating.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final GlobalKey<FormState> _signUpFormkey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneNumeberController = TextEditingController();
  final TextEditingController _matricController = TextEditingController();
  final TextEditingController _passWordController = TextEditingController();

  final bool _showPassword = true;
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
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
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
                              style: textStyle.copyWith(
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
                            InputField(
                              title: "Username",
                              controller: _userNameController,
                              hintText: "John doe",
                            ),
                            const SizedBox(
                              height: 24.0,
                            ),
                            InputField(
                              title: "Firstname",
                              controller: _firstNameController,
                              hintText: "John doe",
                            ),
                            const SizedBox(
                              height: 24.0,
                            ),
                            InputField(
                              title: "Lastname",
                              controller: _lastNameController,
                              hintText: "John doe",
                            ),
                            const SizedBox(
                              height: 24.0,
                            ),
                            InputField(
                              title: "Matric number",
                              controller: _matricController,
                              hintText: "F/HD/20/3210005",
                            ),
                            const SizedBox(
                              height: 24.0,
                            ),
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
                            // InputField(
                            //     title: "Enter password",
                            //     passwordInput: _showPassword,
                            //     controller: _passWordController,
                            //     hintText: "Password",
                            //     suffix: InkWell(
                            //       onTap: () {
                            //         setState(() {
                            //           _showPassword = !_showPassword;
                            //         });
                            //       },
                            //       child: Container(
                            //         width: 20.0,
                            //         child: Image.asset(
                            //           _showPassword
                            //               ? "assets/icons/show_pass.png"
                            //               : "assets/icons/hide_pass.png",
                            //           width: 12.0,
                            //           height: 12.0,
                            //         ),
                            //       ),
                            //     )),
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
                                    child: Text("Forgot Password?",
                                        style: textStyle.copyWith(
                                          decoration: TextDecoration.underline,
                                          color: const Color(0xff114B5F),
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w400,
                                        )),
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
                                  style: textStyle.copyWith(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: const Color.fromRGBO(
                                      30,
                                      30,
                                      30,
                                      0.64,
                                    ),
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),

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
                                        Text("Already have an Account? ",
                                            textAlign: TextAlign.center,
                                            style: textStyle.copyWith(
                                              color: textColor,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                            )),
                                        const SizedBox(
                                          width: 2.0,
                                        ),
                                        InkWell(
                                          onTap: () => nextPage(context,
                                              (context) => const SignIn()),
                                          child: Text(
                                            "Sign in",
                                            textAlign: TextAlign.center,
                                            style: textStyle.copyWith(
                                              color: bluePrimaryColor,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700,
                                            ),
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
                                          style: textStyle.copyWith(
                                              color: textColor,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w400)),
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
                                          style: textStyle.copyWith(
                                              color: textColor,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        const SizedBox(
                                          width: 2.0,
                                        ),
                                        Text("Terms & Conditions",
                                            textAlign: TextAlign.center,
                                            style: textStyle.copyWith(
                                                color: bluePrimaryColor,
                                                fontSize: 13,
                                                fontWeight: FontWeight.w700)),
                                        const SizedBox(
                                          width: 2.0,
                                        ),
                                        Text("and",
                                            textAlign: TextAlign.center,
                                            style: textStyle.copyWith(
                                              color: textColor,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w400,
                                            )),
                                        const SizedBox(
                                          width: 2.0,
                                        ),
                                        Text("Privacy Statement",
                                            textAlign: TextAlign.center,
                                            style: textStyle.copyWith(
                                              color: bluePrimaryColor,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w700,
                                            )),
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

  signUpAction(context, data) async {
    // nextPage(context, (context) => Dashboard());
    final pref = await SharedPreferences.getInstance();
    final token = pref.getString("token");
    setState(() {
      _loading = true;
    });

    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: _emailController.text.trim(),
              password: _userNameController.text.trim());
      setState(() {
        _loading = false;
      });
      print(credential.user!.uid);
      pref.setString("token", credential.user!.uid);
      pref.setString("email", credential.user!.email!);

      // defaultSnackyBar(context, "login successfull", successColor);
      // nextPageNoPop(context, (context) => Dashboard());
      final data = {
        "name": _userNameController.text.trim().toLowerCase(),
        "firstName": _firstNameController.text.trim().toLowerCase(),
        "lastName": _lastNameController.text.trim().toLowerCase(),
        "matricNumber": _matricController.text.trim().toLowerCase(),
        "email": _emailController.text.trim(),
        "phoneNumber": _phoneNumeberController.text.trim(),
        "userId": credential.user!.uid
      };
      addUser(context, data, credential.user!.uid);
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
    } // setState(() {
  }

  addUser(context, userData, uid) async {
    final req = await firestore
        .collection("users")
        .doc(uid)
        .set(userData)
        .whenComplete(() {
      defaultSnackyBar(context, "Sign up successfull.", successColor);
      Timer(
        const Duration(seconds: 3),
        () => nextPageNoPop(context, (context) => const Dashboard()),
      );
    }).catchError((err) {
      setState(() {
        _loading = false;
      });
    });
  }
}
