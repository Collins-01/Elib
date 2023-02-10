import 'package:elib/helpers/colors.dart';
import 'package:elib/helpers/page_layout/page_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Support extends StatefulWidget {
  const Support({super.key});

  @override
  State<Support> createState() => _SupportState();
}

class _SupportState extends State<Support> {
  @override
  Widget build(BuildContext context) {
    return PageLayout(
      title:"Support",
      child:Column(
        crossAxisAlignment:CrossAxisAlignment.stretch,
        children: const [
          ListTile(
            leading:CircleAvatar(
              radius:20,
              backgroundColor:secondaryColor,
              child: Icon(Icons.phone,color:Colors.white,)
            ),
            contentPadding:EdgeInsets.all(0),
            title:Text('contact details: '),
            subtitle:Text("09096798763"),
          ),
          Divider(),
          ListTile(
            leading:CircleAvatar(
              radius:20,
              backgroundColor:secondaryColor,
              child: Icon(Icons.mail,color:Colors.white,)
            ),
            contentPadding:EdgeInsets.all(0),
            title:Text('Support mail: '),
            subtitle:Text("emmanuelonwuka2018@gmail.com"),
          ),
          Divider(),
        ],
      ),
    );
  }
}