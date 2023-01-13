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

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  GlobalKey<FormState> _signInFormkey = GlobalKey<FormState>();

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
                          Text("Sign In",
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
                        key: _signInFormkey,
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
                            InputField(
                              title: "Enter password",
                              passwordInput: _showPassword,
                              controller: _passWordController,
                              hintText: "Password",
                              suffix: InkWell(
                                  onTap: () {
                                    setState(() {
                                     _showPassword = !_showPassword;
                                    });
                                  },
                                  child: Container(
                                    width: 20.0,
                                    child: Image.asset(
                                      _showPassword
                                          ? "assets/icons/show_pass.png"
                                          : "assets/icons/hide_pass.png",
                                      width: 12.0,
                                      height: 12.0,
                                    ),
                                  ),
                                )
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
                                if (_signInFormkey.currentState!.validate()) {
                                  signInAction(context);
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
                                  style: textStyle(
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
                                              context, (context) => SignUp()),
                                          child: Text(
                                            "Sign up",
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

  signInAction(context) async {
    final _pref = await SharedPreferences.getInstance();
    final token = _pref.getString("token");
    setState(() {
      _loading = true;
    });

    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          // email:"fluffydev007@gmail.com",
          // password:"090Aai###",
          email: _emailController.text.trim(),
          password: _passWordController.text.trim());
      setState(() {
        _loading = false;
      });
      print(credential.user!.uid);
      _pref.setString("token", credential.user!.uid);
      _pref.setString("email", credential.user!.email!);
      
      defaultSnackyBar(context,"login successfull",successColor);
      nextPageNoPop(context, (context) => Dashboard());
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
