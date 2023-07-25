import 'package:flutter/material.dart';
import 'package:elib/helpers/page_layout/text_formating.dart';

class TextLink extends StatefulWidget {
  final String? title;

  const TextLink({super.key, this.title = ""});
  @override
  _TextLinkState createState() => _TextLinkState();
}

class _TextLinkState extends State<TextLink> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('${widget.title}',
                style: textStyle.copyWith(
                  color: const Color(0xff00A568),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ))
          ],
        ),
      ),
    );
  }
}
