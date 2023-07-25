import 'package:elib/helpers/components/app_icon.dart';
import 'package:elib/helpers/page_layout/text_formating.dart';
import 'package:flutter/material.dart';
import 'package:elib/helpers/colors.dart';
import 'package:elib/helpers/page_layout/page_layout.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return PageLayout(
        // noAppBar: true,
        navPop: false,
        title: "Home",
        fontSize: 25,
        appBarColor: primaryColor,
        titleTextColor: Colors.white,
        appBarElevation: 2.0,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 100.0,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppIcon(
                    width: 200.0,
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                      child: Text(
                          "Our app allows you access a library of learning resources, including textbooks, documents, and links, all tailored to your curriculum to help you stay on top of your studies and excel in your classes.",
                          textAlign: TextAlign.center,
                          style: textStyle.copyWith(
                            fontSize: 18.0,
                          )))
                ],
              )
            ],
          ),
        ));
  }
}
