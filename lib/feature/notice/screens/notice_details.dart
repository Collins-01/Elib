import 'package:elib/helpers/colors.dart';
import 'package:elib/helpers/components/button.dart';
import 'package:elib/helpers/components/flexible_text.dart';
import 'package:elib/helpers/components/input_field.dart';
import 'package:elib/helpers/error_widget.dart';
import 'package:elib/helpers/loaders.dart';
import 'package:elib/helpers/page_layout/page_layout.dart';
import 'package:elib/helpers/page_layout/text_formating.dart';
import 'package:elib/helpers/snakbars.dart';
import 'package:elib/helpers/util_helpers.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
// import 'package:permission_handler/permission_handler.dart';

class NoticeDetails extends StatefulWidget {
  const NoticeDetails({Key? key, this.data, this.id}) : super(key: key);
  final data, id;
  @override
  State<NoticeDetails> createState() => _NoticeDetailsState();
}

class _NoticeDetailsState extends State<NoticeDetails> {
  @override
  Widget build(BuildContext context) {
    return PageLayout(
      title: "",
      appBarColor: bluePrimaryColor,
      leadingNavIconColor: Colors.white,
      appBarElevation: 0.9,
      scaffoldPadding: 0,
      appBarActions: const [TextButton(onPressed: null, child: Text(""))],
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Expanded(
                        child: ImageContainer(
                      url: "${widget.data['banner']}",
                      borderRadius: 0.0,
                    ))
                  ],
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      // Icon(Icons.forum),
                      Expanded(
                        child: FlexibleText(
                            text: "${widget.data['title']}",
                            maxLine: 2,
                            style: textStyle.copyWith(
                              color: textColor,
                              fontSize: 36,
                              fontWeight: FontWeight.w700,
                            )),
                      )
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Divider(),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("posted on: ${widget.data['createdAt']}",
                          style: textStyle.copyWith(
                            color: textColor,
                            fontWeight: FontWeight.w300,
                            fontSize: 12.0,
                          ))
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text("${widget.data['message']}",
                            textAlign: TextAlign.justify,
                            style: textStyle.copyWith(
                                color: textColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w400)),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 40.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Comments",
                        style: textStyle.copyWith(
                          color: textColor,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            setState(() {});
                          },
                          icon: const Icon(Icons.refresh))
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                Container(
                  color: const Color(0xffeeeeee),
                  height: 400.0,
                  child: FutureBuilder(
                      future: firestore
                          .collection("comments")
                          .where('notice_id', isEqualTo: '${widget.id}')
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
                        print("comments");
                        print("-==-");
                        print(data.docs);
                        final comment = data.docs ?? [];

                        return comment.length <= 0
                            ? const Center(
                                child: Text("No comment yet."),
                              )
                            : ListView.builder(
                                padding: const EdgeInsets.all(0),
                                itemCount: comment.length,
                                itemBuilder: (BuildContext context, i) {
                                  final dataa = comment[i].data();

                                  return Column(
                                    children: [
                                      ListTile(
                                        leading: CircleAvatar(
                                          backgroundColor:
                                              const Color(0xff2e7d32),
                                          radius: 20.0,
                                          child: Text(
                                            "${dataa['userEmail'][0].toUpperCase()}",
                                            style: textStyle.copyWith(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ),
                                        contentPadding: const EdgeInsets.all(8),
                                        title: Text("${dataa['userEmail']}"),
                                        subtitle: Text("${dataa['comment']}"),
                                      ),
                                      const Divider()
                                    ],
                                  );
                                },
                              );
                      }),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FloatingActionButton(
                      onPressed: () =>
                          {print("dskjds"), commentOnNotice(context)},
                      child: const Icon(Icons.insert_comment),
                    )
                  ],
                ),
                const SizedBox(
                  height: 50.0,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  commentOnNotice(context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
        ),
        builder: (BuildContext context) {
          return SizedBox(
              height: 85.h,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(
                    height: 5.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text("Cancel")),
                          ],
                        ),
                      ),
                      const Divider(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: PostComment(
                          noticeId: widget.id,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                ],
              ));
        });
  }
}

class ImageContainer extends StatelessWidget {
  final url, borderRadius;
  const ImageContainer({super.key, this.url = "", this.borderRadius = 5});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: Colors.grey,
        image: DecorationImage(
          image: NetworkImage("$url"),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: const Text(''),
    );
  }
}

class PostComment extends StatefulWidget {
  const PostComment({super.key, this.noticeId});
  final noticeId;
  @override
  State<PostComment> createState() => _PostCommentState();
}

class _PostCommentState extends State<PostComment> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  final TextEditingController _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            InputField(
              maxLine: 10,
              title: "Enter a comment",
              hintText: "comment",
              controller: _commentController,
            ),
            const SizedBox(
              height: 10.0,
            ),
            Row(
              children: [
                SizedBox(
                  width: 100,
                  child: AppButton(
                    loading: _loading,
                    title: "Post",
                    onPress: () {
                      if (_formkey.currentState!.validate()) {
                        postCommentAction(context);
                      }
                    },
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  bool _loading = false;
  postCommentAction(context) async {
    setState(() {
      _loading = true;
    });
    final pref = await SharedPreferences.getInstance();
    final email = pref.getString("email");

    final data = {
      "userEmail": email,
      "notice_id": widget.noticeId,
      "comment": _commentController.text.trim(),
      "createdAt": DateTime.now()
    };
    final req = await firestore.collection("comments").add(data).then((value) {
      setState(() {
        _loading = false;
      });
      Navigator.pop(context);
      defaultSnackyBar(context, "Comment Posted", bluePrimaryColor);
      setState(() {});
    }).catchError((err) {
      setState(() {
        _loading = false;
      });
    });
  }
}
