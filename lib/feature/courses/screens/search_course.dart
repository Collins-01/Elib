import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elib/feature/courses/screens/courses.dart';
import 'package:elib/feature/courses/screens/view_all.dart';
import 'package:elib/helpers/colors.dart';
import 'package:elib/helpers/components/button.dart';
import 'package:elib/helpers/components/dropdown_fields.dart';
import 'package:elib/helpers/components/input_field.dart';
import 'package:elib/helpers/navigators.dart';
import 'package:elib/helpers/page_layout/page_layout.dart';
import 'package:elib/helpers/page_layout/text_formating.dart';
import 'package:elib/helpers/snakbars.dart';
import 'package:elib/helpers/util_helpers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class SearchCourse extends StatefulWidget {
  const SearchCourse({Key? key}) : super(key: key);

  @override
  State<SearchCourse> createState() => _SearchCourseState();
}

class _SearchCourseState extends State<SearchCourse> {
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final TextEditingController _searchTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return PageLayout(
      navPop: false,
      title: "Courses",
      appBarColor: primaryColor,
      fontSize: 30.0,
      appBarElevation: 2.0,
      appBarActions: [
        TextButton(
            onPressed: () => nextPage(context, (context) => ViewAllCourses()),
            child: Text(
              "View all",
              style: textStyle(color: Colors.white),
            ))
      ],
      // child:Column(
      //   crossAxisAlignment:CrossAxisAlignment.stretch,
      //   children: [
      //     Form(
      //       key:_formkey,
      //       child: Row(
      //         children: [
      //           Expanded(child: InputField()),
      //           InkWell(
      //             onTap:(){
      //               if(_formkey.currentState!.validate()){
      //                 searchAction(context);
      //               }
      //             },
      //             child:Icon(Icons.search)
      //           )
      //         ],
      //       ),
      //     ),
      //   ],
      // ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 50.0,
            ),
            DropdownField(
              titleFontSize: 16.0,
              titleSpacing: 7.0,
              titleFontWeight: FontWeight.w500,
              title: "Program",
              items: const [
                'Pick a program',
                'full-time',
                'part-time',
              ],
              initValue: 'Pick a program',
              onChange: (val) {
                setState(() {
                  program = val!;
                  level = 'hnd1';
                });
              },
            ),
            SizedBox(
              height: 10.0,
            ),
            program != 'part-time'
                ? DropdownField(
                    titleFontSize: 16.0,
                    titleSpacing: 7.0,
                    titleFontWeight: FontWeight.w500,
                    title: "Level",
                    items: [
                      'Pick a level',
                      'hnd1',
                      'hnd2',
                    ],
                    initValue: 'Pick a level',
                    onChange: (val) {
                      setState(() {
                        level = val!;
                      });
                    },
                  )
                : DropdownField(
                    titleFontSize: 16.0,
                    titleSpacing: 7.0,
                    titleFontWeight: FontWeight.w500,
                    title: "Level",
                    items: [
                      'Pick a level',
                      'hnd1',
                      'hnd2',
                      'hnd3',
                    ],
                    initValue: 'Pick a level',
                    onChange: (val) {
                      setState(() {
                        level = val!;
                      });
                    },
                  ),
            SizedBox(
              height: 10.0,
            ),
            DropdownField(
              titleFontSize: 16.0,
              titleSpacing: 7.0,
              titleFontWeight: FontWeight.w500,
              title: "Semester",
              items: const [
                'Pick a semester',
                'first-semester',
                'second-semester',
              ],
              initValue: 'Pick a semester',
              onChange: (val) {
                setState(() {
                  semester = val!;
                });
              },
            ),
            SizedBox(
              height: 60.0,
            ),
            AppButton(
              onPress: () => searchAction(context),
              title: "Search course",
            )
          ],
        ),
      ),
    );
  }

  String program = 'Pick a program';
  String semester = 'Pick a semester';
  String level = 'Pick a level';
  searchAction(context) async {
    print("eada");
    print(program);
    print(level);
    print(semester);

    // List<QueryDocumentSnapshot> courses = await firestore
    //     .collection("courses")
    //     .where('program', isEqualTo: '${program}')
    //     .where('level', isEqualTo: '${level}')
    //     // .where('semester', isEqualTo: '${semester}')
    //     .get()
    //     .then((snapshot) => snapshot.docs);

    // print(courses);
    if (semester == 'Pick a semester' ||
        program == 'Pick a program' ||
        level == 'Pick a level') {
      defaultSnackyBar(context,"All fields are required.", dangerColor);
    } else {
      nextPage(
          context,
          (context) => CourseList(
                courseName: _searchTextController.text.trim().toLowerCase(),
                semester: semester,
                level: level,
                program: program,
              ));
    }
  }
}
