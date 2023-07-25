import 'package:elib/feature/onboarding/services/auth_services.dart';
import 'package:elib/helpers/colors.dart';
import 'package:elib/helpers/components/button.dart';
import 'package:elib/helpers/components/input_field.dart';
import 'package:elib/helpers/error_widget.dart';
import 'package:elib/helpers/loaders.dart';
import 'package:elib/helpers/navigators.dart';
import 'package:elib/helpers/page_layout/page_layout.dart';
import 'package:elib/helpers/page_layout/text_formating.dart';
import 'package:elib/helpers/snakbars.dart';
import 'package:elib/helpers/util_helpers.dart';
import 'package:elib/welcome.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
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
              color: const Color(0xfff1f8e9)),
          child: TextButton(
            onPressed: () {
              showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text("Log out"),
                      content: const Text("Are you sure you want to logout?"),
                      actions: [
                        TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text(
                              "Cancel",
                              style: textStyle.copyWith(color: Colors.grey),
                            )),
                        TextButton(
                            onPressed: () async {
                              await FirebaseAuth.instance.signOut();
                              final req = await AuthServices()
                                  .logoutUser(context)
                                  .then((value) => nextPageNoPop(
                                      context,
                                      (context) =>
                                          const WelcomeOnBoardingPage()));
                            },
                            child: const Text(
                              "Proceed",
                            )),
                      ],
                    );
                  });
            },
            child: const Text(
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
              return const ErrorPageWidget();
            }

            final data = snapshot.data;
            print("-===-");
            print("=-090e0iiiie");
            print(data.data());
            print("=-090e0iiiie");
            print("-===-");
            final user = data.data();

            return UserEdit(data: user, uid: widget.uid);
          }),
    );
  }

  final bool _loading = false;
}

class UserEdit extends StatefulWidget {
  const UserEdit({super.key, this.data, this.uid});
  final data, uid;
  @override
  State<UserEdit> createState() => _UserEditState();
}

class _UserEditState extends State<UserEdit> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _emailController.text = widget.data['email'];
    _nameController.text = widget.data['name'];
    _phoneNumberController.text = widget.data['phoneNumber'];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(
          height: 10.0,
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.account_circle_rounded,
              size: 120.0,
            ),
          ],
        ),
        InputField(
          readOnly: true,
          title: "Email",
          controller: _emailController,
        ),
        const SizedBox(
          height: 24.0,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            InputField(
              title: "Username",
              controller: _nameController,
            ),
            const SizedBox(
              height: 24.0,
            ),
            InputField(
              title: "Phone number",
              controller: _phoneNumberController,
            ),
            const SizedBox(
              height: 24.0,
            ),
            AppButton(
              loading: _loading,
              onPress: () async {
                setState(() {
                  _loading = true;
                });
                final data = {
                  "name": _nameController.text.trim(),
                  "email": _emailController.text.trim(),
                  "phoneNumber": _phoneNumberController.text.trim(),
                  "userId": widget.uid
                };
                final req = await firestore
                    .collection("users")
                    .doc(widget.uid)
                    .update(data)
                    .whenComplete(() {
                  defaultSnackyBar(context, "Profile updated", successColor);
                  setState(() {
                    _loading = false;
                  });
                }).catchError((err) {
                  setState(() {
                    _loading = false;
                  });
                });
              },
              title: "Submit",
            )
          ],
        )
      ],
    );
  }

  bool _loading = false;
}
