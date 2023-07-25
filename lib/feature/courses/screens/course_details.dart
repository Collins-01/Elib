import 'package:elib/feature/courses/screens/open.dart';
import 'package:elib/feature/courses/screens/open_pdf.dart';
import 'package:elib/helpers/colors.dart';
import 'package:elib/helpers/navigators.dart';
import 'package:elib/helpers/page_layout/page_layout.dart';
import 'package:elib/helpers/page_layout/text_formating.dart';
import 'package:elib/helpers/snakbars.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:permission_handler/permission_handler.dart';

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
      appBarActions: const [
        TextButton(
          onPressed: null,
          child: Text(""),
        )
      ],
      child: ListView(
        // crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ListTile(
            leading: const Icon(Icons.local_library),
            contentPadding: const EdgeInsets.all(0),
            title: const Text("Title"),
            subtitle: Text("${widget.data['title']}"),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.local_library),
            contentPadding: const EdgeInsets.all(0),
            title: const Text("Course code "),
            subtitle: Text("${widget.data['codeCode']}"),
          ),
          const Divider(),
          ExpansionTile(
            tilePadding: const EdgeInsets.all(0),
            leading: const Icon(Icons.local_library),
            title: const Text("Course Pdf "),
            children: <Widget>[
              InkWell(
                onTap: () async {
                  final url = "${widget.data['coursePdfLink']}";
                  // final url = Uri("https://firebasestorage.googleapis.com/v0/b/elibrary-8b25d.appspot.com/o/course%2FFundamentals-of-Computer-Programming-with-CSharp-Nakov-eBook-v2013.pdf?alt=media&token=ceff0b7e-15e7-4310-a109-6fd51fc6cecf");
                  print(url);
                  // nextPage(
                  //     context,
                  //     (context) => OpenFileWideget(
                  //           link: "${url}",
                  //           title: "${widget.data['title']}",
                  //         ));

                  nextPage(
                      context,
                      (context) => OpenPdf(
                            urlLink: url,
                            title: "${widget.data['title']}",
                          ));
                },
                child: const ListTile(
                  contentPadding: EdgeInsets.all(0),
                  title: Text("Course Pdf 1"),
                  trailing: Icon(Icons.chevron_right),
                  // subtitle: Text("Link",style:textStyle(
                  //   color:Colors.blue
                  // ),),
                ),
              ),
              InkWell(
                onTap: () async {
                  final url = "${widget.data['coursePdfLink2']}";

                  // nextPage(
                  //     context,
                  //     (context) => OpenFileWideget(
                  //           link: "${url}",
                  //           title: "${widget.data['title']}",
                  //         ));
                  nextPage(
                      context,
                      (context) => OpenPdf(
                            urlLink: url,
                            title: "${widget.data['title']}",
                          ));
                },
                child: const ListTile(
                  contentPadding: EdgeInsets.all(0),
                  title: Text("Course Pdf 2"),
                  trailing: Icon(Icons.chevron_right),

                  // subtitle: Text("Link",style:textStyle(
                  //   color:Colors.blue
                  // ),),
                ),
              ),
              InkWell(
                onTap: () async {
                  final url = "${widget.data['otherCourseFormat']}";
                  // nextPage(
                  //     context,
                  //     (context) => OpenPdf(
                  //           urlLink: url,
                  //           title: "${widget.data['title']}",
                  //         ));

                  await canLaunch(url)
                      ? await launch(url)
                      : throw pageToast('Could not launch $url', dangerColor);
                },
                child: const ListTile(
                  contentPadding: EdgeInsets.all(0),
                  title: Text("other file format"),
                  trailing: Icon(Icons.chevron_right),
                  // subtitle: Text("Link",style:textStyle(
                  //   color:Colors.blue
                  // ),),
                ),
              ),
            ],
          ),
          const Divider(),
          InkWell(
            onTap: () async {
              final url = "${widget.data['curriculemPdfLink']}";
              // nextPage(
              //     context,
              //     (context) => OpenFileWideget(
              //           link: "${url}",
              //           title: "${widget.data['title']}",
              //         ));
              nextPage(
                  context,
                  (context) => OpenPdf(
                        urlLink: url,
                        title: "${widget.data['title']}",
                      ));
            },
            child: const ListTile(
              leading: Icon(Icons.local_library),
              contentPadding: EdgeInsets.all(0),
              title: Text("Course Curriculum "),
              trailing: Icon(Icons.download),
              // subtitle: Text("Link",style:textStyle(
              //   color:Colors.blue
              // ),),
            ),
          ),
          const Divider(),
          InkWell(
            onTap: () async {
              final url = "${widget.data['courseResource']}";

              print("url link $url");
              nextPage(
                  context,
                  (context) => OpenFileWideget(
                        link: url,
                        title: "${widget.data['title']}",
                      ));
            },
            child: ListTile(
              leading: const Icon(Icons.local_library),
              contentPadding: const EdgeInsets.all(0),
              title: Text(
                "Course Resource link ",
                style: textStyle.copyWith(color: Colors.blue),
              ),
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.local_library),
            contentPadding: const EdgeInsets.all(0),
            title: const Text("Tutor"),
            subtitle: Text(
                "${widget.data['authors'] == "Null" ? '' : widget.data['authors']}"),
          ),
        ],
      ),
    );
  }

  // final Dio dio = Dio();
  // bool loading = false;
  // double? progress = 0;

  // Future<bool> saveVideo(String url, String fileName) async {
  //   Directory? directory;
  // try {
  //   if (Platform.isAndroid) {
  //     if (await _requestPermission(Permission.storage)) {
  //       directory = await getExternalStorageDirectory();
  //       String newPath = "";
  //       print(directory);
  //       List<String> paths = directory!.path.split("/");
  //       for (int x = 1; x < paths.length; x++) {
  //         String folder = paths[x];
  //         if (folder != "Android") {
  //           newPath += "/" + folder;
  //         } else {
  //           break;
  //         }
  //       }
  //       newPath = newPath + "/RPSApp";
  //       directory = Directory(newPath);
  //     } else {
  //       return false;
  //     }
  //   } else {
  //     if (await _requestPermission(Permission.photos)) {
  //       directory = await getTemporaryDirectory();
  //     } else {
  //       return false;
  //     }
  //   }
  //   File saveFile = File(directory.path + "/$fileName");
  //   if (!await directory.exists()) {
  //     await directory.create(recursive: true);
  //   }
  //   if (await directory.exists()) {
  //     await dio.download(url, saveFile.path,
  //         onReceiveProgress: (value1, value2) {
  //       setState(() {
  //         progress = (value1 / value2) * 100;
  //       });
  //     });
  //     print("download url${url}");
  //     print("loacal storgae ${saveFile.path}");
  //     if (Platform.isIOS) {
  //       // await ImageGallerySaver!.saveFile(saveFile.path,
  //       //     isReturnPathOfIOS: true);
  //     }
  //     return true;
  //   }
  //   return false;
  // } catch (e) {
  //   print(e);
  //   return false;
  // }
}

  // Future<bool> _requestPermission(Permission permission) async {
  //   if (await permission.isGranted) {
  //     return true;
  //   } else {
  //     var result = await permission.request();
  //     if (result == PermissionStatus.granted) {
  //       return true;
  //     }
  //   }
  //   return false;
  // }

  // downloadFile(downloadUrl, fileName) async {
    // setState(() {
    //   loading = true;
    //   progress = 0;
    // });
    // bool downloaded = await saveVideo(downloadUrl, fileName);
    // if (downloaded) {
    //   defaultSnackyBar(context, "File Downloaded", primaryColor);
    // } else {
    //   defaultSnackyBar(context, "Problem Downloading File", dangerColor);
    // }
    // setState(() {
    //   loading = false;
    // });
  // }
// }
