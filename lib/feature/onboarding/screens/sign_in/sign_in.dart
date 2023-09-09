import 'package:elib/feature/onboarding/screens/forget_password/screens/forget_password.dart';
import 'package:elib/helpers/util_helpers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:elib/feature/dashboard/screens/dashboard.dart';
import 'package:elib/feature/onboarding/screens/sign_up/sign_up.dart';
import 'package:elib/helpers/colors.dart';
import 'package:elib/helpers/components/app_icon.dart';
import 'package:elib/helpers/components/button.dart';
import 'package:elib/helpers/components/input_field.dart';
import 'package:elib/helpers/navigators.dart';
import 'package:elib/helpers/page_layout/page_layout.dart';
import 'package:elib/helpers/page_layout/text_formating.dart';
import 'package:elib/helpers/snakbars.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final GlobalKey<FormState> _signInFormkey = GlobalKey<FormState>();

  final TextEditingController _matricNumberController = TextEditingController();
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
                  const Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
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
                          Text("Login",
                              style: textStyle.copyWith(
                                fontSize: 24.0,
                                fontWeight: FontWeight.w700,
                              ))
                        ],
                      ),
                      const SizedBox(
                        height: 40.0,
                      ),
                      Form(
                        key: _signInFormkey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            InputField(
                              title: "Enter your matric number",
                              controller: _matricNumberController,
                              // hintText: "E.g F/ND/20/3210001",
                              hintText: "PSC1808001",
                            ),
                            const SizedBox(
                              height: 24.0,
                            ),
                            InputField(
                                title: "Enter Lastname",
                                passwordInput: _showPassword,
                                controller: _passWordController,
                                hintText: "Blessing",
                                suffix: InkWell(
                                  onTap: () {
                                    setState(() {
                                      _showPassword = !_showPassword;
                                    });
                                  },
                                  child: SizedBox(
                                    width: 20.0,
                                    child: Image.asset(
                                      _showPassword
                                          ? "assets/icons/show_pass.png"
                                          : "assets/icons/hide_pass.png",
                                      width: 12.0,
                                      height: 12.0,
                                    ),
                                  ),
                                )),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                SizedBox(
                                  child: InkWell(
                                    onTap: () => nextPage(context,
                                        (context) => const ForgetPassword()),
                                    child: Text("Forgot Password?",
                                        style: textStyle.copyWith(
                                          decoration: TextDecoration.underline,
                                          color: bluePrimaryColor,
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
                              color: bluePrimaryColor,
                              loading: _loading,
                              onPress: () {
                                if (_signInFormkey.currentState!.validate()) {
                                  // signInAction(context);
                                  final matric = _matricNumberController.text
                                      .trim()
                                      .toLowerCase();
                                  final pass = _passWordController.text
                                      .trim()
                                      .toLowerCase();
                                  signInWithMatricNumber(context, matric, pass);
                                }
                              },
                              title: "Sign in",
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
                                          30, 30, 30, 0.64)),
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
                                        Text(
                                          "Do not have an account? ",
                                          textAlign: TextAlign.center,
                                          style: textStyle.copyWith(
                                              color: textColor,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        const SizedBox(
                                          width: 2.0,
                                        ),
                                        InkWell(
                                          onTap: () => nextPage(context,
                                              (context) => const SignUp()),
                                          child: Text("Sign up",
                                              textAlign: TextAlign.center,
                                              style: textStyle.copyWith(
                                                color: bluePrimaryColor,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w700,
                                              )),
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

  signInWithMatricNumber(context, matric, pass) async {
    final pref = await SharedPreferences.getInstance();
    setState(() {
      _loading = true;
    });
    try {
      final req = await firestore
          .collection("users")
          .where('matricNumber', isEqualTo: matric)
          .where('lastName', isEqualTo: pass)
          .get()
          .then((value) {
        setState(() {
          _loading = false;
        });
        print(value.docs);
        final data = value.docs;
        if (data.isNotEmpty) {
          final user = data[0].data();
          print(user);
          pref.setString("token", user['userId']);
          pref.setString("email", user['email']);

          defaultSnackyBar(context, "login successfull", successColor);
          nextPageNoPop(context, (context) => const Dashboard());
        } else {
          defaultSnackyBar(context, "User not found", dangerColor);
        }
      }).catchError((err) {
        setState(() {
          _loading = false;
        });
      });
    } catch (e) {
      // print(e);
      defaultSnackyBar(context, "An error occured", dangerColor);
      setState(() {
        _loading = false;
      });
    }
  }

  signInAction(context) async {
    final pref = await SharedPreferences.getInstance();
    final token = pref.getString("token");
    setState(() {
      _loading = true;
    });

    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          // email:"fluffydev007@gmail.com",
          // password:"090Aai###",
          email: _matricNumberController.text.trim(),
          password: _passWordController.text.trim());
      setState(() {
        _loading = false;
      });
      print(credential.user!.uid);
      pref.setString("token", credential.user!.uid);
      pref.setString("email", credential.user!.email!);

      defaultSnackyBar(context, "login successfull", successColor);
      nextPageNoPop(context, (context) => const Dashboard());
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
