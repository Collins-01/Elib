import 'dart:async';
import 'package:elib/helpers/loaders.dart';
import 'package:elib/helpers/page_layout/page_layout.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class OpenFileWideget extends StatefulWidget {
  OpenFileWideget({super.key, this.link,this.title});
  String? link,title;
  @override
  State<OpenFileWideget> createState() => _OpenFileWidegetState();
}

class _OpenFileWidegetState extends State<OpenFileWideget> {
  @override
  Widget build(BuildContext context) {
    final controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
            print("P==${progress}");
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse('${widget.link}'));
    return PageLayout(
      title: "${widget.title}",
      scaffoldPadding: 0,
      appBarActions: [
        IconButton(
          onPressed: (){
              setState(() {
              loading = true;
            });
            Timer(
                Duration(seconds: 2),
                () => {
                      setState(() {
                        loading = false;
                      })
                    });
          },
          icon:const Icon(
            Icons.refresh,
            color: Colors.white,
          )
        )
      ],
      // child:WebViewWidget(controller: controller),
      child: Stack(
        children: [
          Center(
            child: spinnerPry,
          ),
          loading?Text(""):WebViewWidget(controller: controller),
        ],
      ),
    );
  }

  bool loading = false;
}
