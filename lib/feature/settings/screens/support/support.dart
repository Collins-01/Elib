import 'package:elib/helpers/colors.dart';
import 'package:elib/helpers/page_layout/page_layout.dart';
import 'package:flutter/material.dart';

class Support extends StatefulWidget {
  const Support({super.key});

  @override
  State<Support> createState() => _SupportState();
}

class _SupportState extends State<Support> {
  @override
  Widget build(BuildContext context) {
    return const PageLayout(
      title: "Support",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ListTile(
            leading: CircleAvatar(
              radius: 20,
              backgroundColor: bluePrimaryColor,
              child: Icon(
                Icons.phone,
                color: Colors.white,
              ),
            ),
            contentPadding: EdgeInsets.all(0),
            title: Text('Contact details: '),
            subtitle: Text("09096798763"),
          ),
          Divider(),
          ListTile(
            leading: CircleAvatar(
                radius: 20,
                backgroundColor: bluePrimaryColor,
                child: Icon(
                  Icons.mail,
                  color: Colors.white,
                )),
            contentPadding: EdgeInsets.all(0),
            title: Text('Support mail: '),
            subtitle: Text("studyhub@gmail.com"),
          ),
          Divider(),
        ],
      ),
    );
  }
}
