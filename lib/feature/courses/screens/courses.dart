import 'package:elib/feature/courses/screens/course_details.dart';
import 'package:elib/helpers/colors.dart';
import 'package:elib/helpers/error_widget.dart';
import 'package:elib/helpers/loaders.dart';
import 'package:elib/helpers/navigators.dart';
import 'package:elib/helpers/page_layout/text_formating.dart';
import 'package:elib/helpers/util_helpers.dart';
import 'package:elib/helpers/page_layout/page_layout.dart';
import 'package:flutter/material.dart';

class CourseList extends StatefulWidget {
  final program, level, semester, courseName;
  const CourseList(
      {super.key, this.level, this.program, this.semester, this.courseName});
  @override
  State<CourseList> createState() => _CourseListState();
}

class _CourseListState extends State<CourseList> {
  @override
  Widget build(BuildContext context) {
    return PageLayout(
        // navPop: false,
        title: "Courses",
        appBarColor: bluePrimaryColor,
        fontSize: 30.0,
        appBarElevation: 2.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: 10.0,
            ),
            Expanded(
              child: FutureBuilder(
                  future: firestore
                      .collection("courses")
                      // .where("title", isEqualTo: '${widget.courseName}')
                      .where('program', isEqualTo: '${widget.program}')
                      .where('level', isEqualTo: '${widget.level}')
                      .where('semester', isEqualTo: '${widget.semester}')
                      .get(),
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
                    print("courses");
                    print("-==-");
                    print(data.docs);
                    final courses = data.docs ?? [];
                    return courses.length <= 0
                        ? const Center(
                            child: Text("course not found."),
                          )
                        : ListView.builder(
                            padding: const EdgeInsets.all(0),
                            itemCount: courses.length,
                            itemBuilder: (BuildContext context, i) {
                              final dataa = courses[i].data();
                              return Column(
                                children: [
                                  InkWell(
                                    onTap: () => nextPage(
                                        context,
                                        (context) => CourseDetails(
                                              data: dataa,
                                            )),
                                    child: ListTile(
                                      leading: const Icon(Icons.local_library),
                                      contentPadding: const EdgeInsets.all(0),
                                      title: Text("${dataa['title']}"),
                                      subtitle: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                  child: Text(
                                                "${dataa['codeCode']}",
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              )),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                  child: Text(
                                                "${dataa['department']}",
                                                style: textStyle.copyWith(
                                                    fontSize: 12),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              )),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const Divider()
                                ],
                              );
                            });
                  }),
            ),
          ],
        ));
  }
}
