import 'package:elib/helpers/colors.dart';
import 'package:elib/helpers/components/flexible_text.dart';
import 'package:elib/helpers/page_layout/page_layout.dart';
import 'package:elib/helpers/page_layout/text_formating.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class NoticeDetails extends StatefulWidget {
  const NoticeDetails({Key? key, this.data}) : super(key: key);
  final data;
  @override
  State<NoticeDetails> createState() => _NoticeDetailsState();
}

class _NoticeDetailsState extends State<NoticeDetails> {
  @override
  Widget build(BuildContext context) {
    return PageLayout(
      title: "",
      appBarColor: Colors.white,
      leadingNavIconColor: Colors.black,
      appBarElevation: 0.9,
      child: Stack(
        children: [
           
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  children: [
                    Expanded(
                        child: ImageContainer(
                      url: "${widget.data['banner']}",
                    ))
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  children: [
                    // Icon(Icons.forum),
                    Expanded(
                      child: FlexibleText(
                        text: "${widget.data['title']}",
                        maxLine: 2,
                        style: textStyle(
                            color: textColor,
                            fontSize: 36,
                            fontWeight: FontWeight.w700),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "${widget.data['message']}",
                        style: textStyle(
                            color: textColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w400),
                      ),
                    )
                  ],
                ),
              
                SizedBox(
                  height: 40.0,
                ),
                Row(
                  children: [
                    Text("Comments",style:textStyle(color:textColor,fontSize:18.0,fontWeight:FontWeight.w700),)
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                SizedBox(
                  height: 500.0,
                  child: ListView.builder(
                    padding:EdgeInsets.all(0),
                    itemCount:10,
                    itemBuilder: (BuildContext context, i) {
                      return Column(
                        children: [
                          ListTile(
                            leading:CircleAvatar(
                              backgroundColor:Color(0xff2e7d32),
                              radius:20.0,
                              child:Text("A",style:textStyle(
                                fontSize:16.0
                              ),),
                            ),
                            contentPadding:EdgeInsets.all(0),
                            title:Text("Ade"),
                            subtitle:Text("Omo dis on go far."),
                          ),
                          Divider()
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment:CrossAxisAlignment.stretch,
            mainAxisAlignment:MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FloatingActionButton(
                    onPressed: () => null,
                    child: Icon(Icons.insert_comment),
                  )
                ],
              ),
              SizedBox(height:50.0,)
            ],
          ),
        ],
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
      height: 200,
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
