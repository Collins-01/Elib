import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:elib/helpers/colors.dart';
import 'package:elib/helpers/components/flexible_text.dart';
import 'package:elib/helpers/page_layout/page_layout.dart';
import 'package:elib/helpers/page_layout/text_formating.dart';

class Blog extends StatefulWidget {
  @override
  State<Blog> createState() => _BlogState();
}

class _BlogState extends State<Blog> {
  @override
  Widget build(BuildContext context) {
    return PageLayout(
      // title:'Blog',
      title: 'Notice',
      navPop: false,
      fontSize:30,
      appBarColor:primaryColor,
      titleTextColor:Colors.white,
      appBarElevation:2.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(
            height: 27,
          ),
          
         
          Row(
            children: [
              Expanded(
                child: Text(
                  "Read articles on gists surrounding entertainment, fashion, and so many others. ",
                  style: textStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400,
                      color: textColor),
                ),
              )
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount:2,
              itemBuilder:(BuildContext context, index){
                return NoticeTab();
              }
            ),
          )
        ],
      ),
    );
  }
}

class NoticeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120.0,
      margin: const EdgeInsets.only(top: 10.0),
      child: Row(
        children: [
          ImageContainer(),
          const SizedBox(
            width: 10.0,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(
                  height: 10.0,
                ),
                Row(
                  children: [
                    Expanded(
                      child: FlexibleText(
                        text: "Funke Akindele’s house warming party. ",
                        maxLine: 2,
                        style: textStyle(
                            color: textColor,
                            fontWeight: FontWeight.w700,
                            fontSize: 14.0),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 4.0,
                ),
                Row(
                  children: [
                    Expanded(
                      child: FlexibleText(
                        text: "By Jide Indimi ",
                        maxLine: 2,
                        style: textStyle(
                            color: textColor,
                            fontWeight: FontWeight.w400,
                            fontSize: 12.0),
                      ),
                    )
                  ],
                ),
                const Expanded(child: Text("")),
                Row(
                  children: [
                    Expanded(
                      child: FlexibleText(
                        text: "Today: 1:30pm ",
                        maxLine: 2,
                        style: textStyle(
                            color: textColor,
                            fontWeight: FontWeight.w300,
                            fontSize: 12.0),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10.0,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class ImageContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 129,
      decoration: BoxDecoration(
        color: Colors.grey,
        image: const DecorationImage(
          image: NetworkImage(""),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(2),
      ),
      child: const Text(''),
    );
  }
}
