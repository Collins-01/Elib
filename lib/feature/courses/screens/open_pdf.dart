import 'dart:async';
import 'dart:io';

import 'package:elib/helpers/colors.dart';
import 'package:elib/helpers/components/button.dart';
import 'package:elib/helpers/page_layout/page_layout.dart';
import 'package:elib/helpers/page_layout/text_formating.dart';
import 'package:elib/helpers/snakbars.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class OpenPdf extends StatefulWidget {
  final urlLink, title;
  OpenPdf({this.urlLink, this.title});
  @override
  _OpenPdfState createState() => _OpenPdfState();
}

class _OpenPdfState extends State<OpenPdf> {
  String pathPDF = "";
  String landscapePathPdf = "";
  String remotePDFpath = "";
  String corruptedPathPDF = "";

  @override
  void initState() {
    super.initState();
    fromAsset('assets/corrupted.pdf', 'corrupted.pdf').then((f) {
      setState(() {
        corruptedPathPDF = f.path;
      });
    });
    fromAsset('assets/demo-link.pdf', 'demo.pdf').then((f) {
      setState(() {
        pathPDF = f.path;
      });
    });
    fromAsset('assets/demo-landscape.pdf', 'landscape.pdf').then((f) {
      setState(() {
        landscapePathPdf = f.path;
      });
    });

    createFileOfPdfUrl().then((f) {
      setState(() {
        remotePDFpath = f.path;
      });
    });
  }

  Future<File> createFileOfPdfUrl() async {
    Completer<File> completer = Completer();
    pageToast("Start downloading file from internet!", primaryColor);
    try {
      // "https://berlin2017.droidcon.cod.newthinking.net/sites/global.droidcon.cod.newthinking.net/files/media/documents/Flutter%20-%2060FPS%20UI%20of%20the%20future%20%20-%20DroidconDE%2017.pdf";
      // final url = "https://pdfkit.org/docs/guide.pdf";
      // final url = "http://www.pdf995.com/samples/pdf.pdf";
      // final url =
      //     "https://firebasestorage.googleapis.com/v0/b/elibrary-8b25d.appspot.com/o/course%2Fflutter_tutorial.pdf?alt=media&token=16c493f3-6b2d-4f59-9d13-6ca88a29811e";
      final url = widget.urlLink;
      final filename = url.substring(url.lastIndexOf("/") + 1);
      var request = await HttpClient().getUrl(Uri.parse(url));
      var response = await request.close();
      var bytes = await consolidateHttpClientResponseBytes(response);
      var dir = await getApplicationDocumentsDirectory();
      print("${dir.path}/$filename");
      File file = File("${dir.path}/$filename");

      await file.writeAsBytes(bytes, flush: true);
      completer.complete(file);
      pageToast("Download files", primaryColor);
      setState(() {
        notReadyToOpen = false;
      });
    } catch (e) {
      throw Exception('Error parsing asset file!');
    }

    return completer.future;
  }

  Future<File> fromAsset(String asset, String filename) async {
    // To open from assets, you can copy them to the app storage folder, and the access them "locally"
    Completer<File> completer = Completer();

    try {
      var dir = await getApplicationDocumentsDirectory();
      File file = File("${dir.path}/$filename");
      var data = await rootBundle.load(asset);
      var bytes = data.buffer.asUint8List();
      await file.writeAsBytes(bytes, flush: true);
      completer.complete(file);
    } catch (e) {
      throw Exception('Error parsing asset file!');
    }

    return completer.future;
  }

