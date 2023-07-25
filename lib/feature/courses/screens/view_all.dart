import 'package:elib/feature/courses/screens/course_details.dart';
import 'package:elib/helpers/error_widget.dart';
import 'package:elib/helpers/loaders.dart';
import 'package:elib/helpers/navigators.dart';
import 'package:elib/helpers/page_layout/page_layout.dart';
import 'package:elib/helpers/page_layout/text_formating.dart';
import 'package:elib/helpers/util_helpers.dart';
import 'package:flutter/material.dart';

class ViewAllCourses extends StatefulWidget {
  const ViewAllCourses({super.key});

  @override
  State<ViewAllCourses> createState() => _ViewAllCoursesState();
}

class _ViewAllCoursesState extends State<ViewAllCourses> {
  @override
  Widget build(BuildContext context) {
    return PageLayout(
      title: "All Courses",
      appBarActions: const [TextButton(onPressed: null, child: Text(""))],
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
                              leading: const Icon(Icons.book),
                              contentPadding: const EdgeInsets.all(0),
                              title: Text("${dataa['title']}"),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
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
                                        style: textStyle.copyWith(fontSize: 12),
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
    );
  }
}
