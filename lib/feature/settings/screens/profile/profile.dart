import 'package:elib/feature/onboarding/services/auth_services.dart';
import 'package:elib/helpers/colors.dart';
import 'package:elib/helpers/components/button.dart';
import 'package:elib/helpers/components/input_field.dart';
import 'package:elib/helpers/error_widget.dart';
import 'package:elib/helpers/loaders.dart';
import 'package:elib/helpers/navigators.dart';
import 'package:elib/helpers/page_layout/page_layout.dart';
import 'package:elib/helpers/page_layout/text_formating.dart';
import 'package:elib/helpers/util_helpers.dart';
import 'package:elib/welcome.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class Profile extends StatefulWidget {
  Profile({Key? key, this.uid}) : super(key: key);
  String? uid;
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return PageLayout(
      title: "Profile",
      leadingNavIconColor: Colors.black,
      appBarColor: Colors.white,
      titleTextColor: Colors.black,
      appBarElevation: 1.1,
      appBarActions: [
        Container(
          width: 80.0,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              color: Color(0xfff1f8e9)),
          child: TextButton(
            onPressed: () {
              showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Log out"),
                      content: Text("Are you sure you want to logout?"),
                      actions: [
                        TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text(
                              "Cancel",
                              style: textStyle(color: Colors.grey),
                            )),
                        TextButton(
                            onPressed: () async {
                              await FirebaseAuth.instance.signOut();
                              final req = await AuthServices()
                                  .logoutUser(context)
                                  .then((value) => nextPageNoPop(context,
                                      (context) => WelcomeOnBoardingPage()));
                            },
                            child: Text(
                              "Proceed",
                            )),
                      ],
                    );
                  });
            },
            child: Text(
              "Logout",
            ),
          ),
        )
      ],
      child: FutureBuilder(
          future: firestore.collection("users").doc("${widget.uid}").get(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const Center(
                child: spinnerPry,
              );
            }
            if (snapshot.hasError) {
              print("${snapshot.error}");
              return ErrorPageWidget();
            }

            final data = snapshot.data;
            print("-===-");
            print("=-090e0iiiie");
            print(data.data());
            print("=-090e0iiiie");
            print("-===-");
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.account_circle_rounded,
                      size: 120.0,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment:CrossAxisAlignment.stretch,
                  children: [
                    InputField(
                      title:"Email",
                    ),
                    const SizedBox(height:24.0,),
                    InputField(
                      title:"Username",
                    ),
                    const SizedBox(height:24.0,),
                    InputField(
                      title:"Phone number",
                    ),
                    const SizedBox(height:24.0,),
                    AppButton()
                  ],
                )
              ],
            );
          }),
    );
  }
}
