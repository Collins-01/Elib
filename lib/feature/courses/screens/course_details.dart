import 'package:elib/helpers/colors.dart';
import 'package:elib/helpers/page_layout/page_layout.dart';
import 'package:elib/helpers/page_layout/text_formating.dart';
import 'package:elib/helpers/snakbars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:url_launcher/url_launcher.dart';

class CourseDetails extends StatefulWidget {
  const CourseDetails({Key? key, this.data}) : super(key: key);
  final data;
  @override
  State<CourseDetails> createState() => _CourseDetailsState();
}

class _CourseDetailsState extends State<CourseDetails> {
  @override
  Widget build(BuildContext context) {
    return PageLayout(
      title: "Course Details",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ListTile(
            leading: Icon(Icons.local_library),
            contentPadding: EdgeInsets.all(0),
            title: Text("Title"),
            subtitle: Text("${widget.data['title']}"),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.local_library),
            contentPadding: EdgeInsets.all(0),
            title: Text("Course code "),
            subtitle: Text("${widget.data['courseCode']}"),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.local_library),
            contentPadding: EdgeInsets.all(0),
            title: Text("Tutor"),
            subtitle: Text("${widget.data['authors']}"),
          ),
          Divider(),
          InkWell(
            onTap: () async {
              final url = "${widget.data['coursePdfLink']}";
              await canLaunch(url)
                  ? await launch(url)
                  : throw pageToast('Could not launch $url', dangerColor);
            },
            child: ListTile(
              leading: Icon(Icons.local_library),
              contentPadding: EdgeInsets.all(0),
              title: Text("Course Pdf "),
              subtitle: Text("Link",style:textStyle(
                color:Colors.blue
              ),),
            ),
          ),
          Divider(),
          InkWell(
            onTap: () async {
              final url = "${widget.data['curriculemPdfLink']}";
              await canLaunch(url)
                  ? await launch(url)
                  : throw pageToast('Could not launch $url', dangerColor);
            },
            child: ListTile(
              leading: Icon(Icons.local_library),
              contentPadding: EdgeInsets.all(0),
              title: Text("Course Curriculum "),
              subtitle: Text("Link",style:textStyle(
                color:Colors.blue
              ),),
            ),
          ),
          Divider(),
          InkWell(
            onTap: () async {
              final url = "${widget.data['courseResouresLink']}";
              await canLaunch(url)
                  ? await launch(url)
                  : throw pageToast('Could not launch $url', dangerColor);
            },
            child: ListTile(
              leading: Icon(Icons.local_library),
              contentPadding: EdgeInsets.all(0),
              title: Text("Course Resource link "),
              subtitle: Text("Link",style:textStyle(
                color:Colors.blue
              ),),
            ),
          ),
          Divider(),
        ],
      ),
    );
  }
}
