import 'package:elib/feature/notice/screens/notice_details.dart';
import 'package:elib/helpers/error_widget.dart';
import 'package:elib/helpers/loaders.dart';
import 'package:elib/helpers/navigators.dart';
import 'package:elib/helpers/util_helpers.dart';
import 'package:flutter/material.dart';
import 'package:elib/helpers/colors.dart';
import 'package:elib/helpers/components/flexible_text.dart';
import 'package:elib/helpers/page_layout/page_layout.dart';
import 'package:elib/helpers/page_layout/text_formating.dart';
import 'package:jiffy/jiffy.dart';

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
      fontSize: 30,
      appBarColor: primaryColor,
      titleTextColor: Colors.white,

      appBarElevation: 2.0,
      appBarActions:[
        IconButton(
          onPressed:()=>setState(() {}), 
          icon: Icon(Icons.refresh,color:Colors.white,)
        )
      ],
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
                  "Read articles and keep updates on the current happenings with the college. ",
                  style: textStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w400,
                      color: textColor),
                ),
              )
            ],
          ),
          Expanded(
              child: FutureBuilder(
                  future: firestore.collection("notice").get(),
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
                    // print("courses");
                    // print("-==-");
                    // print(data.docs);
                    final courses = data.docs ?? [];
                    return ListView.builder(
                        padding: EdgeInsets.all(0),
                        itemCount: courses.length,
                        itemBuilder: (BuildContext context, i) {
                          final dataa = courses[i].data();
                          // print("noticeid");
                          // print(courses[i].id);
                          return Column(
                            children: [
                              NoticeTab(data: dataa, id: courses[i].id),
                              Divider()
                            ],
                          );
                        });
                  }))
        ],
      ),
    );
  }
}

class NoticeTab extends StatelessWidget {
  final data, id;
  NoticeTab({this.data, this.id});
  @override
  Widget build(BuildContext context) {
    // var date = DateTime.fromMillisecondsSinceEpoch(data['createdAt'] * 1000);
    // var date = data['createdAt'];
    return InkWell(
      onTap: () {

        nextPage(
            context,
            (context) => NoticeDetails(
                  data: data,
                  id: id,
                ));
      },
      child: Container(
        height: 80.0,
        margin: const EdgeInsets.only(top: 10.0),
        child: Row(
          children: [
            ImageContainer(
              url: "${data['banner']}",
            ),
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
                          text: "${data['title']}",
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
                          text: "Department: ${data['department']}",
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
                        child: Text(
                          "${data['createdAt'] }",
                          maxLines: 2,
                          style: textStyle(
                            color: textColor,
                            fontWeight: FontWeight.w300,
                            fontSize: 12.0
                          ),
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
      ),
    );
  }
}

class ImageContainer extends StatelessWidget {
  final url;
  ImageContainer({this.url = ""});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 60,
      decoration: BoxDecoration(
        color: Colors.grey,
        image: DecorationImage(
          image: NetworkImage("${url}"),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      child: const Text(''),
    );
  }
}
