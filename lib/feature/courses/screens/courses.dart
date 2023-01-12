import 'package:elib/helpers/colors.dart';
import 'package:elib/helpers/error_widget.dart';
import 'package:elib/helpers/loaders.dart';
import 'package:elib/helpers/util_helpers.dart';
import 'package:flutter/cupertino.dart';
import 'package:elib/helpers/page_layout/page_layout.dart';
import 'package:flutter/material.dart';

class CatchUp extends StatefulWidget {
  @override
  State<CatchUp> createState() => _CatchUpState();
}

class _CatchUpState extends State<CatchUp> {
  @override
  Widget build(BuildContext context) {
    return PageLayout(
        navPop: false,
        title: "Courses",
        appBarColor: primaryColor,
        fontSize: 30.0,
        appBarElevation: 2.0,
        child: FutureBuilder(
            future: firestore.collection("course").get(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return const Center(
                  child: spinnerPry,
                );
              }
              if (snapshot.hasError) {
                return ErrorPageWidget();
              }
              final data = snapshot.data.data;
              print("courses");
              print("-==-");
              print(data);
              return ListView.builder(
                itemCount:3,
                itemBuilder: (BuildContext context, i) {
                return const ListTile(
                  leading:Icon(Icons.local_library),
                  contentPadding:EdgeInsets.all(0),
                  title:Text("Book"),
                  subtitle:Text("booker"),
                );
              });
            }));
  }
}