  bool notReadyToOpen = true;
  @override
  Widget build(BuildContext context) {
    return PageLayout(
      // home: Scaffold(
        title:widget.title,
        appBarActions: [
          TextButton(onPressed: null, child:Text(""))
        ],
        // appBar: AppBar(
        //   title: Text('${widget.title}'),
        //   backgroundColor: primaryColor,
        // ),
        // body: Center(child: Builder(
        child: Center(child: Builder(
          builder: (BuildContext context) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // TextButton(
                //   child: Text("Open PDF"),
                //   onPressed: () {
                //     if (pathPDF.isNotEmpty) {
                //       Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //           builder: (context) => PDFScreen(path: pathPDF),
                //         ),
                //       );
                //     }
                //   },
                // ),
                // TextButton(
                //   child: Text("Open Landscape PDF"),
                //   onPressed: () {
                //     if (landscapePathPdf.isNotEmpty) {
                //       Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //           builder: (context) =>
                //               PDFScreen(path: landscapePathPdf),
                //         ),
                //       );
                //     }
                //   },
                // ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: AppButton(
                    borderColor: notReadyToOpen ? Colors.grey : primaryColor,
                    color: notReadyToOpen ? Colors.grey : primaryColor,
                    loading: notReadyToOpen,
                    title: "Open PDF",
                    onPress: notReadyToOpen
                        ? null
                        : () {
                            if (remotePDFpath.isNotEmpty) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      PDFScreen(path: remotePDFpath),
                                ),
                              );
                            }
                          },
                  ),
                ),
                // TextButton(
                //   child: Text("Open Corrupted PDF"),
                //   onPressed: () {
                //     if (pathPDF.isNotEmpty) {
                //       Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //           builder: (context) =>
                //               PDFScreen(path: corruptedPathPDF),
                //         ),
                //       );
                //     }
                //   },
                // )
              ],
            );
          },
        )),
      
    );
  }
}

class PDFScreen extends StatefulWidget {
  final String? path;

  PDFScreen({Key? key, this.path}) : super(key: key);

  _PDFScreenState createState() => _PDFScreenState();
}

class _PDFScreenState extends State<PDFScreen> with WidgetsBindingObserver {
  final Completer<PDFViewController> _controller =
      Completer<PDFViewController>();
  int? pages = 0;
  int? currentPage = 1;
  bool isReady = false;
  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Document"),
        backgroundColor:primaryColor,
       
      ),
      body: Column(
        crossAxisAlignment:CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(mainAxisAlignment:MainAxisAlignment.end,
              children: [
                Text("${currentPage}/${pages}")
              ],
            ),
          ),
          Expanded(
            child: Stack(
              children: <Widget>[
                PDFView(
                  filePath: widget.path,
                  enableSwipe: true,
                  swipeHorizontal:false,
                  autoSpacing: false,
                  pageFling: true,
                  pageSnap: true,
                  defaultPage: currentPage!,
                  fitPolicy: FitPolicy.BOTH,
                  preventLinkNavigation:
                      false, // if set to true the link is handled in flutter
                  onRender: (_pages) {
                    setState(() {
                      pages = _pages;
                      isReady = true;
                    });
                  },
                  onError: (error) {
                    setState(() {
                      errorMessage = error.toString();
                    });
                    print(error.toString());
                  },
                  onPageError: (page, error) {
                    setState(() {
                      errorMessage = '$page: ${error.toString()}';
                    });
                    print('$page: ${error.toString()}');
                  },
                  onViewCreated: (PDFViewController pdfViewController) {
                    _controller.complete(pdfViewController);
                  },
                  onLinkHandler: (String? uri) {
                    print('goto uri: $uri');
                  },
                  onPageChanged: (int? page, int? total) {
                    print('page change: $page/$total');
                    setState(() {
                      currentPage = page;
                    });
                  },
                ),
                errorMessage.isEmpty
                    ? !isReady
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : Container()
                    : Center(
                        child: Text(errorMessage),
                      )
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FutureBuilder<PDFViewController>(
        future: _controller.future,
        builder: (context, AsyncSnapshot<PDFViewController> snapshot) {
          if (snapshot.hasData) {
            return FloatingActionButton.extended(
              foregroundColor:primaryColor,
              backgroundColor: primaryColor,
              label: Text("Go to ${pages! ~/ 2}",style:textStyle(color:Colors.white),),
              onPressed: () async {
                await snapshot.data!.setPage(pages! ~/ 2);
              },
            );
          }

          return Container();
        },
      ),
    );
  }
}