import 'package:elib/feature/courses/screens/course_details.dart';
import 'package:elib/helpers/colors.dart';
import 'package:elib/helpers/error_widget.dart';
import 'package:elib/helpers/loaders.dart';
import 'package:elib/helpers/navigators.dart';
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
        child: Column(
          crossAxisAlignment:CrossAxisAlignment.stretch,
          children: [
            SizedBox(height:10.0,),
            Expanded(
              child: FutureBuilder(
                  future: firestore.collection("courses").get(),
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
                    print("courses");
                    print("-==-");
                    print(data.docs);
                    final courses = data.docs ?? [];
                    return ListView.builder(
                        padding:EdgeInsets.all(0),
                        itemCount: courses.length,
                        itemBuilder: (BuildContext context, i) {
                          final dataa = courses[i].data();
                          return Column(
                            children: [
                              InkWell(
                                onTap:()=>nextPage(context,(context)=>CourseDetails(
                                  data:dataa,
                                )),
                                child: ListTile(
                                  leading: Icon(Icons.local_library),
                                  contentPadding: EdgeInsets.all(0),
                                  title: Text("${dataa['title']}"),
                                  subtitle: Column(
                                    crossAxisAlignment:CrossAxisAlignment.stretch,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text("${dataa['school']}",
                                            maxLines:1,
                                            overflow:TextOverflow.ellipsis,)
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text("by ${dataa['authors']}",
                                              maxLines:1,
                                              overflow:TextOverflow.ellipsis,
                                            )
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Divider()
                            ],
                          );
                        });
                  }),
            ),
          ],
        ));
  }
}
