import 'package:elib/helpers/page_layout/page_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class SearchCourse extends StatefulWidget {
  const SearchCourse({Key? key}) : super(key: key);

  @override
  State<SearchCourse> createState() => _SearchCourseState();
}

class _SearchCourseState extends State<SearchCourse> {
  @override
  Widget build(BuildContext context) {
    return PageLayout(
      noAppBar:true,
      child:Column(
        children: [
          
        ],
      ),
    );
  }
}
